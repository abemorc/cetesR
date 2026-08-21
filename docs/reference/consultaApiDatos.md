# Consulta de Datos Históricos en la API de Banxico,

Extrae la serie de tiempo histórica de un instrumento financiero
directamente desde el Sistema de Información Económica (SIE) del Banco
de México (Banxico).

## Usage

``` r
consultaApiDatos(
  codigo,
  fechaInicial = NULL,
  fechaFinal = NULL,
  token = Sys.getenv("BANXICO_TOKEN"),
  idioma = "es"
)
```

## Arguments

- codigo:

  `character` Código exacto de la serie de tiempo a consultar. Puede
  buscar el código correspondiente a cada instrumento mediante el
  dataset interno `catalogo_series`.

- fechaInicial:

  `character` o `Date`. Fecha a partir de la cual se quiere consultar
  los datos (formato "YYYY-MM-DD").

- fechaFinal:

  `character` o `Date`. Fecha hasta la cual se quiere consultar los
  datos. Se recomienda usar
  [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html) para la fecha
  actual.

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

Un `data.frame` estructurado con dos columnas:

- **Fecha**: Clase `Date`.

- **Código de la serie**: Clase `numeric` con los valores
  correspondientes.

## Details

Esta función realiza una petición HTTP tipo GET a la API REST de
Banxico. Procesa la respuesta en formato JSON, estructura los datos y
realiza la conversión automática de tipos (las fechas se transforman a
clase `Date` y los valores a clase `numeric`).

En caso de que el servidor devuelva un error (como un token inválido,
exceder el límite de consultas o solicitar una serie inexistente), la
función captura y muestra el mensaje oficial detallado de Banxico.

## Examples

``` r
if (FALSE) { # \dontrun{
# 1. Configurar el token previamente
# set_banxico_token("TU_TOKEN_AQUI")

# 2. Consultar la serie histórica (ej. Tasa de rendimiento CETES 28)
datos_cetes <- consultaApiDatos(
  codigo = "SF43936",
  fechaInicial = '2020-01-01',
  fechaFinal = Sys.Date()
)

head(datos_cetes)
} # }
```
