Rscript -e "renv::install(c('languageserver', 'jsonlite', 'rlang', 'httpgd'))"
Rscript -e "renv::restore()"
sudo apt-get update -y
sudo apt-get install -y qpdf
