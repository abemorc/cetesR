
# Función principal para la consulta de información integral
# acerca de un instrumento gubernamental en particular.

#' Información Integral de Bonos Gubernamentales (CETES, Bonos M, Udibonos)
#'
#' @description
#' Obtiene, procesa y consolida la información histórica y actual referente a un
#' Bono Gubernamental de México. La función actúa como un orquestador que extrae
#' datos primarios desde la API del Banco de México (Banxico) y los enriquece con
#' información del mercado secundario obtenida de portales financieros.
#'
#' @details
#' Esta es la función principal (wrapper) del paquete para la extracción de datos.
#' A partir de un identificador de instrumento (ej. "cetes28"), la función realiza
#' internamente las siguientes operaciones:
#' \itemize{
#'   \item Identifica y consulta las series correspondientes de Banxico para plazo, monto asignado y tasa de rendimiento.
#'   \item Extrae la información histórica para el rango de fechas especificado.
#'   \item Extrae el último dato publicado para garantizar que la serie esté completamente al día.
#'   \item Cruza y consolida (mediante \code{full_join}) las distintas series en un único \code{data.frame} estructurado.
#'   \item Calcula automáticamente la fecha de redención del instrumento.
#'   \item Adjunta los metadatos oficiales y la cotización actual del mercado secundario.
#' }
#'
#' @param bono \code{character} Nombre del bono gubernamental a consultar.
#'   Debe ser uno de los definidos en el catálogo oficial: \code{c("cetes28",
#'   "cetes91", "cetes182", "cetes364", "cetes728", "bonosM3", "bonosM5",
#'   "bonosM7", "bonosM10", "bonosM20", "bonosM30", "udibonos3", "udibonos5",
#'   "udibonos10", "udibonos20", "udibonos30")}.
#' @param fechaInicial \code{character} o \code{Date}. Fecha de inicio de la serie histórica (ej. "2023-01-01").
#' @param fechaFinal \code{character} o \code{Date}. Fecha de fin de la serie. Se recomienda usar \code{Sys.Date()} para traer la información hasta el día de hoy.
#' @param token \code{character}. Token de autenticación proporcionado por Banxico.
#'   Por defecto, la función lo buscará automáticamente en las variables de entorno del sistema (\code{BANXICO_TOKEN}).
#'   Si no está configurado, utilice primero la función \code{set_banxico_token()}.
#' @param idioma \code{character} Idioma deseado para los metadatos devueltos por la API de Banxico.
#'   \itemize{
#'     \item "es" (Español) - Valor por defecto.
#'     \item "en" (Inglés).
#'   }
#'
#' @return Una \code{list} con nombre que contiene tres elementos:
#'   \item{Metadatos}{Un \code{data.frame} con la descripción oficial de la serie según Banxico.}
#'   \item{Datos_instrumento}{Un \code{data.frame} consolidado con las columnas: \code{Fecha_emision}, \code{Plazo}, \code{Monto_asignado}, \code{Tasa_rendimiento} y \code{Fecharedencion}.}
#'   \item{Mercado_secundario}{Un \code{data.frame} con las últimas cotizaciones del instrumento extraídas mediante web scraping.}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # 1. Asegúrate de haber configurado tu token previamente:
#' # set_banxico_token("TU_TOKEN_AQUI")
#'
#' # 2. Consultar el desempeño de los CETES a 28 días desde 2023
#' cetes_28_info <- getBono(
#'   bono = 'cetes28',
#'   fechaInicial = '2023-01-01',
#'   fechaFinal = Sys.Date()
#' )
#'
#' # 3. Acceder al data frame principal con las tasas históricas
#' head(cetes_28_info$cetes28_Datos)
#' }
getBono <- function(bono, fechaInicial, fechaFinal, token = Sys.getenv("BANXICO_TOKEN"), idioma="es") {

  # Validación de seguridad: Comprobar existencia del token
  if (identical(token, "")) {
    stop("No se encontro un token de Banxico. Por favor, usa la funcion set_banxico_token('TU_TOKEN').", call. = FALSE)
  }

  datos1 <- cetesR::catalogo_series
  instrumentos <- datos1$Instrumento

  # validar inputs --------------------
  if(length(bono)!=1) stop("Proporcione un solo intrumento a la vez")
  if(!(bono %in% instrumentos)) stop("Error: Bono debes ser un instrumento del catalogo de series")


  # seleccionar series a consultar ------------------
  index <- which(instrumentos %in% bono)

  codigos <- c(datos1[index,2, drop=T],
               datos1[index,3, drop=T],
               datos1[index,4, drop=T])


  # crear los data frames de cada serie------------------

  # ultimos datos
  dfUltimoPlazo <- consultaApiDatoUltimo(codigo = codigos[1], token = token)
  dfUltimoMonto <- consultaApiDatoUltimo(codigo = codigos[2], token = token)
  dfUltimoRendimiento <- consultaApiDatoUltimo(codigo = codigos[3], token = token)


  # historicos
  dfMeta <- consultaApiMeta(codigo = codigos[3], token = token, idioma = idioma)

  dfPlazo <- consultaApiDatos(codigo = codigos[1], fechaInicial = fechaInicial,
                              fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoPlazo)

  dfMonto <- consultaApiDatos(codigo = codigos[2], fechaInicial = fechaInicial,
                              fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoMonto)

  dfTasa <- consultaApiDatos(codigo = codigos[3], fechaInicial = fechaInicial,
                             fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoRendimiento)


  dfBono <- dfPlazo |>
    dplyr::full_join(dfMonto, by = "Fecha") |>
    dplyr::full_join(dfTasa, by = "Fecha") |>
    dplyr::distinct()

  names(dfBono) <- c("Fecha_emision", "Plazo", "Monto_asignado", "Tasa_rendimiento")

  dfBonoReady <- dfBono |>
    dplyr::mutate(Fecharedencion = lubridate::ymd(Fecha_emision) + lubridate::days(Plazo))


  # informacion del mercado secundario
  dfSecundario <- webscrapBonos()

  listaInfo <- list(dfMeta, dfBonoReady, dfSecundario)
  names(listaInfo) <- c("Metadatos", paste0(bono, "_Datos"), "Mercado_secundario")


  # Retornar valor
  return(listaInfo)
}

utils::globalVariables(c("Fecha_emision", "Plazo"))
