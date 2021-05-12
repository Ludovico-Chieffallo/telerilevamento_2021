library(raster)
library(RStoolbox) #ci servirà per la classificazione

setwd("c:/lab/") #settiamo il luogo dove prelevare i dati

#andiamo a creare un brick quindi estraiamo un'immagine multistrato (SOLAR ORBITER)
so <-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so #visualizziamo il file
#adesso vediamo il plot RGB
plotRGB(so,r=1, g=2, b=3,stretch="lin")
plotRGB(so,2,3,1, stretch="lin")

#facciamo una classificazione
#classificazione non supervisionata (lasciamo fare al software)
#la funzione unsuperClass serve proprio a fare una classificazione non supervisionata

soc<-unsuperClass(so, nClasses = 3)
soc<-unsuperClass(so, nClasses = 20) #proviamo a farlo con 20 classi

#a questyo punto possiamo plottarer l'immagine
#unsuperClass ha creato una parte con il modello (quanti punti ha usato ecc), e la parte della mappa
#noi dobbiamo plottare l'immagine
#usiamo il segno del dollaro per estrarre un'informazioni rispetto alle altre
 
plot(soc$map)

#creiamo una palette

cl<- colorRampPalette(c('yellow', 'red','black'))(100)

plot(soc$map, col=cl)

#facciamo una prova scaricando delle immagini che vogliamo noi
#andiamo sul sito https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
#a questo punto possiamo scaricare la nostra immagine preferita
#facciamo un brick di nuovo
#io ho scaricato un immagine sul magnetismo del suolo

magb <- brick("Magnetogram_of_the_Sun_pillars.png")

#facciamo una classificazione non supervisionata

magbc <- unsuperClass(magb,nClasses = 3)
plot(magbc$map)

#funziona anche con fotografie classiche con classiche estenzioni
#qui provo con la foto del profilo che ho caricato su github
io<- brick ("foto github.jpg")
ioc<-unsuperClass(io, nClasses =100)
plot(ioc$map)


#A questo punto utilizziamo i dati sul Grand Canyon 

library(raster)
library(RStoolbox)
setwd("c:/lab/")  #Settiamo la nostra cartella di lavoro
getwd()    #Controlliamo se la cartella è quella corretta

#Essendo un file multistrato (RGB) dobbiamo usare la funzione brick per portarla all'interno di R  

gc<-brick ("dolansprings_oli_2013088_canyon_lrg.jpg")

#Plottiamo il risultato sia con stretch "lin" sia "hist"

plotRGB(gc, r=1,g=2,b=3, stretch="lin")
plotRGB(gc, r=1,g=2,b=3, stretch="hist")


#Andremo a fare una classificazione non supervisionata

gcc2<- unsuperClass(gc,nClasses = 2)  #Decidiamo di definire 2 classi
gcc2      #Visualizziamo il risultato 
plot(gcc2$map)     #Plottiamo decidendo di estrarre la mappa

#facciamo la stessa cosa con 4 classi 

gcc4<- unsuperClass(gc, nClasses = 4)
gcc4
plot(gcc4$map)
