# Web scraping para datos del mercado secundario

#' Cotizaciones en Tiempo Real del Mercado Secundario
#'
#' @description
#' Extrae información en tiempo real de los rendimientos de los bonos
#' gubernamentales de México cotizados en el mercado secundario.
#'
#' @details
#' Esta función utiliza técnicas de web scraping para leer la tabla de
#' cotizaciones directamente desde el portal financiero Investing.com.
#'
#' IMPORTANTE: Dado que esta función depende de la estructura HTML de un
#' sitio web externo, existe la posibilidad de que falle si el proveedor cambia
#' el diseño de su página (por ejemplo, si alteran el identificador de la tabla).
#' Para mitigar esto, se han incluido rutinas de manejo de errores que, en caso de
#' fallo, devuelven un valor nulo (\code{NULL}) emitiendo una advertencia,
#' permitiendo que el flujo de análisis principal no se interrumpa abruptamente.
#'
#' @return Un \code{data.frame} (tipo \code{tibble}) con la información
#'   actualizada de los rendimientos de los bonos. Si la extracción falla
#'   debido a problemas de red o cambios en el sitio web, devuelve \code{NULL}.
#' @export
#'
#' @examples
#' \dontrun{
#' # Extraer la tabla de mercado secundario de Investing.com
#' mercado_secundario <- webscrapBonos()
#'
#' print(mercado_secundario)
#' }
webscrapBonos <- function() {

  pagina <- "https://www.investing.com/rates-bonds/world-government-bonds"

  # Bloque de captura de errores para evitar fallos críticos
  tryCatch({
    htmlpagina <- xml2::read_html(pagina)

    # Buscar la tabla específica de México por su XPath
    tabla1 <- rvest::html_element(htmlpagina, xpath = '//*[(@id = "rates_bonds_table_53")]')

    # Validar si la tabla fue encontrada
    if (is.na(tabla1)) {
      stop("No se pudo ubicar la tabla HTML. El sitio web podria haber cambiado su diseno.", call. = FALSE)
    }

    tablalista <- rvest::html_table(tabla1)

    # Filtrar nombres de columnas vacíos
    index <- names(tablalista) != ""

    # Convertir a tibble extrayendo solo las columnas válidas
    return(dplyr::as_tibble(tablalista[, index]))

  }, error = function(e) {
    # Si ocurre un error de red o de scraping, emitimos una advertencia y devolvemos NULL
    warning(paste("No se pudo obtener informacion del mercado secundario:", e$message), call. = FALSE)
    return(NULL)
  })



}
