#Andare sul link: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
#Scegliere la categoria di dati a cui si è interessati
#Sulla destra avremo la parte dedicata alla sensoristica (per scegliere correttamente possiamo andare a vedere i dettagli nella pagina principale della categoria)
#SI seleziona il prodotto da scaricare scegliendo le date di inizio e fine di acquisizione 
#Troveremo varie immagini con le relative date



#Soil Water Index - 10-daily SWI 12.5km Global V3


#usiamo dati copernicus
library(raster)
install.packages("ncdf4") #seve proprio per leggere i file NC
library(ncdf4)
setwd("C:/lab/")
getwd()
swi<-raster("swi.nc")
print(swi)


plot(swi)
cls<-colorRampPalette(c( 'red', 'blue','yellow')) (100)

plot(swi, col=cls, main="SWI")
#ricampionamento
swires<-aggregate(swi, fact=100)
plot(swires,col=cls)

