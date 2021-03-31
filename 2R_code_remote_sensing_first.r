#Primo codice di telerilevamento
#Creare una cartella, per windows evitare di creare la cartella sul desktop, crearla direttamente nel sistema operatico "C:" così da trovarla facilmente in seguito 
#Come nella lezione precedente usiamo install.packages("raster") e library(raster) (in library non dobbiamo usare le virgolette perchè ormai raster è all'interno di R)
install.packages ("raster")
library (raster)
setwd("C:/lab/")    #"set working directory" ci servirà per modificare la directory, in questo caso stiamo spiegando ad R dove deve andare a prendere i file , con questa funzione dobbiamo specificare il percorso come abbiamo visto in esempio
getwd()             #"getworking directory" per scoprire la directory che stiamo usando , qui non bisogna mettere nulla nella parentesi

#Prendiamo un file precedentemente scarcicato (p224r63_20211_masked.grd) e assegnamo un nome a scelta usando la funzione Brick
p224r63_2011<-brick("p224r63_2011_masked.grd")       #Funzione Brick utilizzata per creare un raster multistrato
p224r63_2011            #In questo modo richiamiamo il file e vediamo i valori interni del file
plot(p224r63_2011)      #Con la funzione plot creiamo appunto un plot, che ci restituirà i valori del file ma graficamente rappresentati
#Avremo come risultato un plot con questi colori (BANDE LANDSAT):
#B1:BLUE
#B2:GREEN
#B3:RED
#B4:NIR (INFRAROSSO VICINO)
#B5:INFRAROSSO MEDIO
#B6:INFRAROSSO TERMICO
#B8:UN ALTRO INFRAROSSO MEDIO



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

#Richiamiamo quindi il plot con le modifiche applicate e con col definiamo il colore che preferiamo, in questo caso con il nome che abbiamo applicato prima cioè cl
plot(p224r63_2011, col=cl)

dev.off() #Con questo comando puliremo tutti i grafici
#USO DI $
plot(p224r63_2011$B1_sre)#In questo modo con il simbolo $ abbiamo collegato il l'immagine contenente tutte le bande e abbiamo collegato alla sola banda 1 con il nome "B1_sre"  

plot(p224r63_2011$B1_sre, col=cl) #Così abbiamo solamente aggiunto l'informazione col=cl che richiamerà il colore fatto con colorRampPalette

#Con la funzione par(mfrow=c(2,2)) indichiamo che vogliamo più plot vicini, precisamente stiamo dicendo che vogliamo dei plot in combinazione 2x2 che si distribuiscano su righe, quindi dopo il primo plot il secondo si andrà a posizionare alla sua destra, il terzo in basso al primo e così via
par(mfrow=c(2,2)) 
#Se vogliamo invece la stessa cosa ma ordinando i plot in colonna invece useremo par(mfcol(2,2))
par(mfcol=c(2,2)) 

#FACCIAMO UN ESEMPIO
par(mfrow=c(2,2)) #2 righe e 2 colonne. Se avessimo scritto (2,1) avremmo definito 2 righe e 1 colonna
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B7_sre)
plot(p224r63_2011$B6_bt)

#ESEMPIO CON MFROW E MFCOL
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)    #COSI' AVREMO LE IMMAGINI UNA ACCANTO ALL'ALTRA

dev.off()

par(mfcol=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)    #COSI' AVREMO LE IMMAGINI UNA SOPRA L'ALTRA


#FACCIAMO UN ULTERIORE ESEMPIO DOVE DEFINIREMO DEI COLORI CON colorRampPalette E DOPO FAREMO I PLOT DELLE SINGOLE BANDE CON "$" E DISPORREMO I PLOT CON par(mfrow=c(2,2))
par(mfrow=c(2,2))   
clb<-colorRampPalette(c('dark blue', 'blue' , 'light blue'))(100)  
clg<-colorRampPalette(c('dark green', 'green', 'light green'))(100)
clr<-colorRampPalette(c('dark red', 'red', 'pink'))(100)
clnir<-colorRampPalette(c('red', 'orange', 'yellow'))(100)

plot(p224r63_2011$B1_sre, col=clb)
plot(p224r63_2011$B2_sre, col=clg)
plot(p224r63_2011$B3_sre, col=clr)
plot(p224r63_2011$B4_sre, col=clnir)
dev.off()


#Ora utilizzeremo la funzione plotRGB che ci restituirà un'immagine su 3 layer (per immagini Raster)
#Come abbiamo visto prima nell'ordine dei colori di Landsat la banda 1 era corrispondente al Blue, la banda 2 al verde, la banda 3 al rosso
#Quindi per avere un'immagine dai colori naturali dovremo usare r=3, g=2, b=1

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stretch prende i valori di ogni singola banda e li "estende" così da mostrare ogni singolo valore intermedio di colori
                                                    #lin sta per lineare (è possibile utilizzare altri parametri come "hist")

#Possiamo anche provare a scambiare i numeri ma ci restituirà un'immagine non naturale
#In questo modo possiamo giocare con i colori e capire empiricamente quale combinazione può restituirci colori adatti alle nostre ricerche e statistiche

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#Importiamo il pdf delle nostre immagini nella nostra cartella predefinita (per visualizzarla usare getwd())
pdf("primo pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#Facciamo un par su 3 righe e 1 colonna per vedere le differenze di tutti i plot (colori naturali, falsi colori e con histogram stretching)  
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist") #Qui abbiamo utilizzato Hist



#DVI per 2 anni compariamo le differenze nel tempo
#Ricordiamo che DVi è uguale a NIR-RED
#Mentre NDVI (NIR-RED)/(NIR+RED)

p224r63_1988<-brick("p224r63_1988_masked.grd") #Come fatto precedentemente richiamiamo con Brickil file "p224r63_1988_masked.grd" 
plot(p224r63_1988)

plotRGB(p224r63_1988, r=3,g=2, b=1, stretch="lin")
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="lin")      #Giochiamo un po' con i colori
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="lin")

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="lin")      #Facciamo un Par 2 righe e una colonna

par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="lin")      #adesso vediamo le differenze tra stretch="lin" e stretch="hist"
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="lin")
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="hist")

#Adesso creiamo il nostro PDF
pdf("hist e lin")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="lin")
plotRGB(p224r63_1988, r=4,g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4,g=3, b=2, stretch="hist")
dev.off()



#DVI del 1988 e del 2011
dvi1988<-p224r63_1988$B4_sre - p224r63_1988$B3_sre   #Il DVI come detto sopra si calcola con NIR-RED quindi utilizzeremo la banda del NIR e quella del RED
dvi2011<-p224r63_2011$B4_sre - p224r63_2011$B3_sre

par(mfrow=c(2,1))         
plot(dvi1988) 
plot(dvi2011)

cldvi<-colorRampPalette(c('red', 'orange', 'yellow')) (100)   #Definiamo dei colori con colorRampPalette
par(mfrow=c(2,1))                                             
plot(dvi1988, col=cldvi)
plot(dvi2011, col=cldvi)

#Differenza nel tempo quindi 2011-1988

difdvi<-dvi2011- dvi1988
cldif<-colorRampPalette(c('blue', 'white', 'red'))(100)
plot(difdvi, col=cldif)


