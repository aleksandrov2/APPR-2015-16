# 3. faza: Vizualizacija

library(knitr)

library(ggplot2)
library(dplyr)
require(gsubfn)
require(rvest)
require(xml2)
require(ggplot2)
library(sp)
library(maptools)


#GRAFI

#Stolpičasti graf dolga evropskih držav v določenem letu


prvi_graf <- ggplot(dolgovi[[1]], aes(x = Drzava, y = Dolg, fill=Dolg)) + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

#plot(prvi_graf)


drugi_graf <- ggplot(dolgovi[[9]], aes(x = Drzava, y = Dolg, fill=Dolg)) + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))


#plot(drugi_graf)


#Geometric point graf dolga držav v nekem letu z povprečjem

povprecje <- sum(dolgovi[[9]]$Dolg)/21

tretji_graf <- ggplot(dolgovi[[9]], 
                     aes(x = Drzava, y = Dolg, color=Drzava,size = Dolg)) + 
  guides(color = guide_legend(ncol = 2)) + geom_point() + 
  geom_hline(yintercept=povprecje, colour="red") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

#plot(tretji_graf)


#Tukaj si lahko pogledamo deficite držav v evroobmočju.

cetrti_graf <- ggplot(deficiti[[1]], aes(x = Drzava, y = Deficit, fill=Deficit)) + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

#plot(cetrti_graf)

peti_graf <- ggplot(deficiti[[9]], aes(x = Drzava, y = Deficit, fill=Deficit)) + 
  geom_bar(stat ="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

#plot(peti_graf)


#Stolpični graf ki prikaže države z dolgom več kot 100% v nekem letu


sesti_graf <- ggplot(dolgovi[[1]] %>% filter(Dolg>100), 
                     aes(x = Drzava, y = Dolg)) + 
  geom_bar(stat ="identity", fill = rainbow(2) )

#plot(sesti_graf)


sedmi_graf <- ggplot(dolgovi[[9]] %>% filter(Dolg>100), 
                    aes(x = Drzava, y = Dolg)) + 
  geom_bar(stat ="identity", fill = rainbow(9) )

#plot(sedmi_graf)



#Graf rasti zadolženosti slovenije od leta 2006 do leta 2014 

evropa_dolgovi_leta <- data.frame(Leto = as.character(2006:2014), t(evropa_dolgovi))
evropa_dolgovi_leta <- rename(evropa_dolgovi_leta, Dolg=SVN)

#View(evropa_dolgovi_leta)

osmi_graf <- ggplot(evropa_dolgovi_leta, 
                      aes(x = Leto, y = Dolg, fill=Dolg)) +
  geom_bar(stat ="identity") + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45")

#plot(osmi_graf)



evropa_dolgovi2_leta <- data.frame(Leto = as.character(2006:2014), t(evropa_dolgovi))
evropa_dolgovi2_leta <- rename(evropa_dolgovi_leta, Dolg=HUN)

#View(evropa_dolgovi2_leta)

deveti_graf <- ggplot(evropa_dolgovi2_leta, 
                      aes(x = Leto, y = Dolg, fill=Dolg)) +
  geom_bar(stat ="identity") + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45")

#plot(deveti_graf)




#Graf s krogi, večji kot je krog večja sta dolg in deficit te države. 
#Vsaka država je predstavljena s krogom svoje barve. 
#Na abscisi je prikazan deficit države v nekem letu npr. v letu 2014.
#Na ordinati je prikazan dolg te države v nekem letu npr. v letu 2014.
#Torej ta graf bo imel za vsako državo prikazan krog svoje barve in 
# ta krog bo prikazoval dolg in deficit te države v danem letu.

crta <- 0
crta1 <- -3


deseti_graf <- ggplot(podatki3 %>% filter(Cas == 2006), aes(x = Dolg, 
  y = Deficit, color =Drzava, size = Dolg-10*Deficit)) + 
  guides(color = guide_legend(ncol = 2)) + geom_point() +
  geom_hline(yintercept=crta) + 
  geom_hline(yintercept=crta1, colour="red") 
  
deseti_graf + geom_smooth(method = "lm")

#plot(deseti_graf)



enajsti_graf <- ggplot(podatki3 %>% filter(Cas == 2014), aes(x = Dolg, 
  y = Deficit, color =Drzava, size = Dolg-10*Deficit)) + 
  guides(color = guide_legend(ncol = 2)) + geom_point() +
  geom_hline(yintercept=crta) + 
  geom_hline(yintercept=crta1, colour="red") 


#plot(enajsti_graf)



#Stolpični graf, kjer primerjam zadolženost evropskih držav z ZDA in Japonsko 

tabela_3_6 <- tabela_3
tabela_3_6 <- rename(tabela_3_6, Dolg=`2011`)
tabela_3_6 <- tabela_3_6[-c(18,19,20),]

#View(tabela_3_6)

dvanajsti_graf <- ggplot(tabela_3_6, aes(x = Drzava, y = Dolg, fill = Dolg)) + 
  geom_bar(stat ="identity") +
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
  

#plot(dvanajsti_graf)



#ZEMLJEVIDI

#Napišem funkcijo, ki mi uvozi željen zemljevid sveta


pretvori.zemljevid <- function(zemljevid, pogoj = TRUE) {
  fo <- fortify(zemljevid[pogoj,])
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}

svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                        "ne_110m_admin_0_countries")


#Narišem zemljevid zadolženosti držav evropske unije

Dolg <- filter(podatki1, Cas == 2014)
m1 <- match(svet$adm0_a3, Dolg$Drzava)
svet$Dolg <- Dolg$Dolg[m1]
evropa <- pretvori.zemljevid(svet, svet$continent == "Europe")
zem1 <- ggplot() + geom_polygon(data = evropa, aes(x=long, y=lat, group = group, fill = Dolg),
                        color = "grey") + xlim(-10, 50) + ylim(34, 72) + 
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + xlab("") + ylab("") 

#plot(zem1)


#Narišem zemljevid sveta, kjer sta prikazani še Japonska in ZDA

Dolg <- tabela_3_6
m2 <- match(svet$name_long, Dolg$Drzava)
svet$dolg2 <- Dolg$Dolg[m2]
sv <- pretvori.zemljevid(svet, ! svet$name_long %in% c("Brazil", "Greenland"))

zem2 <- ggplot() + geom_polygon(data = sv, aes(x=(long+45)%%360, y=lat, group = group, fill = dolg2),
                                color = "grey")  +
  scale_fill_continuous(low = "#69b8f6", high = "#142d45") + xlab("") + ylab("") 

#plot(zem2)



