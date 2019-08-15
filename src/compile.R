'
Script para "compilar" o bookdown
'

bookdown::render_book("index.Rmd", bookdown::gitbook(lib_dir = "libs"))
