

# funcion para consulta de informacion completa
# acerca de un instrumento en particular
getBono <- function(bono, fechaInicial, fechaFinal, token, idioma="es") {


  instrumentos <- catalogo_series$Instrumento
  # validar inputs --------------------
  if(length(bono)!=1) stop("Proporcione un solo intrumento a la vez")
  if(!(bono %in% instrumentos)) stop("Error: Bono debes ser un instrumento del catalogo de series")


  # seleccionar series a consultar ------------------
  # Aqui me falta hacer esta parte
  index <- which(instrumentos %in% bono)

  codigos <- c(catalogo_series[index,2, drop=T],
               catalogo_series[index,3, drop=T],
               catalogo_series[index,4, drop=T])



  # crear los data frames de cada serie------------------

  # ultimos datos
  dfUltimoPlazo <- consultaApiDatoUltimo(codigo = codigos[1], token = token)
  dfUltimoMonto <- consultaApiDatoUltimo(codigo = codigos[2], token = token)
  dfUltimoRendimiento <- consultaApiDatoUltimo(codigo = codigos[3], token = token)


  # historicos
  dfMeta <- consultaApiMeta(codigo = codigos[3], token = token, idioma = idioma)

  dfPlazo <- consultaApiDatos(codigo = codigos[1], fechaInicial = fechaInicial,
                              fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoPlazo)

  dfMonto <- consultaApiDatos(codigo = codigos[2], fechaInicial = fechaInicial,
                              fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoMonto)

  dfTasa <- consultaApiDatos(codigo = codigos[3], fechaInicial = fechaInicial,
                             fechaFinal = fechaFinal, token = token, idioma = idioma) |>
    rbind(dfUltimoRendimiento)


  dfBono <- dfPlazo |>
    full_join(dfMonto, by = "Fecha") |>
    full_join(dfTasa, by = "Fecha") |>
    distinct()



  listaInfo <- list(dfMeta, dfBono)
  names(listaInfo) <- c("Metadatos", "Datos")


  # Retornar valor
  return(listaInfo)
}


