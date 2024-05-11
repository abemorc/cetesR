## code to prepare `catalogo_series` dataset goes here

library(readr)

columnas <- cols(
  Instrumento = col_character(),
  Plazo = col_character(),
  Monto_Asignado = col_character(),
  Tasa_Rendimiento = col_character()
)

catalogo_series <- readr::read_csv(file = "data-raw/catalogo_series.csv",
                                   col_types = columnas)


usethis::use_data(catalogo_series, overwrite = TRUE)



