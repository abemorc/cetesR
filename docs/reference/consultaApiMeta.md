# Consulta de Metadatos en la API de Banxico

Extrae la información descriptiva (metadatos) asociada a una serie de
tiempo específica desde el Sistema de Información Económica (SIE) de
Banxico.

## Usage

``` r
consultaApiMeta(codigo, token = Sys.getenv("BANXICO_TOKEN"), idioma = "es")
```

## Arguments

- codigo:

  `character` Código exacto de la serie de tiempo a consultar. Puede
  buscar el código correspondiente a cada instrumento mediante el
  dataset interno `catalogo_series`.

- token:

  `character`. Token de autenticación proporcionado por Banxico. Por
  defecto, lo busca en la variable de entorno `BANXICO_TOKEN`. Se
  recomienda configurarlo previamente con
  [`set_banxico_token()`](https://abemorc.github.io/cetesR/reference/set_banxico_token.md).

- idioma:

  `character` Idioma para la consulta de los metadatos devueltos por el
  servidor.

  - "es" Español (por defecto).

  - "en" Inglés.

## Value

Un `data.frame` de una sola fila con las siguientes columnas:

- **idSerie**: Código identificador de la serie.

- **titulo**: Nombre descriptivo de la serie.

- **fechaInicio**: Clase `Date`. Fecha inicial desde la que se tiene
  registro.

- **fechaFin**: Clase `Date`. Fecha de la última actualización
  disponible.

- **periodicidad**: Frecuencia con la que se actualiza la información
  (ej. Semanal).

- **cifra**: Tipo de cifra (ej. Oportuna, Revisada).

- **unidad**: Unidad de medida con la que se expresa la serie.

- **versionada**: `logical`. `TRUE` o `FALSE` si la serie tiene
  múltiples versiones.

## Details

Esta función es útil para conocer el contexto de la información antes de
descargar los datos históricos. Permite verificar la fecha en la que
inicia el registro, la periodicidad de actualización y la unidad de
medida en la que está expresada la serie (ej. porcentajes, millones de
pesos).

## Examples

``` r
if (FALSE) { # \dontrun{
# 1. Asegúrate de tener configurado tu token
# set_banxico_token("TU_TOKEN_AQUI")

# 2. Consultar los metadatos de la Tasa de rendimiento de CETES 28
metadatos <- consultaApiMeta(codigo = "SF43936")

print(metadatos)
} # }
```
