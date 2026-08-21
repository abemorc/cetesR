# Consulta de información histórica desde la API de Banxico

#' Consulta de Datos Históricos en la API de Banxico
#'
#' @description
#' Extrae la serie de tiempo histórica de un instrumento financiero directamente
#' desde el Sistema de Información Económica (SIE) del Banco de México (Banxico).
#'
#' @details
#' Esta función realiza una petición HTTP tipo GET a la API REST de Banxico.
#' Procesa la respuesta en formato JSON, estructura los datos y realiza la
#' conversión automática de tipos (las fechas se transforman a clase \code{Date}
#' y los valores a clase \code{numeric}).
#'
#' En caso de que el servidor devuelva un error (como un token inválido, exceder
#' el límite de consultas o solicitar una serie inexistente), la función captura
#' y muestra el mensaje oficial detallado de Banxico.
#'
#' @param codigo \code{character} Código exacto de la serie de tiempo a consultar.
#'   Puede buscar el código correspondiente a cada instrumento mediante el dataset interno \code{catalogo_series}.
#' @param fechaInicial \code{character} o \code{Date}. Fecha a partir de la cual se quiere consultar los datos (formato "YYYY-MM-DD").
#' @param fechaFinal \code{character} o \code{Date}. Fecha hasta la cual se quiere consultar los datos. Se recomienda usar \code{Sys.Date()} para la fecha actual.
#' @param token \code{character}. Token de autenticación proporcionado por Banxico.
#'   Por defecto, lo busca en la variable de entorno \code{BANXICO_TOKEN}.
#'   Se recomienda configurarlo previamente con \code{set_banxico_token()}.
#' @param idioma \code{character} Idioma para la consulta de los metadatos devueltos por el servidor.
#'   \itemize{
#'     \item "es" Español (por defecto).
#'     \item "en" Inglés.
#'   }
#'
#' @return Un \code{data.frame} estructurado con dos columnas:
#'   \itemize{
#'     \item \strong{Fecha}: Clase \code{Date}.
#'     \item \strong{Código de la serie}: Clase \code{numeric} con los valores correspondientes.
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # 1. Configurar el token previamente
#' # set_banxico_token("TU_TOKEN_AQUI")
#'
#' # 2. Consultar la serie histórica (ej. Tasa de rendimiento CETES 28)
#' datos_cetes <- consultaApiDatos(
#'   codigo = "SF43936",
#'   fechaInicial = '2020-01-01',
#'   fechaFinal = Sys.Date()
#' )
#'
#' head(datos_cetes)
#' }
consultaApiDatos <- function(codigo, fechaInicial = NULL, fechaFinal = NULL,
                             token = Sys.getenv("BANXICO_TOKEN"),
                             idioma = "es") {

  # Validación de seguridad del token
  if (identical(token, "")) {
    stop("No se encontro un token de Banxico. Por favor, usa la funcion set_banxico_token('TU_TOKEN').", call. = FALSE)
  }

  # Crear solicitud a la API
  sitio <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  language <- paste0("?locale=", idioma)
  fechas <- paste(fechaInicial, fechaFinal, sep = "/")

  solicitud <- paste0(sitio, codigo, "/datos/", fechas, language)
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")

  # Ejecutar petición
  respuesta <- httr::GET(solicitud, encabezado)

  # Validar respuesta del servidor
  if (respuesta$status_code == 200) {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)

    datosReady <- datosRaw$bmx$series$datos[[1]]
    names(datosReady) <- c("Fecha", codigo)

    # Limpieza y conversión de tipos de datos
    datosReady[[1]] <- as.Date(datosReady[[1]], "%d/%m/%Y")
    datosReady[[2]] <- suppressWarnings(as.numeric(gsub(",", "", datosReady[[2]], fixed = TRUE)))

    return(datosReady)

  } else {

    # Manejo estructurado de errores desde la API
    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)

    mensaje <- datosRaw$error$mensaje
    detalle <- datosRaw$error$detalle

    stop(paste0("Error de Banxico (", respuesta$status_code, "): ", mensaje, " - ", detalle), call. = FALSE)
  }
}
