library(knitr)

library(ggplot2)
library(dplyr)
require(gsubfn)
require(rvest)
require(xml2)
require(ggplot2)
library(sp)
library(maptools)
library(dendextend)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.


library(shiny)

if ("server.R" %in% dir()) {
  setwd("..")
}