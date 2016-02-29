library(shiny)

shinyServer(
server <- function(input, output) {
  
  output$dolg <- renderPlot({
  ggplot(podatki1 %>% filter(Cas == input$leto_1), aes(x = Drzava, y = Dolg, fill=Dolg)) + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Zadolženost evropskih držav") +
  ylim(0, 190)})
  
  
  output$deficit <- renderPlot({
  ggplot(podatki2 %>% filter(Cas == input$leto_2), aes(x = Drzava, 
  y = Deficit, fill=Deficit)) + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) + 
  ggtitle("Deficit evropskih držav") +
  ylim(-33, 6)})
  
  
  
}
)
