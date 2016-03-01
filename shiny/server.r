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
    
    podatki11 <- rename(podatki1, Leto=Cas)
    
    
    output$zadolženost <- renderPlot({
      ggplot(podatki11 %>% filter(Drzava==input$variable), 
             aes(x = factor(Leto), y = Dolg, fill=Dolg)) +
        geom_bar(stat ="identity") + 
        scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
        ylim(0, 190) + labs(x = "Leto")
    })
    
    output$zemljevid <- renderPlot({
      Dolg <- filter(podatki1, Cas == input$leto_3)
      m1 <- match(svet$adm0_a3, Dolg$Drzava)
      svet$Dolg <- Dolg$Dolg[m1]
      evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
      ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, group = group, fill = Dolg), color = "grey") + xlim(-10, 50) + ylim(34, 72) + 
        scale_fill_continuous(low = "#69b8f6", high = "#142d45",limits = c(0, 200)) + xlab("") + ylab("") 
    })
    
    output$predikcija <- renderPlot({
      ggplot(podatki3 %>% filter(Cas == input$leto_4),
             aes(x = Dolg, y = Deficit)) + 
        guides(color = guide_legend(ncol = 2)) +
        geom_point(aes(color = Drzava, size = Dolg-10*Deficit)) +
        geom_hline(yintercept=crta) + 
        geom_hline(yintercept=crta1, colour="red") +
        geom_smooth(method = "lm") 
    })
    
  }
)
