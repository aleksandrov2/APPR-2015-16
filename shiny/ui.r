library(shiny)
shinyUI(
  ui <- fluidPage(
    
    titlePanel("Analiza dolga in primankljaja držav v Evropski uniji"),
    tabsetPanel(
      tabPanel("Dolg",
               sliderInput(inputId="leto_1",label="Leto",min=2006,max=2014,value=2007,sep=""),
               plotOutput("dolg")),
      tabPanel("Deficit",
               sliderInput(inputId="leto_2",label="Leto",min=2006,max=2014,value=2007,sep=""),
               plotOutput("deficit")),
      tabPanel("Zadolženost",
               radioButtons("variable","Drzave:",inline=TRUE,choices = c("SVN",'AUT',"BEL","CZE","DEU","DNK","ESP","EST","FIN","FRA","GBR","GRC","HUN","IRL","ITA","LUX","NLD","POL","PRT","SVK","SWE")),
               plotOutput("zadolženost")),
      tabPanel("Zemljevid",
               sliderInput(inputId="leto_3",label="Leto",min=2006,max=2014,value=2006,sep=""),
               plotOutput("zemljevid"))
    )
  )
)
