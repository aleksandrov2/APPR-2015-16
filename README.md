# Analiza podatkov s programom R, 2015/16


Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## ANALIZA DOLGA IN LETNEGA PRIMAKLJAJA DRŽAV V EVROOBMOČJU
Dolgovi in primakljaji držav so zelo vroča tema v Evropski uniji. Na eni strani so nekateri ekonomisti prepričani, da je treba vzdrževati strogo proračunsko disciplino, torej porabiti toliko kolikor država pobere z davki. Ostali pa verjamejo, da je proračunski primakljaj nujen, če hočemo preprečiti ponoven padec v recesijo.

Analiziral bom podatke držav evroobmočja, torej njihove letne primakljaje, delež zadolženosti glede na BDP in poskusil na grobo oceniti korelacijo med zadolženostjo in razvitostjo razičnih EU držav. 

Podatke bom pridobival iz:

- https://data.oecd.org/gga/general-government-debt.htm 
- http://www.stat.si/statweb 

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Spletni vmesnik

Spletni vmesnik se nahaja v datotekah v mapi `shiny/`. Poženemo ga tako, da v
RStudiu odpremo datoteko `server.R` ali `ui.R` ter kliknemo na gumb *Run App*.
Alternativno ga lahko poženemo tudi tako, da poženemo program `shiny.r`.

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `httr` - za pobiranje spletnih strani
* `XML` - za branje spletnih strani
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
