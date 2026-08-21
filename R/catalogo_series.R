#' Catálogo Oficial de Series de Valores Gubernamentales
#'
#' @description
#' Un conjunto de datos (dataset) interno que funciona como tabla de mapeo
#' para identificar los códigos específicos de las series de tiempo en la
#' API del Sistema de Información Económica (SIE) de Banco de México (Banxico).
#'
#' @details
#' Este catálogo es fundamental para el funcionamiento del paquete \code{cetesR}.
#' Vincula el nombre común de un instrumento financiero (por ejemplo, "cetes28")
#' con los identificadores exactos (ID de serie) requeridos por la API de Banxico
#' para poder extraer la información histórica de los plazos, montos asignados y
#' tasas de rendimiento derivados de las subastas primarias.
#'
#' @format Un objeto de clase \code{data.frame} con 16 filas y 4 variables:
#' \describe{
#'   \item{Instrumento}{\code{character}. Identificador corto del instrumento financiero (ej. "cetes28", "bonosM10").}
#'   \item{Plazo}{\code{character}. Código de serie en Banxico correspondiente al plazo del instrumento.}
#'   \item{Monto_Asignado}{\code{character}. Código de serie en Banxico correspondiente al monto asignado (en millones de pesos) durante la subasta semanal.}
#'   \item{Tasa_Rendimiento}{\code{character}. Código de serie en Banxico correspondiente a la tasa de rendimiento o de descuento de la subasta.}
#' }
#'
#' @source Banco de México (Banxico) - Sistema de Información Económica (SIE) API. \url{https://www.banxico.org.mx/SieAPIRest/}
"catalogo_series"
