library(shiny)
shinyUI(
ui <- fluidPage(
  
  titlePanel("Analiza dolga in primankljaja držav v Evropski uniji"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId="leto_1",label="Leto",min=2006,max=2014,value=2007,step=1),
      sliderInput(inputId="leto_2",label="Leto",min=2006,max=2014,value=2007,step=1),
      sliderInput(inputId="leto_3",label="Leto",min=2006,max=2014,value=2007,step=1)
    ),
    mainPanel(
      tabsetPanel(tabPanel("Comparison",dataTableOutput("table"),plotOutput("plot"),
                           splitLayout(
                             plotOutput("age"),
                             plotOutput("origin"),
                             plotOutput("sex"))),
                  tabPanel("Prediction",plotOutput("prediction"))
      )
    )
  )
)
)
