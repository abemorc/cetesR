


# Consulta desde la api de banxico



#' Consulta de datos en la API de banxico
#'
#' @param codigo Código de la serie de tiempo a consultar, puede consultar el
#'   código mediante [catalogo_series()].
#' @param fechaInicial Fecha a partir de la cual se quiere consultar los datos.
#' @param fechaFinal Fecha hasta la cual se quiere consultar los datos, puede
#'   usar [Sys.Date()] para que la fecha de la consulta sea hasta la fecha
#'   actual
#' @param token Token proporcionado por Banxico para la consulta. Puede
#'   obtenerlo en la pagina de
#'   [Banxico](https://www.banxico.org.mx/SieAPIRest/service/v1/token)
#' @param idioma `character`  Idioma para la consulta de los metadatos.
#'    * "es" Español
#'    * "en" Inglés
#'
#'
#' @return [data.frame()] con las siguientes columnas:
#'    * **Fecha**
#'    * **Código de la serie**
#' @export
#'
#' @examples
#' token <- "fb88d18e41bebb656375cd9b4db5878253b564b3742935ca96c9bd9fb67e1274"
#' datos <- consultaApiDatos("SF43936", '2020-01-01', Sys.Date(), token = token)
#'
consultaApiDatos <- function(codigo, fechaInicial = NULL, fechaFinal = NULL,
                             token,
                             idioma="es") {

  # Crear solicitud

  sitio <- "https://www.banxico.org.mx/SieAPIRest/service/v1/series/"
  language <- paste0("?locale=", idioma)
  fechas <- paste(fechaInicial, fechaFinal, sep = "/")

  solicitud <- paste0(sitio, codigo, "/datos/", fechas, language)
  encabezado <- httr::add_headers("Bmx-Token" = token, "Accept" = "application/json")
  respuesta <- httr::GET(solicitud, encabezado)

  # validar respuesta del servidor
  if(respuesta$status_code==200) {

    contenidoJson <- rawToChar(respuesta$content)
    # bmxObject <- jsonlite::fromJSON(jSonResponse)
    datosRaw <- jsonlite::fromJSON(contenidoJson)

    # datosReady <- bmxObject$bmx$series$datos[[1]]
    datosReady <- datosRaw$bmx$series$datos[[1]]
    names(datosReady) <- c("Fecha", codigo)


    datosReady[1] <- as.Date(datosReady[,1], "%d/%m/%Y")
    datosReady[2] <- suppressWarnings(as.numeric(gsub(",", "", datosReady[,2], fixed = TRUE)))

    return(datosReady)

  }

  else {

    contenidoJson <- rawToChar(respuesta$content)
    datosRaw <- jsonlite::fromJSON(contenidoJson)
    mensaje <- datosRaw$error$mensaje
    detalle <- datosRaw$error$detalle


    stop(paste(mensaje,": ",detalle))
  }
}



