# 4. faza: Analiza podatkov

# 4. faza: Analiza podatkov

napoved <- lm(data = podatki3 %>% filter(Cas == 2006), Deficit ~ Dolg)
predict(napoved, data.frame(Dolg=seq(0, 250, 25))) 

napoved2 <- lm(data = podatki3 %>% filter(Cas == 2014), Deficit ~ Dolg)
predict(napoved2, data.frame(Dolg=seq(0, 250, 25)))

Zadolzenost <- c(0,25,50,75,100,125,150,175,200,225,250)
Deficit <- c(0.80,-0.15,-1.09,-2.03,-2.98,-3.92,-4.86,-5.81,-6.75,-7.69,-8.63)


#rad bi naredil tabelo, ki bi prikazovala napoved gibanja deficita, če vemo
#kakšna je naša zadolženost

predikcija <- as.table(setNames(Zadolzenost, Deficit))



#sedaj bi radi ločili države v skupine, glede na dolg in deficit

podatki3_2014 <- podatki3 %>% filter(Cas == 2014)
rownames(podatki3_2014) <- podatki3_2014$Drzava
podatki3_2014 <- podatki3_2014[c("Dolg", "Deficit")]
podatki3.norm <- scale(podatki3_2014)

podatki3.skupine <- data.frame(Drzava = names(k$cluster), 
                               skupina = factor(k$cluster))

#prvi zemljevid kaže razdelitev evropskih držav na dve skupini
k <- kmeans(podatki3.norm, 2)
table(k$cluster)
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
