# 4. faza: Analiza podatkov

napoved <- lm(data = podatki3 %>% filter(Cas == 2006), Deficit ~ Dolg)
predict(napoved, data.frame(Dolg=seq(0, 250, 25))) 

napoved2 <- lm(data = podatki3 %>% filter(Cas == 2014), Deficit ~ Dolg)
predict(napoved2, data.frame(Dolg=seq(0, 250, 25)))


napoved.tabela <- data.frame(Dolg=seq(0, 250, 25))
napoved.tabela$Deficit <- predict(napoved, napoved.tabela) 

#View(napoved.tabela)

napoved.tabela2 <- data.frame(Dolg=seq(0, 250, 25))
napoved.tabela2$Deficit <- predict(napoved2, napoved.tabela2) 

#View(napoved.tabela2)


#sedaj bi radi ločili države v skupine, glede na dolg in deficit

podatki3_2014 <- podatki3 %>% filter(Cas == 2014)
rownames(podatki3_2014) <- podatki3_2014$Drzava
podatki3_2014 <- podatki3_2014[c("Dolg", "Deficit")]
podatki3.norm <- scale(podatki3_2014)



#prvi zemljevid kaže razdelitev evropskih držav na dve skupini
k <- kmeans(podatki3.norm, 2)
table(k$cluster)
k <- kmeans(podatki3.norm, 2, nstart = 10000)

podatki3.skupine <- data.frame(Drzava = names(k$cluster), 
                               skupina = factor(k$cluster))

skupina <- podatki3.skupine
sever.jug <- skupina[c("SWE", "GRC"), "skupina"]
m3 <- match(svet$adm0_a3, skupina$Drzava)
svet$skupina <- factor(skupina$skupina[m3], levels = sever.jug, ordered = TRUE)
evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
zem3 <- ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, 
                                                   group = group, fill = skupina),
                                color = "grey") + xlim(-10, 50) + 
  ylim(34, 72) + xlab("") + ylab("") +
  scale_fill_manual(values = setNames(c("#00bfc4", "#f8766d"), sever.jug),
                    labels = setNames(c("Sever", "Jug"), sever.jug),
                    na.value = "#7f7f7f")

#plot(zem3)



#Ta graf prikazuje razdelitev evrope na 5 skupin držav

k2 <- kmeans(podatki3.norm, 5, nstart = 10000)
podatki3.skupine2 <- data.frame(Drzava = names(k2$cluster), 
                                skupina2 = factor(k2$cluster))


skupina2 <- podatki3.skupine2
m4 <- match(svet$adm0_a3, skupina2$Drzava)
imena <- skupina2[c("DEU","SWE","FRA","SVN","GRC"),"skupina2"]
svet$skupina2 <- factor(skupina2$skupina[m4],levels = imena, ordered = TRUE)
evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
zem4 <- ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, 
                                                   group = group, fill = skupina2),
                                color = "grey") + xlim(-10, 50) + 
  ylim(34, 72) + xlab("") + ylab("") +
  scale_fill_manual(values = setNames(c("cyan3","chartreuse2","yellow1",
                                        "goldenrod","firebrick1"), imena),
                    labels = setNames(c("Najači", "Ful kul",
                                        "Kr gud","Luzerji","Totalni noob"), imena),
                    na.value = "#7f7f7f")

#plot(zem4)




#narišem dendrogram

d <- dist(as.matrix(podatki3.norm))
hc <- hclust(d) 

#plot(hc)




