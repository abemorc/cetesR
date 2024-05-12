
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cetesR

<!-- badges: start -->
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

``` r
library(cetesR)
## Aqui ira un ejemplo
```

## Uso

Estos son los principales instrumentos que se puede evaluar

``` r

catalogo_series
#>    Instrumento    Plazo Monto_Asignado Tasa_Rendimiento
#> 1      cetes28  SF43935        SF43937          SF43936
#> 2      cetes91  SF43938        SF43940          SF43939
#> 3     cetes182  SF43941        SF43943          SF43942
#> 4     cetes364  SF43944        SF43946          SF43945
#> 5     cetes728 SF349778       SF349780         SF349785
#> 6      bonosM3  SF43882        SF43884          SF43883
#> 7      bonosM5  SF43885        SF43887          SF43886
#> 8      bonosM7  SF44945        SF44947          SF44946
#> 9     bonosM10  SF44070        SF44072          SF44071
#> 10    bonosM20  SF45383        SF45385          SF45384
#> 11    bonosM30  SF60689        SF60690          SF60696
#> 12   udibonos3  SF61593        SF61594          SF61592
#> 13   udibonos5  SF43926        SF43928          SF43927
#> 14  udibonos10  SF43923        SF43925          SF43924
#> 15  udibonos20  SF46957        SF46959          SF46958
#> 16  udibonos30  SF46960        SF46962          SF46961
```

``` r
summary(catalogo_series)
#>  Instrumento           Plazo           Monto_Asignado     Tasa_Rendimiento  
#>  Length:16          Length:16          Length:16          Length:16         
#>  Class :character   Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
```

Calculo del precio asi como de las fechas exactas de la inversión,
considerando el calendario festivo´de México.

``` r
pm_workdays
#>  [1] "2024-04-01" "2024-04-02" "2024-04-03" "2024-04-04" "2024-04-05"
#>  [6] "2024-04-08" "2024-04-09" "2024-04-10" "2024-04-11" "2024-04-12"
#> [11] "2024-04-15" "2024-04-16" "2024-04-17" "2024-04-18" "2024-04-19"
#> [16] "2024-04-22" "2024-04-23" "2024-04-24" "2024-04-25" "2024-04-26"
#> [21] "2024-04-29" "2024-04-30"
```

# Importante

Esta version aun no esta terminada, falta corregir algunos bugs
