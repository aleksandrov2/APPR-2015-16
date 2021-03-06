# 2. faza: Uvoz


#HTML UVOZ

#link do spletne strani kjer sem dobil podatke o zadolženosti državah sveta
link2 <- "http://www.tradingeconomics.com/country-list/government-debt-to-gdp"

stran2 <- html_session(link2) %>% read_html()
tabela2 <- stran2 %>%
  html_nodes(xpath="//table[@class='table table-condensed table-hover']") %>%
  .[[2]] %>% html_table(fill = TRUE)

#vzamem samo prva dva stolpca in preimenujem
tabela2 <- tabela2[1:2]
names(tabela2) <- c("Drzava", "Dolg")
tabela2$Drzava[tabela2$Drzava == "Russia"] <- "Russian Federation"

#View(tabela2)


#link do wikipedije kjer sem dobil podatke
link <- "https://en.wikipedia.org/wiki/National_debt_of_the_United_States"

#Uvozim tabelo
stran <- html_session(link) %>% read_html()
tabela <- stran %>%
  html_node(xpath="//table[@class='wikitable sortable']") %>%
  html_table()


#Popravim imena stolpca
tabela <- rename(tabela, Drzava=Entity)

#Odstranim % in spremenim nize v števila

tabela[-1] <- apply(tabela[-1], 2,
                    . %>% strapplyc("([0-9]+)") %>% unlist() %>% as.numeric())

#View(tabela)

#naredim 3 tabele po letih 2007, 2010, 2011

tabela_1 <- tabela[c("Drzava", "2007")]
tabela_2 <- tabela[c("Drzava", "2010")]
tabela_3 <- tabela[c("Drzava", "2011")]

#View(tabela_1)
#View(tabela_2)
#View(tabela_3)



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

podatki1 <- rename(podatki1, Drzava=LOCATION, Cas=TIME, Dolg=Value)
podatki2 <- rename(podatki2, Drzava=LOCATION, Cas=TIME, Deficit=Value)


#Naredim inner_join obeh tabel tako, da imam po stolpcih države, leto, dolg in deficit

podatki3 <- inner_join(podatki1,podatki2)


#View(podatki1)
#View(podatki2)
#View(podatki3)

#Naredim še za vsako leto posebej tabele za dolgove in deficite

dolgovi <- lapply(2006:2014, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi)

dolgovi_2006 <- lapply(2006, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2006)
dolgovi_2007 <- lapply(2007, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2007)
dolgovi_2008 <- lapply(2008, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2008)
dolgovi_2009 <- lapply(2009, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2009)
dolgovi_2010 <- lapply(2010, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2010)
dolgovi_2011 <- lapply(2011, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2011)
dolgovi_2012 <- lapply(2012, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2012)
dolgovi_2013 <- lapply(2013, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2013)
dolgovi_2014 <- lapply(2014, function(leto) filter(podatki1, Cas == leto))
#View(dolgovi_2014)

deficiti <- lapply(2006:2014, function(leto) filter(podatki2, Cas == leto))
#View(deficiti)

deficiti_2006 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2006)
deficiti_2007 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2007)
deficiti_2008 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2008)
deficiti_2009 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2009)
deficiti_2010 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2010)
deficiti_2011 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2011)
deficiti_2012 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2012)
deficiti_2013 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2013)
deficiti_2014 <- lapply(2006, function(leto) filter(podatki2, Cas == leto))
#View(deficiti_2014)



#Naredim tabelo, ki ima en stolpec države in potem stolpce z leti, prikazuje dolg držav vsako leto posebej

leta <- unique(podatki1$Cas)
evropa_dolgovi <- sapply(leta, . %>% {filter(podatki1, Cas == .) %>% {setNames(.$Dolg, .$Drzava)}}) %>% data.frame()

#Preimenujem stolpce v leta

names(evropa_dolgovi) <- c("2006","2007","2008","2009","2010","2011","2012","2013","2014")

#View(evropa_dolgovi)


#Naredim tabelo, ki ima en stolpec države in potem stolpce z leti, prikazuje deficit držav vsako leto posebej

leta <- unique(podatki2$Cas)
evropa_deficiti <- sapply(leta, . %>% {filter(podatki2, Cas == .) %>% {setNames(.$Deficit, .$Drzava)}}) %>% data.frame()

#Preimenujem stolpce v leta

names(evropa_deficiti) <- c("2006","2007","2008","2009","2010","2011","2012","2013","2014")

#View(evropa_deficiti)
