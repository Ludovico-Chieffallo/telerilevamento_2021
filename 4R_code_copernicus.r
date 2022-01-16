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

#Questi dati possono essere ricampionati, quindi possiamo diminuirne la risoluzione, in questo modo saremo in grado in futuro di gestire meglio il file.
#Cosa facciamo in concreto? diminiuamo il numero di pixel (prendiamo più pixel, si fa una media dei valori e si condensano in uno solo)

#Ricampioneremo con la funzione aggregate
#Fact sarà il fattore sulla base del quale diminuiremo i pixel, per esempio se fact=10 vorrà dire che LINEARMENTE diminuiremo i pixel di 10 volte 
#Consideriamo che abbiamo detto lineare quindi dobbiamo calcolare nel nostro caso 10x10 (quindi ogni 100 pixel ne uscirà uno che ha la media dei valori di tutti e 100)
#Questo tipo di ricampionamento viene definito Bilineare
swires<-aggregate(swi, fact=100)
plot(swires,col=cls) #Qui vedremo infine il plot del file ricampionato con la nostra palette creata in precedenza.
