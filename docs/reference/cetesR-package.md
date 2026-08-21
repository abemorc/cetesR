# cetesR: Herramientas para Valores Gubernamentales de México

El paquete `cetesR` proporciona funciones para consultar, procesar y
analizar información financiera de los valores gubernamentales de México
(CETES, Bonos M y Udibonos). Extrae datos directamente desde la API
oficial del Banco de México (Banxico) y complementa las series con
cotizaciones del mercado secundario.

## Details

Las funciones principales incluidas en el paquete son:

- [`getBono`](https://abemorc.github.io/cetesR/reference/getBono.md):
  Función principal para obtener el historial consolidado, plazos,
  montos y tasas de un bono.

- [`set_banxico_token`](https://abemorc.github.io/cetesR/reference/set_banxico_token.md):
  Administrador para configurar el token de la API de Banxico.

- [`consultaApiDatos`](https://abemorc.github.io/cetesR/reference/consultaApiDatos.md):
  Consulta directa de series históricas en la API de Banxico.

- [`consultaApiDatoUltimo`](https://abemorc.github.io/cetesR/reference/consultaApiDatoUltimo.md):
  Consulta del dato más reciente publicado para una serie.

- [`consultaApiMeta`](https://abemorc.github.io/cetesR/reference/consultaApiMeta.md):
  Extracción de metadatos de las series de Banxico.

- [`catalogo_series`](https://abemorc.github.io/cetesR/reference/catalogo_series.md):
  Dataset interno con la tabla de mapeo de identificadores y series.

## See also

Useful links:

- <https://github.com/abemorc/cetesR>

- <https://abemorc.github.io/cetesR/>

- Report bugs at <https://github.com/abemorc/cetesR/issues>

## Author

**Maintainer**: Abelardo Morales Calva <abemorca@gmail.com>

Authors:

- Abelardo Morales Calva <abemorca@gmail.com>
