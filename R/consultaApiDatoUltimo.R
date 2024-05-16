
#' Consulta del valor mas reciente de la serie de datos
#'
#' @inheritParams consultaApiDatos
#'
#' @return [data.frame()] con las siguientes columnas:
#'    * **Fecha**
#'    * **Código de la serie**
#' @export
#'
#' @examples
#' token <- "fb88d18e41bebb656375cd9b4db5878253b564b3742935ca96c9bd9fb67e1274"
#' datos <- consultaApiDatoUltimo("SF43936", token = token)
#'
consultaApiDatoUltimo <- function(codigo, token) {

  url <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  direccion <- "/datos/oportuno"
  idioma <- "?locale=es"
  # series <- paste(seriesArr, sep = ",", collapse = ",")

  solicitud <- paste0(url, codigo, direccion, idioma)
  # token <- localEnv$BmxToken
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")

  respuesta <- httr::GET(solicitud, encabezado)

  if(respuesta$status_code==200) {

    contenidoJson = rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    datosReady <- datosRaw$bmx$series$datos[[1]]

    names(datosReady) <- c("Fecha", codigo)


    datosReady[1] <- as.Date(datosReady[,1], "%d/%m/%Y")
    datosReady[2] <- suppressWarnings(as.numeric(gsub(",", "", datosReady[,2], fixed = TRUE)))

    return(datosReady)
  } else {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    mensaje <- datosRaw$error$mensaje
    detalle <- datosRaw$error$detalle


    stop(paste(mensaje,": ",detalle))
  }
}

