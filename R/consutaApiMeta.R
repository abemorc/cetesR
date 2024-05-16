

#' Consulta de metadatos en la API de banxico
#'
#' @inheritParams consultaApiDatos
#'
#' @return [data.frame()] con las siguientes columnas:
#'    * idSerie Código de la serie
#'    * titulo Nombre de la serie
#'    * fechaInicio Fecha inicial desde la que se tiene registro
#'    * fechaFin Fecha hasta la que se tiene registro
#'    * periodicidad Frecuencia con la que se actualiza la información
#'    * cifra .
#'    * unidad Unidad de medida con la que se expresa la serie
#'    * versionada `TRUE` o `FALSE`
#' @export
#'
#' @examples
#' token <- "fb88d18e41bebb656375cd9b4db5878253b564b3742935ca96c9bd9fb67e1274"
#' metadatos <- consultaApiMeta("SF43936", token = token)
#'
consultaApiMeta <- function(codigo, token, idioma="es") {

  sitio <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  language <- paste0("?locale=", idioma)
  solicitud <- paste0(sitio, codigo, language)
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")
  respuesta <- httr::GET(solicitud, encabezado)

  if(respuesta$status_code==200) {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    datosReady <- datosRaw$bmx$series

    datosReady["fechaInicio"] <- as.Date(datosReady[,"fechaInicio"], format = "%d/%m/%Y")
    datosReady["fechaFin"] <- as.Date(datosReady[,"fechaFin"], format = "%d/%m/%Y")


    return(datosReady)

  } else {
    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    mensaje <- datosRaw$error$mensaje
    detalle <- datosRaw$error$detalle

    stop(paste(mensaje,": ",detalle))
  }
}
