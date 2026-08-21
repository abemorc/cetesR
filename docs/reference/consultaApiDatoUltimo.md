# Consulta del Valor Más Reciente de una Serie

Extrae el último dato oportuno publicado para una serie de tiempo
específica directamente desde la API del Banco de México (Banxico).

## Usage

``` r
consultaApiDatoUltimo(codigo, token = Sys.getenv("BANXICO_TOKEN"))
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

## Value

Un `data.frame` de una sola fila con las siguientes columnas:

- **Fecha**: Clase `Date` correspondiente a la observación.

- **Código de la serie**: Clase `numeric` con el valor oportuno.

## Details

A diferencia de `consultaApiDatos` que extrae un rango histórico, esta
función utiliza el endpoint `/datos/oportuno` para obtener
exclusivamente la observación más reciente disponible. Es ideal para
actualizar análisis, documentos o paneles de control con la última
subasta sin tener que descargar todo el historial.

Procesa automáticamente la respuesta, convirtiendo la fecha a clase
`Date` y el valor a clase `numeric`. Incluye manejo de errores HTTP
estructurado.

## Examples

``` r
if (FALSE) { # \dontrun{
# 1. Asegúrate de tener configurado tu token
# set_banxico_token("TU_TOKEN_AQUI")

# 2. Obtener el último dato de la Tasa de rendimiento de CETES 28
ultimo_cetes <- consultaApiDatoUltimo(codigo = "SF43936")

print(ultimo_cetes)
} # }
```
