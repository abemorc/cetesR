# Configura el token de la API de Banxico

Guarda el token de Banco de México de forma segura. Por defecto, solo lo
configura para la sesión actual. Si `install = TRUE`, lo guarda en el
archivo `.Renviron` del usuario para que esté disponible en futuras
sesiones.

## Usage

``` r
set_banxico_token(token, install = FALSE)
```

## Arguments

- token:

  Cadena de texto con el token de Banxico.

- install:

  Lógico. Si es `TRUE`, guarda el token en el archivo `~/.Renviron`.

## Value

Define la variable de entorno `BANXICO_TOKEN` de forma invisible.

## Examples

``` r
if (FALSE) { # \dontrun{
# Configurar solo para esta sesion
set_banxico_token("abc123def456")

# Instalar permanentemente en .Renviron
set_banxico_token("abc123def456", install = TRUE)
} # }
```
