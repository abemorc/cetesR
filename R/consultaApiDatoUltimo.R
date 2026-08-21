# Consulta de la información más reciente desde la API de Banxico

#' Consulta del Valor Más Reciente de una Serie
#'
#' @description
#' Extrae el último dato oportuno publicado para una serie de tiempo específica
#' directamente desde la API del Banco de México (Banxico).
#'
#' @details
#' A diferencia de \code{consultaApiDatos} que extrae un rango histórico, esta
#' función utiliza el endpoint \code{/datos/oportuno} para obtener exclusivamente
#' la observación más reciente disponible. Es ideal para actualizar análisis,
#' documentos o paneles de control con la última subasta sin tener que descargar
#' todo el historial.
#'
#' Procesa automáticamente la respuesta, convirtiendo la fecha a clase \code{Date}
#' y el valor a clase \code{numeric}. Incluye manejo de errores HTTP estructurado.
#'
#' @inheritParams consultaApiDatos
#'
#' @return Un \code{data.frame} de una sola fila con las siguientes columnas:
#'   \itemize{
#'     \item \strong{Fecha}: Clase \code{Date} correspondiente a la observación.
#'     \item \strong{Código de la serie}: Clase \code{numeric} con el valor oportuno.
#'   }
#' @export
#'
#' @examples
#' \dontrun{
#' # 1. Asegúrate de tener configurado tu token
#' # set_banxico_token("TU_TOKEN_AQUI")
#'
#' # 2. Obtener el último dato de la Tasa de rendimiento de CETES 28
#' ultimo_cetes <- consultaApiDatoUltimo(codigo = "SF43936")
#'
#' print(ultimo_cetes)
#' }
consultaApiDatoUltimo <- function(codigo, token = Sys.getenv("BANXICO_TOKEN")) {

  # Validación de seguridad del token
  if (identical(token, "")) {
    stop("No se encontro un token de Banxico. Por favor, usa la funcion set_banxico_token('TU_TOKEN').", call. = FALSE)
  }

  url <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  direccion <- "/datos/oportuno"
  idioma <- "?locale=es"

  solicitud <- paste0(url, codigo, direccion, idioma)
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")

  respuesta <- httr::GET(solicitud, encabezado)

  if (respuesta$status_code == 200) {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    datosReady <- datosRaw$bmx$series$datos[[1]]

    names(datosReady) <- c("Fecha", codigo)

    # Limpieza y conversión de tipos de datos de forma segura
    datosReady[[1]] <- as.Date(datosReady[[1]], "%d/%m/%Y")
    datosReady[[2]] <- suppressWarnings(as.numeric(gsub(",", "", datosReady[[2]], fixed = TRUE)))

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
