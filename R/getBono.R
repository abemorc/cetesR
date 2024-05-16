

# funcion para consulta de informacion completa
# acerca de un instrumento en particular

#' Información Bono Gubernamental
#'
#' Obtiene la informacion actualizada referente a un Bono Gubernamental de
#' México, esta informacion es btenida desde la API de Banxico y sitios de
#' informacion financiera.
#'
#' @param bono `characther`  Nombre del bono gubernamental del que se va a
#'   obtener la información, puede ser uno de los siguientes: c("cetes28",
#'   "cetes91", "cetes182", "cetes364", "cetes728", "bonosM3", "bonosM5",
#'   "bonosM7", "bonosM10", "bonosM20", "bonosM30", "udibonos3", "udibonos5",
#'   "udibonos10", "udibonos20", "udibonos30")
#' @param fechaInicial Fecha a partir de la cual se desea obtner la información
#' @param fechaFinal Fecha hasta donde se desea obtener la informacion, puede
#'   usar [Sys.Date()] para obtener la informacion hasta la fecha actual
#' @param token Token proporcionado por Banxico para la consulta. Puede
#'   obtenerlo en la pagina de
#'   [Banxico](https://www.banxico.org.mx/SieAPIRest/service/v1/token)
#' @param idioma `character`  Idioma para la consulta de los metadatos.
#'    * "es" Español
#'    * "en" Inglés
#'   Por default la informacion se obtiene en español
#'
#' @return [list()] con los siguientes elementos:
#'    * **Metadatos de la información de la tasa**
#'    * **Data.Frame con la información procesada**
#'    * **Informacion del mercado secundario**
#'
#' @export
#'
#' @examples
#' token <- '98f028f762387fd81728858fca4cc4e1ddaa4c538e3d6209f256a6a0ef25021b'
#' cetes28 <- getBono(bono = 'cetes28', fechaInicial = '2024-01-01',
#' fechaFinal = Sys.Date(), token = token)

getBono <- function(bono, fechaInicial, fechaFinal, token, idioma="es") {

  datos1 <- cetesR::catalogo_series
  instrumentos <- datos1$Instrumento
  # validar inputs --------------------
  if(length(bono)!=1) stop("Proporcione un solo intrumento a la vez")
  if(!(bono %in% instrumentos)) stop("Error: Bono debes ser un instrumento del catalogo de series")


  # seleccionar series a consultar ------------------
  # Aqui me falta hacer esta parte
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
    dplyr::mutate(Fecharedencion = lubridate::ymd(Fecha_emision)+lubridate::days(Plazo))


  # informacion del mercado secundario
  dfSecundario <- webscrapBonos()

  listaInfo <- list(dfMeta, dfBonoReady, dfSecundario)
  names(listaInfo) <- c("Metadatos", paste0(bono, "_Datos"), "Mercado_secundario")


  # Retornar valor
  return(listaInfo)
}

# Fecha_emision <- Plazo <- catalogo_series <- NULL
# utils::globalVariables(c("Fecha_emision", "Plazo", "catalogo_series"))
utils::globalVariables(c("Fecha_emision", "Plazo"))

