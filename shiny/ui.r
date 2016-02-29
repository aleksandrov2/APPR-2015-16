library(shiny)
shinyUI(
  ui <- fluidPage(
    
    titlePanel("Analiza dolga in primankljaja držav v Evropski uniji"),
    sidebarLayout(
      sidebarPanel(
        sliderInput(inputId="leto_1",label="Leto",min=2006,max=2014,value=2007,sep=""),
        sliderInput(inputId="leto_2",label="Leto",min=2006,max=2014,value=2007,sep="")
        
      ),
      mainPanel(
        tabsetPanel(tabPanel("Grafi",dataTableOutput("table"),plotOutput("plot"),
                             splitLayout(
                               plotOutput("dolg"),
                               plotOutput("deficit")
                               ))
        )
      )
    )
  )
)
