# Información Integral de Bonos Gubernamentales (CETES, Bonos M, Udibonos)

Obtiene, procesa y consolida la información histórica y actual referente
a un Bono Gubernamental de México. La función actúa como un orquestador
que extrae datos primarios desde la API del Banco de México (Banxico) y
los enriquece con información del mercado secundario obtenida de
portales financieros.

## Usage

``` r
getBono(
  bono,
  fechaInicial,
  fechaFinal,
  token = Sys.getenv("BANXICO_TOKEN"),
  idioma = "es"
)
```

## Arguments

- bono:

  `character` Nombre del bono gubernamental a consultar. Debe ser uno de
  los definidos en el catálogo oficial:
  `c("cetes28", "cetes91", "cetes182", "cetes364", "cetes728", "bonosM3", "bonosM5", "bonosM7", "bonosM10", "bonosM20", "bonosM30", "udibonos3", "udibonos5", "udibonos10", "udibonos20", "udibonos30")`.

- fechaInicial:

  `character` o `Date`. Fecha de inicio de la serie histórica (ej.
  "2023-01-01").

- fechaFinal:

  `character` o `Date`. Fecha de fin de la serie. Se recomienda usar
  [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html) para traer la
  información hasta el día de hoy.

- token:

  `character`. Token de autenticación proporcionado por Banxico. Por
  defecto, la función lo buscará automáticamente en las variables de
  entorno del sistema (`BANXICO_TOKEN`). Si no está configurado, utilice
  primero la función
  [`set_banxico_token()`](https://abemorc.github.io/cetesR/reference/set_banxico_token.md).

- idioma:

  `character` Idioma deseado para los metadatos devueltos por la API de
  Banxico.

  - "es" (Español) - Valor por defecto.

  - "en" (Inglés).

## Value

Una `list` con nombre que contiene tres elementos:

- Metadatos:

  Un `data.frame` con la descripción oficial de la serie según Banxico.

- Datos_instrumento:

  Un `data.frame` consolidado con las columnas: `Fecha_emision`,
  `Plazo`, `Monto_asignado`, `Tasa_rendimiento` y `Fecharedencion`.

- Mercado_secundario:

  Un `data.frame` con las últimas cotizaciones del instrumento extraídas
  mediante web scraping.

## Details

Esta es la función principal (wrapper) del paquete para la extracción de
datos. A partir de un identificador de instrumento (ej. "cetes28"), la
función realiza internamente las siguientes operaciones:

- Identifica y consulta las series correspondientes de Banxico para
  plazo, monto asignado y tasa de rendimiento.

- Extrae la información histórica para el rango de fechas especificado.

- Extrae el último dato publicado para garantizar que la serie esté
  completamente al día.

- Cruza y consolida (mediante `full_join`) las distintas series en un
  único `data.frame` estructurado.

- Calcula automáticamente la fecha de redención del instrumento.

- Adjunta los metadatos oficiales y la cotización actual del mercado
  secundario.

## Examples

``` r
if (FALSE) { # \dontrun{
# 1. Asegúrate de haber configurado tu token previamente:
# set_banxico_token("TU_TOKEN_AQUI")

# 2. Consultar el desempeño de los CETES a 28 días desde 2023
cetes_28_info <- getBono(
  bono = 'cetes28',
  fechaInicial = '2023-01-01',
  fechaFinal = Sys.Date()
)

# 3. Acceder al data frame principal con las tasas históricas
head(cetes_28_info$cetes28_Datos)
} # }
```
