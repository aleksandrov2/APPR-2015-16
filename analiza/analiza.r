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

podatki3.skupine <- data.frame(Drzava = names(k$cluster), 
                               skupina = factor(k$cluster))

#prvi zemljevid kaže razdelitev evropskih držav na dve skupini
k <- kmeans(podatki3.norm, 2)
k <- kmeans(podatki3.norm, 2, nstart = 10000)


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


#Ta graf prikazuje razdelitev evrope na 5 skupin držav

k2 <- kmeans(podatki3.norm, 5, nstart = 10000)
podatki3.skupine2 <- data.frame(Drzava = names(k2$cluster), 
                               skupina = factor(k2$cluster))


skupina2 <- podatki3.skupine2
m4 <- match(svet$adm0_a3, skupina2$Drzava)
svet$skupina2 <- skupina2$skupina2[m4]
evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
zem4 <- ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, 
                                                   group = group, fill = skupina2),
                                color = "grey") + xlim(-10, 50) + 
  ylim(34, 72) + 
  #scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  xlab("") + ylab("") 


#plot(zem4)
