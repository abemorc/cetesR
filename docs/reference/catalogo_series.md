# Catálogo Oficial de Series de Valores Gubernamentales

Un conjunto de datos (dataset) interno que funciona como tabla de mapeo
para identificar los códigos específicos de las series de tiempo en la
API del Sistema de Información Económica (SIE) de Banco de México
(Banxico).

## Usage

``` r
catalogo_series
```

## Format

Un objeto de clase `data.frame` con 16 filas y 4 variables:

- Instrumento:

  `character`. Identificador corto del instrumento financiero (ej.
  "cetes28", "bonosM10").

- Plazo:

  `character`. Código de serie en Banxico correspondiente al plazo del
  instrumento.

- Monto_Asignado:

  `character`. Código de serie en Banxico correspondiente al monto
  asignado (en millones de pesos) durante la subasta semanal.

- Tasa_Rendimiento:

  `character`. Código de serie en Banxico correspondiente a la tasa de
  rendimiento o de descuento de la subasta.

## Source

Banco de México (Banxico) - Sistema de Información Económica (SIE) API.
<https://www.banxico.org.mx/SieAPIRest/>

## Details

Este catálogo es fundamental para el funcionamiento del paquete
`cetesR`. Vincula el nombre común de un instrumento financiero (por
ejemplo, "cetes28") con los identificadores exactos (ID de serie)
requeridos por la API de Banxico para poder extraer la información
histórica de los plazos, montos asignados y tasas de rendimiento
derivados de las subastas primarias.
