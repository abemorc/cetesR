#' Configura el token de la API de Banxico
#'
#' @description
#' Guarda el token de Banco de México de forma segura. Por defecto, solo lo configura
#' para la sesión actual. Si \code{install = TRUE}, lo guarda en el archivo \code{.Renviron}
#' del usuario para que esté disponible en futuras sesiones.
#'
#' @param token Cadena de texto con el token de Banxico.
#' @param install Lógico. Si es \code{TRUE}, guarda el token en el archivo \code{~/.Renviron}.
#'
#' @return Define la variable de entorno \code{BANXICO_TOKEN} de forma invisible.
#' @export
#'
#' @examples
#' \dontrun{
#' # Configurar solo para esta sesion
#' set_banxico_token("abc123def456")
#'
#' # Instalar permanentemente en .Renviron
#' set_banxico_token("abc123def456", install = TRUE)
#' }
set_banxico_token <- function(token, install = FALSE) {
  if (missing(token) || !is.character(token) || nchar(token) == 0) {
    stop("Debes proporcionar un token valido de la API de Banxico.", call. = FALSE)
  }

  # Configurar para la sesion actual
  Sys.setenv(BANXICO_TOKEN = token)

  # Si el usuario pide instalarlo permanentemente
  if (install) {
    home_dir <- Sys.getenv("HOME")
    renviron_path <- file.path(home_dir, ".Renviron")

    # Preparamos la linea a escribir
    token_line <- paste0('BANXICO_TOKEN="', token, '"')

    # Leemos el archivo actual si existe para no duplicar
    if (file.exists(renviron_path)) {
      lines <- readLines(renviron_path, warn = FALSE)
      # Si ya existe un token, lo reemplazamos
      if (any(grepl("^BANXICO_TOKEN=", lines))) {
        lines <- lines[!grepl("^BANXICO_TOKEN=", lines)]
        lines <- c(lines, token_line)
        writeLines(lines, renviron_path)
        message("El token existente en .Renviron ha sido actualizado.")
      } else {
        # Si no existe, lo agregamos al final
        write(paste0("\n", token_line), file = renviron_path, append = TRUE)
        message("Token agregado a tu archivo .Renviron.")
      }
    } else {
      # Si no hay .Renviron, lo creamos
      writeLines(token_line, renviron_path)
      message("Archivo .Renviron creado y token guardado.")
    }

    message("Por favor, reinicia tu sesion de R para que los cambios sean permanentes.")
  } else {
    message("Token configurado exitosamente para la sesion actual.")
  }

  invisible(token)
}
