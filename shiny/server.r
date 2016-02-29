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
  
  
  output$zemljevid <- renderPlot({
  Dolg <- filter(podatki1, Cas == input$leto_3)
  m1 <- match(svet$adm0_a3, Dolg$Drzava)
  svet$Dolg <- Dolg$Dolg[m1]
  evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
  ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, group = group, fill = Dolg), color = "grey") + 
  xlim(-10, 50) + ylim(34, 72) + scale_fill_continuous(low = "#69b8f6", high = "#142d45",limits = c(0, 200)) + 
  xlab("") + ylab("") + ggtitle("Zemljevid zadolženosti evropskih držav")})
}
)
