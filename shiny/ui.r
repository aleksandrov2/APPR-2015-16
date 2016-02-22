# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#



library(shiny)
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
source("podatki/podatki.r", encoding = "UTF-8")
source("uvoz/uvozi.r", encoding = "UTF-8")
source("analiza/analiza.r", encoding = "UTF-8")

shinyUI(fluidPage(
  
  plotOutput("prvi_graf"),
  tableOutput("napoved.tabela"),
  plotOutput("enajsti_graf")))
