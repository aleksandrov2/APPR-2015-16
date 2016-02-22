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
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
source("podatki/podatki.r", encoding = "UTF-8")
source("uvoz/uvozi.r", encoding = "UTF-8")
source("analiza/analiza.r", encoding = "UTF-8")

library(shiny)

if ("server.R" %in% dir()) {
  setwd("..")
}
