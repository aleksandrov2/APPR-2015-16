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
  ggtitle("Zadolženost evropskih držav") +
  ylim(-33, 6)})
  
  
  output$zemljevid <- renderPlot({ggplot(origin %>% filter(GEO %in% input$countries),
                                      aes(x=CITIZEN,y=applicants,fill=GEO,color=GEO))+ 
      geom_bar(stat="identity",position=position_dodge())+
      theme(axis.text.x = element_text(angle = 70, vjust = 0.5))+
      ggtitle(paste0("Origin of asylum seekers"))+xlab("")+ylab("") })
  output$prediction <- renderPlot({ggplot(tidy_Prosnje2015 %>% filter(ASYL_APP == "Asylum applicant",GEO %in% input$countries) %>%
                                            mutate(applicants=Value+Value*(0.15*input$weather+0.7*input$conditions+0.15*input$war)),
                                          aes(x=MONTH,y=applicants,group=GEO,color=GEO))+geom_smooth(method = "loess")+
      xlab("")+ylab("")+
      ggtitle("Predictions of migrant flows")})
}
)
