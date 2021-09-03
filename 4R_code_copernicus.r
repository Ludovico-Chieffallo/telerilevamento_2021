#Andare sul link: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
#Scegliere la categoria di dati a cui si è interessati
#Sulla destra avremo la parte dedicata alla sensoristica (per scegliere correttamente possiamo andare a vedere i dettagli nella pagina principale della categoria)
#SI seleziona il prodotto da scaricare scegliendo le date di inizio e fine di acquisizione 
#Troveremo varie immagini con le relative date
#Avremo dei file con estensione .nc (istalleremo un pacchetto apposito per leggere questi file)
#Avremo un metadato .xml per l'incamerazione di tutte le informazioni riguardo le immagini



#ESEMPIO
#Soil Water Index - 10-daily SWI 12.5km Global V3


#Usiamo dati copernicus
#Carichiamo il pacchetto raster poichè lavoreremo con immagini
library(raster)
install.packages("ncdf4") #Ci servirà proprio per leggere i file .nc
library(ncdf4) #Richiamiamo il pacchetto (senza "" poichè ormai è all'interno di R)
setwd("C:/lab/") #Selezioniamo la cartella di lavoro dove prenderemo i dati
getwd() #Ci servirà quando non saremo sicuri della cartella nella quale stiamo lavorando
swi<-raster("swi.nc") #Diamo un nome a piacere 
print(swi) #vediamo le informazioni che avremo da swi

#Creiamo un plot per vedere la rappresentazione grafica 
plot(swi)
cls<-colorRampPalette(c( 'red', 'blue','yellow')) (100) #Creiamo una Palette 

plot(swi, col=cls, main="SWI") #Qui vediamo il pLot con la palette appena creata

#ricampionamento
swires<-aggregate(swi, fact=100)
plot(swires,col=cls) 

