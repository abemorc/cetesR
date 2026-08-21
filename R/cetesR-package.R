#' cetesR: Herramientas para Valores Gubernamentales de México
#'
#' @description
#' El paquete \code{cetesR} proporciona funciones para consultar, procesar y
#' analizar información financiera de los valores gubernamentales de México
#' (CETES, Bonos M y Udibonos). Extrae datos directamente desde la API oficial
#' del Banco de México (Banxico) y complementa las series con cotizaciones
#' del mercado secundario.
#'
#' @details
#' Las funciones principales incluidas en el paquete son:
#' \itemize{
#'   \item \code{\link{getBono}}: Función principal para obtener el historial consolidado, plazos, montos y tasas de un bono.
#'   \item \code{\link{set_banxico_token}}: Administrador para configurar el token de la API de Banxico.
#'   \item \code{\link{consultaApiDatos}}: Consulta directa de series históricas en la API de Banxico.
#'   \item \code{\link{consultaApiDatoUltimo}}: Consulta del dato más reciente publicado para una serie.
#'   \item \code{\link{consultaApiMeta}}: Extracción de metadatos de las series de Banxico.
#'   \item \code{\link{catalogo_series}}: Dataset interno con la tabla de mapeo de identificadores y series.
#' }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr distinct full_join mutate
#' @importFrom httr add_headers GET
#' @importFrom jsonlite fromJSON
#' @importFrom lubridate days ymd
#' @importFrom utils globalVariables
## usethis namespace: end
NULL

