# 4. faza: Analiza podatkov

napoved <- lm(data = podatki3 %>% filter(Cas == 2006), Deficit ~ Dolg)
predict(napoved, data.frame(Dolg=seq(0, 250, 25))) 

napoved2 <- lm(data = podatki3 %>% filter(Cas == 2014), Deficit ~ Dolg)
predict(napoved2, data.frame(Dolg=seq(0, 250, 25)))


#sedaj bi radi ločili države v skupine, glede na dolg in deficit

podatki3_2014 <- podatki3 %>% filter(Cas == 2014)
rownames(podatki3_2014) <- podatki3_2014$Drzava
podatki3_2014 <- podatki3_2014[c("Dolg", "Deficit")]
podatki3.norm <- scale(podatki3_2014)
k <- kmeans(podatki3.norm, 5)
table(k$cluster)


podatki3.skupine <- data.frame(Drzava = names(k$cluster), 
                               skupina = factor(k$cluster))


k$tot.withinss
k <- kmeans(podatki3.norm, 10, nstart = 10000)
k$tot.withinss

skupina <- podatki3.skupine
m3 <- match(svet$adm0_a3, skupina$Drzava)
svet$skupina <- skupina$skupina[m3]
evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
zem3 <- ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, 
                                group = group, fill = skupina),
                                color = "grey") + xlim(-10, 50) + 
  ylim(34, 72) + 
  #scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  xlab("") + ylab("") 



#plot(zem3)
