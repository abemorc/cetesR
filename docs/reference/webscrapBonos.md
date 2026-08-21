# Cotizaciones en Tiempo Real del Mercado Secundario

Extrae información en tiempo real de los rendimientos de los bonos
gubernamentales de México cotizados en el mercado secundario.

## Usage

``` r
webscrapBonos()
```

## Value

Un `data.frame` (tipo `tibble`) con la información actualizada de los
rendimientos de los bonos. Si la extracción falla debido a problemas de
red o cambios en el sitio web, devuelve `NULL`.

## Details

Esta función utiliza técnicas de web scraping para leer la tabla de
cotizaciones directamente desde el portal financiero Investing.com.

IMPORTANTE: Dado que esta función depende de la estructura HTML de un
sitio web externo, existe la posibilidad de que falle si el proveedor
cambia el diseño de su página (por ejemplo, si alteran el identificador
de la tabla). Para mitigar esto, se han incluido rutinas de manejo de
errores que, en caso de fallo, devuelven un valor nulo (`NULL`)
emitiendo una advertencia, permitiendo que el flujo de análisis
principal no se interrumpa abruptamente.

## Examples

``` r
if (FALSE) { # \dontrun{
# Extraer la tabla de mercado secundario de Investing.com
mercado_secundario <- webscrapBonos()

print(mercado_secundario)
} # }
```
