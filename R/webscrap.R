


#' WebscrapBonos
#'
#' Proporciona informacion en tiempo real del mercado secundario de bonos, la
#' informacion es obtenida de www.investing.com.
#'
#' @return [data.frame()] con la informacion actualizada
#' @export
#'
#' @examples
#' webscrapBonos()
webscrapBonos <- function(){

  pagina <- "https://www.investing.com/rates-bonds/world-government-bonds"

  htmlpagina <- xml2::read_html(pagina)
  # tabla <-rvest::html_element(htmlpagina, css = '#rates_bonds_table_53')
  tabla1 <- rvest::html_element(htmlpagina, xpath = '//*[(@id = "rates_bonds_table_53")]')


  tablalista <- rvest::html_table(tabla1)




  index <- names(tablalista)!=""

  # tablalista[index]
  return(dplyr::as_tibble(tablalista[index]))
}
