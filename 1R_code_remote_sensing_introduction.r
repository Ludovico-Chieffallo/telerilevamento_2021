#Prima lezione introduttiva di telerilevamento
#Iniziamo ad utilizzare il codice in R assegnando dei valori a dei nomi
pippo<-3+3
geo<- 2+2 #In quersto modo assegnamo a geo il valore 2+2 e a pippo il valore 3+3
(3+3)/(2+2) #Avremo come risultato 1.5 ma in che modo possiamo farlo anche?
pippo/geo #Stesso modo per esprimere l'operazione e avremo come risultato sempre 1.5

#Lavoriamo con le funzioni
install.packages("raster")#Quello che sta nelle parentesi viene definito argomento ed è ciò che si vuole istallare e bisogno metterlo tra parentesi

#In questo modo abbiamo caricato (istallato) raster ma non lo stiamo usando, in che modo? possiamo usare questo pacchetto? con la funzione #libary o #require
library(raster) #Adesso stiamo utilizzando il acchetto raster così da poter "giocare" con il nostro pacchetto
