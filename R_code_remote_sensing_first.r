#Primo codice di telerilevamento
#creare una cartella, per windows evitare di creare la cartella sul desktop, crearla direttamente nel sistema operatico "C:" così da trovarla facilmente in seguito 
#come nella lezione precedente usiamo install.packages("raster") e library(raster) (in library non dobbiamo usare le virgolette perchè ormai raster è all'interno di R)
install.packages ("raster")
library (raster)
setwd("C:/lab/")    #"set working directory" ci servirà per modificare la directory, in questo caso stiamo spiegando ad R dove deve andare a prendere i file , con questa funzione dobbiamo specificare il percorso come abbiamo visto in esempio
getwd()             #"getworking directory" per scoprire la directory che stiamo usando , qui non bisogna mettere nulla nella parentesi

#Prendiamo un file precedentemente scarcicato (p224r63_20211_masked.grd) e assegnamo un nome a scelta usando la funzione Brick
p224r63_2011<-brick("p224r63_2011_masked.grd")       #funzione Brick utilizzata per creare un raster multistrato
p224r63_2011            #in questo modo richiamiamo il file e vediamo i valori interni del file
plot(p224r63_2011)      #con la funzione plot creiamo appunto un plot, che ci restituirà i valori del file ma graficamente rappresentati
#avremo come risultato un plot con questi colori:
#B1:BLUE
#B2:GREEN
#B3:RED
#B4:NIR
#B5:INFRAROSSO MEDIO
#B6:INFRAROSSO TERMICO



#Utilizziamo la funzione colorRampPalette per cambiare i colori all'interno del plot e chiamiamo questa funzione "cl"
cl<-colorRampPalette(c('black' , 'grey' , 'light grey')) (100)  #per far capire che black, grey e lightgrey fanno parte dello stesso arcomento(colore) dobbiamo usare un VETTORE, per questo ci mettiamo una parentesi e ci mettiamo la "c" che in R indica una serie di argomento
                                                                #il (100) indica invece il numero dei livelli dei colori e deve essere messo fuori perchè non fa parte della funzione

#QUALCHE ESEMPIO CON I COLORI CAMBIATI
clb<-colorRampPalette(c('dark blue' , 'blue' , 'light blue')) (100)
plot(p224r63_2011, col=clb)
clg<-colorRampPalette(c('dark green' , 'green' , 'light green')) (100)
plot(p224r63_2011, col=clg)
clr<-colorRampPalette(c('red' , 'green' , 'blue')) (100)
plot(p224r63_2011, col=clr)
cln<-colorRampPalette(c('red' , 'yellow' , 'orange')) (100)
plot(p224r63_2011, col=cln)

#richiamiamo quindi il plot con le modifiche applicate e con col definiamo il colore che preferiamo, in questo caso con il nome che abbiamo applicato prima cioè cl
plot(p224r63_2011, col=cl)
#Con la funzione par(mfrow=c(2,2)) indichiamo che vogliamo più plot vicini, precisamente stiamo dicendo che vogliamo dei plot in combinazione 2x2 che si distribuiscano su righe, quindi dopo il primo plot il secondo si andrà a posizionare alla sua destra, il terzo in basso al primo e così via
par(mfrow=c(2,2)) #PER PLOT SINGOLI (i plot che sono già multipli, come i plot visti in precedenza visti con la funzione brick, non si possono ulteriormente dividere con par)
#se vogliamo invece la stessa cosa ma ordinando i plot in colonna invece useremo par(mfcol(2,2))
par(mfcol=c(2,2)) 

plotRGB(p224r63_2011, r=3 , g=2 , b=1, stretch="lin")
