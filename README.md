
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cetesR

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cetesR)](https://CRAN.R-project.org/package=cetesR)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Herramientas para trabajar con valores gubernamentales de México

## Instalación

Usted puede instalar este paquete en su distribucion de R desde
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("abemorc/cetesR")
```

## Ojetivo

Poder obtener y analizar informacón actualizada relacionada a los
valores gubernamentales

## Uso

``` r
library(cetesR)

token <- '98f028f762387fd81728858fca4cc4e1ddaa4c538e3d6209f256a6a0ef25021b'

getBono(bono = 'cetes28', fechaInicial = '2023-12-01', fechaFinal = Sys.Date(), token)
#> $Metadatos
#>   idSerie
#> 1 SF43936
#>                                                                                                                                           titulo
#> 1 Valores gubernamentales                        Resultados de la subasta semanal Tasa de rendimiento                            Cetes a 28 días
#>   fechaInicio   fechaFin periodicidad       cifra      unidad versionada
#> 1  1982-09-02 2024-05-16       Diaria Porcentajes Porcentajes      FALSE
#> 
#> $cetes28_Datos
#>    Fecha_emision Plazo Monto_asignado Tasa_rendimiento Fecharedencion
#> 1     2023-12-07    28           8500            11.25     2024-01-04
#> 2     2023-12-14    28           8500            11.25     2024-01-11
#> 3     2023-12-21    28           6000            11.09     2024-01-18
#> 4     2023-12-28    28           8500            11.26     2024-01-25
#> 5     2024-01-04    28          15000            11.30     2024-02-01
#> 6     2024-01-11    28          15000            11.28     2024-02-08
#> 7     2024-01-18    28          10000            11.30     2024-02-15
#> 8     2024-01-25    28          10000            11.28     2024-02-22
#> 9     2024-02-01    28          10000            11.15     2024-02-29
#> 10    2024-02-08    28          10000            11.06     2024-03-07
#> 11    2024-02-15    28          10000            11.05     2024-03-14
#> 12    2024-02-22    28          10000            11.00     2024-03-21
#> 13    2024-02-29    27          10000            11.00     2024-03-27
#> 14    2024-03-07    28          10000            11.00     2024-04-04
#> 15    2024-03-14    28          18000            11.18     2024-04-11
#> 16    2024-03-21    28          10000            10.99     2024-04-18
#> 17    2024-03-27    29          10000            10.90     2024-04-25
#> 18    2024-04-04    28          10000            10.88     2024-05-02
#> 19    2024-04-11    28          10000            10.92     2024-05-09
#> 20    2024-04-18    28          10000            11.04     2024-05-16
#> 21    2024-04-25    28          10000            11.04     2024-05-23
#> 22    2024-05-02    28          10000            10.95     2024-05-30
#> 23    2024-05-09    28          10000            11.03     2024-06-06
#> 24    2024-05-16    28          10000            10.95     2024-06-13
#> 
#> $Mercado_secundario
#> # A tibble: 12 × 8
#>    Name       Yield Prev.  High   Low  Chg. `Chg. %` Time 
#>    <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <chr>    <chr>
#>  1 Mexico 1M  11.5  11.0  11.0  11.0  0.576 +5.25%   15/05
#>  2 Mexico 3M  11.6  11.2  11.2  11.2  0.478 +4.28%   15/05
#>  3 Mexico 6M  11.6  11.3  11.3  11.3  0.331 +2.94%   15/05
#>  4 Mexico 9M  11.4  11.3  11.4  11.4  0.152 +1.35%   14/05
#>  5 Mexico 1Y  11.3  11.3  11.3  11.3  0.01  0.09%    15/05
#>  6 Mexico 3Y  10.3   9.95 10.0   9.95 0.392 +3.93%   15/05
#>  7 Mexico 5Y  10.1   9.69  9.72  9.69 0.377 +3.88%   15/05
#>  8 Mexico 7Y  10.0   9.65  9.67  9.65 0.359 +3.72%   15/05
#>  9 Mexico 10Y  9.98  9.61  9.63  9.61 0.363 +3.78%   15/05
#> 10 Mexico 15Y 10.0   9.66  9.69  9.66 0.371 +3.84%   15/05
#> 11 Mexico 20Y 10.1   9.72  9.78  9.72 0.375 +3.85%   15/05
#> 12 Mexico 30Y 10.1   9.70  9.76  9.70 0.375 +3.86%   15/05
```

Estos son los principales instrumentos que se puede evaluar

``` r

catalogo_series
#> # A tibble: 16 × 4
#>    Instrumento Plazo    Monto_Asignado Tasa_Rendimiento
#>    <chr>       <chr>    <chr>          <chr>           
#>  1 cetes28     SF43935  SF43937        SF43936         
#>  2 cetes91     SF43938  SF43940        SF43939         
#>  3 cetes182    SF43941  SF43943        SF43942         
#>  4 cetes364    SF43944  SF43946        SF43945         
#>  5 cetes728    SF349778 SF349780       SF349785        
#>  6 bonosM3     SF43882  SF43884        SF43883         
#>  7 bonosM5     SF43885  SF43887        SF43886         
#>  8 bonosM7     SF44945  SF44947        SF44946         
#>  9 bonosM10    SF44070  SF44072        SF44071         
#> 10 bonosM20    SF45383  SF45385        SF45384         
#> 11 bonosM30    SF60689  SF60690        SF60696         
#> 12 udibonos3   SF61593  SF61594        SF61592         
#> 13 udibonos5   SF43926  SF43928        SF43927         
#> 14 udibonos10  SF43923  SF43925        SF43924         
#> 15 udibonos20  SF46957  SF46959        SF46958         
#> 16 udibonos30  SF46960  SF46962        SF46961
```

``` r
summary(catalogo_series)
#>  Instrumento           Plazo           Monto_Asignado     Tasa_Rendimiento  
#>  Length:16          Length:16          Length:16          Length:16         
#>  Class :character   Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
```

Obtener la informacion correspondiente al instrumento financiero

``` r

webscrapBonos()
#> # A tibble: 12 × 8
#>    Name       Yield Prev.  High   Low  Chg. `Chg. %` Time 
#>    <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <chr>    <chr>
#>  1 Mexico 1M  11.5  11.0  11.0  11.0  0.576 +5.25%   15/05
#>  2 Mexico 3M  11.6  11.2  11.2  11.2  0.478 +4.28%   15/05
#>  3 Mexico 6M  11.6  11.3  11.3  11.3  0.331 +2.94%   15/05
#>  4 Mexico 9M  11.4  11.3  11.4  11.4  0.152 +1.35%   14/05
#>  5 Mexico 1Y  11.3  11.3  11.3  11.3  0.01  0.09%    15/05
#>  6 Mexico 3Y  10.3   9.95 10.0   9.95 0.392 +3.93%   15/05
#>  7 Mexico 5Y  10.1   9.69  9.72  9.69 0.377 +3.88%   15/05
#>  8 Mexico 7Y  10.0   9.65  9.67  9.65 0.359 +3.72%   15/05
#>  9 Mexico 10Y  9.98  9.61  9.63  9.61 0.363 +3.78%   15/05
#> 10 Mexico 15Y 10.0   9.66  9.69  9.66 0.371 +3.84%   15/05
#> 11 Mexico 20Y 10.1   9.72  9.78  9.72 0.375 +3.85%   15/05
#> 12 Mexico 30Y 10.1   9.70  9.76  9.70 0.375 +3.86%   15/05
```

Ejemplo de consulta del la informacion correspondiente a la ultima
subasta de los cetes

``` r
datos <- consultaApiDatoUltimo("SF43936", token = token)
```

Ejemplo de los metadatos obtenidos

``` r
consultaApiMeta("SF43936", token = token)
#>   idSerie
#> 1 SF43936
#>                                                                                                                                           titulo
#> 1 Valores gubernamentales                        Resultados de la subasta semanal Tasa de rendimiento                            Cetes a 28 días
#>   fechaInicio   fechaFin periodicidad       cifra      unidad versionada
#> 1  1982-09-02 2024-05-16       Diaria Porcentajes Porcentajes      FALSE
```

Ejemplo del historico de datos de los cetes

``` r
consultaApiDatos("SF43936", '2023-11-01' ,Sys.Date(), token = token)
#>         Fecha SF43936
#> 1  2023-11-01   11.09
#> 2  2023-11-09   10.95
#> 3  2023-11-16   10.87
#> 4  2023-11-23   10.75
#> 5  2023-11-30   10.78
#> 6  2023-12-07   11.25
#> 7  2023-12-14   11.25
#> 8  2023-12-21   11.09
#> 9  2023-12-28   11.26
#> 10 2024-01-04   11.30
#> 11 2024-01-11   11.28
#> 12 2024-01-18   11.30
#> 13 2024-01-25   11.28
#> 14 2024-02-01   11.15
#> 15 2024-02-08   11.06
#> 16 2024-02-15   11.05
#> 17 2024-02-22   11.00
#> 18 2024-02-29   11.00
#> 19 2024-03-07   11.00
#> 20 2024-03-14   11.18
#> 21 2024-03-21   10.99
#> 22 2024-03-27   10.90
#> 23 2024-04-04   10.88
#> 24 2024-04-11   10.92
#> 25 2024-04-18   11.04
#> 26 2024-04-25   11.04
#> 27 2024-05-02   10.95
#> 28 2024-05-09   11.03
#> 29 2024-05-16   10.95
```

Informacion obtenida de www.banxico.com
