# 2. faza: Uvoz
library(ggplot2)
library(dplyr)
require(gsubfn)
require(rvest)
require(xml2)
require(ggplot2)


#HTML UVOZ
#link do wikipedije kjer sem dobil podatke
link <- "https://en.wikipedia.org/wiki/National_debt_of_the_United_States"

#Uvozim tabelo
stran <- html_session(link) %>% read_html()
tabela <- stran %>%
  html_node(xpath="//table[@class='wikitable sortable']") %>%
  html_table()


#Popravim imena stolpca
tabela <- rename(tabela, Država=Entity)

#Odstranim % in spremenim nize v števila

tabela[-1] <- apply(tabela[-1], 2, . %>% strapplyc("([0-9]+)") %>% unlist() %>% as.numeric())


#View(tabela)



#CSV DATOTEKE
#ustvarim tabeli

podatki1 <- read.csv("podatki/government_debt.csv")

podatki2 <- read.csv("podatki/government_deficit.csv")


#izbrišem nepotrebne stolpce

podatki1$Flag.Codes <- NULL
podatki2$Flag.Codes <- NULL

podatki1$FREQUENCY <- NULL
podatki2$FREQUENCY <- NULL

podatki1$SUBJECT <- NULL
podatki2$SUBJECT <- NULL

podatki1$INDICATOR <- NULL
podatki2$INDICATOR <- NULL

podatki1$MEASURE <- NULL
podatki2$MEASURE <- NULL


#zaokrožim zadnji stolpec na 2 dve decimalki

podatki1[,3] <- round(podatki1[,3],2)
podatki2[,3] <- round(podatki2[,3],2)


#Spremenim imena stolpcev 

podatki1 <- rename(podatki1, Država=ï..LOCATION, Čas=TIME, Dolg=Value)
podatki2 <- rename(podatki2, Država=ï..LOCATION, Čas=TIME, Deficit=Value)


#Naredim inner_join obeh tabel tako, da imam po stolpcih države, leto, dolg in deficit

podatki3 <- inner_join(podatki1,podatki2)


#View(podatki1)
#View(podatki2)
#View(podatki3)

#Naredim še za vsako leto posebej tabele za dolgove in deficite

dolgovi <- lapply(2006:2014, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi)

dolgovi_2006 <- lapply(2006, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2006)
dolgovi_2007 <- lapply(2007, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2007)
dolgovi_2008 <- lapply(2008, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2008)
dolgovi_2009 <- lapply(2009, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2009)
dolgovi_2010 <- lapply(2010, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2010)
dolgovi_2011 <- lapply(2011, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2011)
dolgovi_2012 <- lapply(2012, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2012)
dolgovi_2013 <- lapply(2013, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2013)
dolgovi_2014 <- lapply(2014, function(leto) filter(podatki1, Čas == leto))
#View(dolgovi_2014)


deficiti <- lapply(2006:2014, function(leto) filter(podatki2, Čas == leto))
#View(deficiti)

deficiti_2006 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2006)
deficiti_2007 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2007)
deficiti_2008 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2008)
deficiti_2009 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2009)
deficiti_2010 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2010)
deficiti_2011 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2011)
deficiti_2012 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2012)
deficiti_2013 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2013)
deficiti_2014 <- lapply(2006, function(leto) filter(podatki2, Čas == leto))
#View(deficiti_2014)



#Naredim tabelo, ki ima en stolpec države in potem stolpce z leti, prikazuje dolg držav vsako leto posebej

leta <- unique(podatki1$Cas)
evropa_dolgovi <- sapply(leta, . %>% {filter(podatki1, Cas == .) %>% {setNames(.$Dolg, .$Država)}}) %>% data.frame()

#Preimenujem stolpce v leta

names(evropa_dolgovi) <- c("2006","2007","2008","2009","2010","2011","2012","2013","2014")

#View(evropa_dolgovi)


#Naredim tabelo, ki ima en stolpec države in potem stolpce z leti, prikazuje deficit držav vsako leto posebej

leta <- unique(podatki2$Cas)
evropa_deficiti <- sapply(leta, . %>% {filter(podatki2, Cas == .) %>% {setNames(.$Deficit, .$Država)}}) %>% data.frame()

#Preimenujem stolpce v leta

names(evropa_deficiti) <- c("2006","2007","2008","2009","2010","2011","2012","2013","2014")

#View(evropa_deficiti)




#GRAFI

#Stolpičasti graf dolga evropskih držav v določenem letu

prvi_graf <- ggplot(dolgovi[[1]], aes(x = Država, y = Dolg)) + geom_bar(stat ="identity", mode = "markers")
                                                                        
#plot(prvi_graf)


#Stolpični graf ki prikaže države z dolgom več kot 100% v nekem letu

drugi_graf <- ggplot(dolgovi[[9]] %>% filter(Dolg>100), aes(x = Država, y = Dolg)) + geom_bar(stat ="identity", mode = "markers")

#plot(drugi_graf)



#Geometric point graf dolga držav v nekem letu z povprečjem

tretji_graf <- ggplot(dolgovi[[9]], aes(x = Država, y = Dolg)) + geom_point() + geom_hline()

#plot(tretji_graf)


#Graf rasti zadolženosti slovenije od leta 2006 do leta 2014 

četrti_graf <- ggplot(evropa_dolgovi, aes(x = Leto, y = Dolg)) + geom_bar(stat ="identity", mode = "markers")

#View(četrti_graf)



#Graf s krogi, večji kot je krog večja sta dolg in deficit te države. 
#Vsaka država je predstavljena s krogom svoje barve. 
#Na abscisi je prikazan deficit države v nekem letu npr. v letu 2014.
#Na ordinati je prikazan dolg te države v nekem letu npr. v letu 2014.
#Torej ta graf bo imel za vsako državo prikazan krog svoje barve in 
# ta krog bo prikazoval dolg in deficit te države v danem letu.



