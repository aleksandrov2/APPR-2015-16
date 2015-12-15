# 2. faza: Uvoz

require(dplyr)
require(rvest)
require(xml2)


link <- "https://data.oecd.org/gga/general-government-debt.htm"
podstran <- html_session(link) %>% read_html()
podstran

#naredim tabeli

podatki1 <- read.csv("podatki/government_debt.csv")
View(podatki1)

podatki2 <- read.csv("podatki/government_deficit.csv")
View(podatki2)

#izbrišem nepotrebne stolpce

podatki1$Flag.Codes <- NULL
podatki2$Flag.Codes <- NULL

podatki1$FREQUENCY <- NULL
podatki2$FREQUENCY <- NULL

podatki1$SUBJECT <- NULL
podatki2$SUBJECT <- NULL

#zaokrožim zadnji stolpec na 2 dve decimalki

podatki1[,5] <- round(podatki1[,5],2)
podatki2[,5] <- round(podatki2[,5],2)

#NAREDIM še za vsako leto posebej

dolgovi_2006 <- podatki1[["2006"]]
dolgovi_2007 <- podatki1[["2007"]]
dolgovi_2008 <- podatki1[["2008"]]
dolgovi_2009 <- podatki1[["2009"]]
dolgovi_2010 <- podatki1[["2010"]]
dolgovi_2011 <- podatki1[["2011"]]
dolgovi_2012 <- podatki1[["2012"]]
dolgovi_2013 <- podatki1[["2013"]]
dolgovi_2014 <- podatki1[["2014"]]


deficiti_2006 <- podatki2[["2006"]]
deficiti_2007 <- podatki2[["2007"]]
deficiti_2008 <- podatki2[["2008"]]
deficiti_2009 <- podatki2[["2009"]]
deficiti_2010 <- podatki2[["2010"]]
deficiti_2011 <- podatki2[["2011"]]
deficiti_2012 <- podatki2[["2012"]]
deficiti_2013 <- podatki2[["2013"]]
deficiti_2014 <- podatki2[["2014"]]

