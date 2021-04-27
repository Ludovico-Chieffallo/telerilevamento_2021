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
#la unzione unsuperClass serve proprio a fare una classificazione non supervisionata

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
