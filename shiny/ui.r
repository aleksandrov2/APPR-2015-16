# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#



library(shiny)


shinyUI(fluidPage(
  
  plotOutput("prvi_graf"),
  tableOutput("napoved.tabela"),
  plotOutput("enajsti_graf")))
