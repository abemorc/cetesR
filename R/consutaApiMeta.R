
# Consulta de metadatos de las series desde la API de Banxico

#' Consulta de Metadatos en la API de Banxico
#'
#' @description
#' Extrae la información descriptiva (metadatos) asociada a una serie de tiempo
#' específica desde el Sistema de Información Económica (SIE) de Banxico.
#'
#' @details
#' Esta función es útil para conocer el contexto de la información antes de
#' descargar los datos históricos. Permite verificar la fecha en la que inicia
#' el registro, la periodicidad de actualización y la unidad de medida en la
#' que está expresada la serie (ej. porcentajes, millones de pesos).
#'
#' @inheritParams consultaApiDatos
#'
#' @return Un \code{data.frame} de una sola fila con las siguientes columnas:
#'   \itemize{
#'     \item \strong{idSerie}: Código identificador de la serie.
#'     \item \strong{titulo}: Nombre descriptivo de la serie.
#'     \item \strong{fechaInicio}: Clase \code{Date}. Fecha inicial desde la que se tiene registro.
#'     \item \strong{fechaFin}: Clase \code{Date}. Fecha de la última actualización disponible.
#'     \item \strong{periodicidad}: Frecuencia con la que se actualiza la información (ej. Semanal).
#'     \item \strong{cifra}: Tipo de cifra (ej. Oportuna, Revisada).
#'     \item \strong{unidad}: Unidad de medida con la que se expresa la serie.
#'     \item \strong{versionada}: \code{logical}. \code{TRUE} o \code{FALSE} si la serie tiene múltiples versiones.
#'   }
#' @export
#'
#' @examples
#' \dontrun{
#' # 1. Asegúrate de tener configurado tu token
#' # set_banxico_token("TU_TOKEN_AQUI")
#'
#' # 2. Consultar los metadatos de la Tasa de rendimiento de CETES 28
#' metadatos <- consultaApiMeta(codigo = "SF43936")
#'
#' print(metadatos)
#' }
consultaApiMeta <- function(codigo, token = Sys.getenv("BANXICO_TOKEN"), idioma = "es") {

  # Validación de seguridad del token
  if (identical(token, "")) {
    stop("No se encontro un token de Banxico. Por favor, usa la funcion set_banxico_token('TU_TOKEN').", call. = FALSE)
  }

  sitio <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  language <- paste0("?locale=", idioma)

  solicitud <- paste0(sitio, codigo, language)
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")

  respuesta <- httr::GET(solicitud, encabezado)

  if (respuesta$status_code == 200) {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    datosReady <- datosRaw$bmx$series

    # Limpieza y conversión de tipos de datos de forma segura
    datosReady[["fechaInicio"]] <- as.Date(datosReady[["fechaInicio"]], format = "%d/%m/%Y")
    datosReady[["fechaFin"]] <- as.Date(datosReady[["fechaFin"]], format = "%d/%m/%Y")

    return(datosReady)

  } else {

    # Manejo estructurado de errores
    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)

    mensaje <- datosRaw$error$mensaje
    detalle <- datosRaw$error$detalle

    stop(paste0("Error de Banxico (", respuesta$status_code, "): ", mensaje, " - ", detalle), call. = FALSE)
  }
}

