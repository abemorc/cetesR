#' Catálogo de las series de valores gubernamentales en México.
#'
#' Principales series de tiempo relacionadas a los valores gubernamentales en
#' México para consulta en la API del banco nacional.
#'
#' @format A data frame with 16 rows and 4 variables:
#' \describe{
#'   \item{Instrumento}{Nombre del instrumento financiero}
#'   \item{Plazo}{Número de días o años asignados en la subasta semanal}
#'   \item{Monto_Asignado}{Cantidad de dinero asignada por el banco nacional a este intrumento}
#'   \item{Tasa_Rendimiento}{Tasa de rendimiento derivada de la subasta semanal}
#' }
#' @source \url{Banxico}
"catalogo_series"
