#Primo codice di telerilevamento
#creare una cartella, evitare di creare la cartella sul desktop, crearla direttamente nel sistema operatico "C:" così da trovarla facilmente in seguito 
#come nella lezione precedente usiamo install.packages("raster") e library(raster) (in library non dobbiamo usare le virgolette perchè ormai raster è all'interno di R)

setwd("C:/lab/") #"set working directory" ci servirà per modificare la directory, in questo caso stiamo spiegando ad R dove deve andare a prendere i file , con questa funzione dobbiamo specificare il percorso come abbiamo visto in esempio
getwd() #"getworking directory" per scoprire la directory che stiamo usando , qui non bisogna mettere nulla nella parentesi
#Prendiamo un file precedentemente scarcicato (p224r63_20211_masked.grd) e assegnamo un nome a scelta usando la funzione Brick
p224r63_2011<-brick("p224r63_2011_masked.grd") #funzione Brick utilizzata per creare un raster multistrato
p224r63_2011 #in questo modo richiamiamo il file e vediamo i valori interni del file
plot(p224r63_2011) #con la funzione plot creiamo appunto un plot, che ci restituirà i valori del file ma graficamente rappresentati
