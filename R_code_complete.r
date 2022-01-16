#################################

#INDICE CON NUMERI DI RIGHE CORRISPONDENTI

#1. Introduzione con qualche cenno di programmazione (13-26)
#2. Primo codice di telerilevamento (34-199)
#3. Time series (205-290)
#4. Codice per scaricare e importare dati da Copernicus (303-343)
#5. codice Knitr (347-369)
#6. Codice per la Classificazione (373-454)
#7. Analisi Multivariata (458-531)
#8. Indici di vegetazione (535-625)
#9. Land cover(629-742)
#10. Codice per analisi della Variabilità (745-849)
#11. Firme Spettrali (854-965)


##################################





#################################################################
#1.) R_code_remote_sensing_introduction.r

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

#################################################################


#2.) R_code_remote_sensing_first.r

#Primo codice di telerilevamento
#Creare una cartella (per windows evitare di creare la cartella sul desktop, crearla direttamente nel sistema operatico "C:" così da trovarla facilmente in seguito) 
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
cl<-colorRampPalette(c('black' , 'grey' , 'light grey')) (100)  #Per far capire che black, grey e lightgrey fanno parte dello stesso argomento(colore) dobbiamo usare un VETTORE, per questo ci mettiamo una parentesi e ci mettiamo la "c" che in R indica una serie di argomenti
                                                                #Il (100) indica invece il numero dei livelli dei colori e deve essere scritto esternamente perchè non fa parte della funzione

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
plot(p224r63_2011$B1_sre)#In questo modo con il simbolo $ abbiamo collegato l'immagine contenente tutte le bande scegliendo la sola banda 1 con il nome "B1_sre" 
                         #Banalmente abbiamo chiesto ad R di mostrarci la banda 1 di quell'immagine

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

p224r63_1988<-brick("p224r63_1988_masked.grd") #Come fatto precedentemente richiamiamo con Brick il file "p224r63_1988_masked.grd" 
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

#################################################################

#3.)R_code_time_series.r

#Incremento di temperatura Groenlandia

library(raster)
setwd("c:/lab/greenland")
getwd()


#diamo un nome

lst_2000<-raster("lst_2000.tif")
lst_2000
plot(lst_2000)

lst_2005<-raster("lst_2005.tif")
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")


par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

dev.off()




rlist<-list.files(pattern = "lst")
rlist
import<- lapply(rlist, raster)
import
#import e rlist sono nomi x
#list.files serve per creare una lista accomunata da una variabile
#lapply si serve della lista fatta con list.files per importare i file in R e applica una funzione che in questo caso è raster
#come si riuniscono tutti questi file raster? con Stack
tgr<-stack(import)
plot(tgr)



plotRGB(tgr, r=2,g=3,b=4, stretch="lin")


install.packages("rasterVis")
library(rasterVis)



library(rasterVis)
library(raster)

levelplot(tgr)
levelplot(tgr$lst_2000)
cl<-colorRampPalette(c('blue','light blue','pink','red'))(100)

levelplot(tgr, col.regions=cl)
#cambiare nome alle mappe plot
levelplot(tgr, col.regions=cl, main="LST variation in time", names.attr=c('july 2000','july 2005','july 2010','july 2015'))


#melt

setwd("c:/lab/melt")
getwd()

mlist<-list.files(pattern = "annual")
mlist

melt_import<-lapply(mlist, raster)
melt_import

melt<-stack(melt_import)
melt
plot(melt)

levelplot(melt)
#analisi multitemporali
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb<-colorRampPalette(c('blue','white','red'))(100)
plot(melt_amount, col=clb)

levelplot(melt_amount, col.regions=clb)

install.packages("knitr")

#################################################################

#4.)4R_code_copernicus.r

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

#################################################################

#5.)R_code_knitr.r

#Impareremo ad usare la funzione Knitr per avere un file leggibile in LaTex

#Richiamiamo la funzione knitr una volta installata)
library(knitr)

#Definiamo la cartella di lavoro
setwd("C:/lab/") 


#Usiamo un gestore di testo dove copieremo tutto il codice che vogliamo importare
#Mettiamo all'interno della nostra cartlla tutto il necessario (sia i file come immagini che il codice)

setwd("c:/lab/greenland1") #Questo nel nostro caso ma bisogna selezionare la cartella corrispondente
getwd() #Per controllare la cartella di lavoro

#Cosa stiamo facendo in questa maniera? stiamo importando dalla cartella selezionata il file contenente il codice per creare un pdf unico
#Questo pdf avrà al suo interno tutto quello su cui abbiamo lavorato.
#Per fare questo utilizziamo la funzione stitch dove per prima cosa metteremo il nome del file di testo che abbiamo creato e salvato nella nostra cartella di riferimento.
stitch("greenland.r", template = system.file("misc", "knitr-template.Rnw", package="knitr"))

#Ci restituirà un file leggibile in LaTex con tutto il codice corrispondente

#################################################################

#6.)R_code_classification.r

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

#################################################################

#7.)R_code_multivariate_analysis.r

#Iniziamo richiamaando i nostri pacchetti necessari

library(raster)
library(RStoolbox)

#Settiamo la nostra cartella di lavoro

setwd("c:/lab/")
getwd()

#importiamo dentro R con la funzione brick la nostra immagine .grd

p224r63_2011 <-brick("p224r63_2011_masked.grd")

#Vediamo un plot generico
plot(p224r63_2011)

#capiamo cosa c'è all'interno del file
p224r63_2011

#Confrontiamo la banda 1 con la banda 2
#pch è il la forma dei punti che andremo a vedere nel nostro grafico, possiamo decidere noi la forma
#cex indica invece la grandezza di questi punti

plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=23, cex=2)

#Se volessimo vedere invece un confronto tra tutte le bande? Utilizzeremo la funzione Pairs
#La funzione Pair mette in correlazione a due a due tutte le variabili di un certo Dataset(nel nostro caso sono le bande)

pairs(p224r63_2011)




library(raster)
library(RStoolbox)
setwd("c:/lab/")
getwd()
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
dev.off()
pairs(p224r63_2011)
p224r63_2011

#ricampioniamo i dati 
#fact 10 significa che ingrandiamo il pixel e perdiamo risoluzione ma allegeriamo il file (passa da una risoluzioen a 30 m a 300m (x10))
p224r63_2011res <- aggregate(p224r63_2011, fact=10, fun= mean)

p224r63_2011res


#Per capire quello che abbiamo fatto conviene fare un paragone
#Creiamo dei plot per fare un paragone 
#Par ci servirà per edere più plot insieme
par(mfrow=c(2,1))
plotRGB(p224r63_2011,4,3,2,stretch="lin")
plotRGB(p224r63_2011res,4,3,2, stretch="lin")

#cos'è a PCA?
#principal componing analisis
#prenidmao un asse nella variabilità maggiore e una a quella minore


p224r63_2011re_pca<- rasterPCA(p224r63_2011res)

summary(p224r63_2011re_pca$model)
plot(p224r63_2011re_pca$map)

p224r63_2011re_pca


plotRGB(p224r63_2011re_pca$map, 1,2,3,stretch="lin")

#################################################################

#8.)R_code_vegetation_indices.r

library(raster) #oppure require(raster)
setwd("c:/lab/")

defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#b1=nir / b2=red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1,1,2,3, stretch="lin")
plotRGB(defor2,1,2,3, stretch="lin")


#vediamo cosa c'è all'interno del file e come si chiamano le bande
defor1
# names: defor1_.1, defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green


#a questo punto possiamo fare il difference vegetation index

dvi1<-defor1$defor1.1-defor1$defor1.2
plot(dvi1)

#creiamo una palette per vedere megliok i risultati
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme


plot(dvi1, col=cl, main="DVI at time 1")

#facciamo lo stesso con il file defor 2
#controlliamo sempre i nomi all'interno del file

defor2
dvi2<-defor2$defor2.1-defor2$defor2.2
plot(dvi2)
plot(dvi2, col=cl, main="DVI at time 2")

#se vogliamo vedere le immagini insime utilizzereo la funzione Par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
dev.off()
#facciamo una differenza tra questo 2 dvi
difdvi1<-dvi1-dvi2
#creiamo una nuova palette
cld <- colorRampPalette(c('blue','white','red'))(100) 

plot(difdvi1, col=cld)

#vedremo come le parti rosse identificano un cambiamento e quindi una difefrebza di vegetazione(vedremo dove andrà in sofferenza)


#adesso facciamo la NDVI quindi la normalized difference vegetation index
#perchè utilizziamo al ndvi invece della dvi? perchè ad esempio possiamo trovare immagini a 8 o 16 bit e se dobbiamo utilizzarle insieme i valori non corrisponderanno, per questo il valore viene normalizzato
#facendo quindi questo calcolo ad esempio per immagini di 8 bit 255-0/255+0=255/255=1
#a 16 bit 65535-1/35535+1=65535/65535=1
#quindi i valori saranno effettivamente paragonabili
#i valori minimi saranno quindi nel caso di 8 bit 0-255=-1
#i valori massimi saranno 0+255=+1
#quindi i valori andranno da -1 a +1


ndvi<- (defor1$defor1.1-defor1$defor1.2) /(defor1$defor1.1+defor1$defor1.2)
plot(ndvi, col=cl, main="NDVI")
#oppure ndvi<- dv1 /(defor1$defor1.1+defor1$defor1.2)

ndvi2<- (defor2$defor2.1-defor2$defor2.2) /(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2,col=cl, main="NDVI2")


par(mfrow=c(2,1))
plot(ndvi, col=cl, main="NDVI")
plot(ndvi2,col=cl, main="NDVI2")


#utilizziamo sprectral indices 
#con questa funzione inserendo l'immagine possiamo calcoalre molti indici spettrali che possono esserci utili

vi<-spectralIndices(defor1,green = 3,red = 2,nir = 1 )
plot(vi, col=cl)

vi2<-spectralIndices(defor2,green = 3,red = 2, nir = 1)
plot(vi2, col=cl)

#facciamo la differenza questa volta del ndvi
ndifdvi1<-ndvi-ndvi2

#################################################################

#9.)R_code_land_cover.r

# R_code_land_cover.r
#install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("gridExtra")

library(raster)
library(RStoolbox) # classification
library(ggplot2)
library(gridExtra) # for grid.arrange plotting

setwd("C:/lab/") # Windows

# NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #Abbiamo usato RStoolbox per creare questo plot

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


# multiframe con ggplot2 e gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #può essere anche ncol per impostarle su 2 colonne
                              

#Unsupervised classification
#si chiama così perchè appunto non è supervisionata da noi, ma viene fatto tutto dal software 
#(nella supervised siamo noi che chiediamo al software i training site)

d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
d1c

# class 1: forest
# class 2: agriculture

# Set.seed() se vogliamo avere sempre lo stesso risultato

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)

# class 1: agriculture
# class 2: forest

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#Vogliamo calcolare la frequenza dei pixel di una certa classe
#Quante volte ho i pixel dela classe foresta per esempio?

freq(d1c$map)

#   value  count
# [1,]     1 306583
# [2,]     2  34709

#A questo punto vogliamo fare la proporzione 
#Quindi prima facciamo una somma
s1 <- 306583 + 34709

prop1 <- freq(d1c$map) / s1
prop1

# prop forest: 0.8983012
# prop agriculture: 0.1016988


#Facciamo lo stesso per la seconda mappa
s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop forest: 0.5206958
# prop agriculture: 0.4793042

#costruiamo un dataframe
#creiamo una la colonna con i fattori
#cosa sono i fattori? variabili categoriche (non numeriche)
#nel nostro caso i fattori sono foreste e agricoltura
#se il valore è una parola mettiamo le virgolette altrimenti non mettiamo niente

cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#A questo punto iniziamo a plottare il tutto con ggplot 2
#Vediamo com'è organizzata la funzione:
#c'è una parte di dataframe e una parte definita Aesthetics
#Poi c'è la parte della geometria
#"identity" significa che utilizzeremo i dati proprio come li abbiamo caricati noi

ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + 
  geom_bar(stat="identity", fill="white")

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + 
  geom_bar(stat="identity", fill="white")

#Facciamo un Par per vedere i risultati insieme

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1, p2, nrow=1)

#################################################################
#10.)R_code_Variability.r

install.packages("raster")
install.packages("RStoolbox")
install.packages("ggplot2")
install.packages("gridExtra")
install.packages("viridis")

#Richiamiamo le librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra) #Ci servirà per unire i plot ggplot insieme
library(viridis) #Questo lo useremo per la colorazione del Plot

#Settiamo la directory
setwd("C:/lab/") 


sent <- brick("Kourou_French_guiana.png")
sent

# NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3
plotRGB(sent, stretch="lin") 
#E' come se scrivessimo plotRGB(sent, r=1, g=2, b=3, stretch="lin") 

#Qui possiamo giocare con bande
plotRGB(sent, r=2, g=1, b=3, stretch="lin") 

#Dobbiamo trovare il modo di compattare tutti i nostri dati in un solo "strato"
#Un metodo può essere utilizzare gli indici di vegetazione

nir <- sent$Kourou_French_Guiana.1 #Estraiamo il nir
red <- sent$Kourou_French_Guiana.2 #Estraiamo il red

ndvi <- (nir-red) / (nir+red) #Facciamo NDVI
plot(ndvi) 

#Possiamo giocare con i colori creando una nostra palette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#Usiamo la funzione focal
#In che modo? con la fun =sd vogliamo calcolarci la deviazione standard
#per isotropia utilizzaimo  le caselle 3x3 (isotropia=presenta le stesse proprietà in tutte le direzioni)
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)

#Adesso facciamo la media sempre con la funzione focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

#Cambiamo a questo punto la grandezza della moving window 
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

#C'è un'altra tecnica per compattare i dati ed è la PCA
sentpca <- rasterPCA(sent) 
plot(sentpca$map)  

sentpca

#Per vedere quanta variabilità iniziale spiegano le singole componenti usiamo summary
summary(sentpca$model)
#La prima componente spiega 92,76146% delle informazioni originali


pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

# With the source function you can upload code from outside!
source("source_test_lezione.r")
source("source_ggplot.r")

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.

p1 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()  +
  ggtitle("Standard deviation of PC1 by viridis colour scale")

p2 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "magma")  +
  ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
  geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "turbo")  +
  ggtitle("Standard deviation of PC1 by turbo colour scale")

grid.arrange(p1, p2, p3, nrow = 1)


#################################################################

#11.)R_code_spectral_signature.r

library(ggplot2)
library(rgdal)
library(raster)
setwd("c:/lab/")

defor2<-brick("defor2.jpg")
defor2
#defor2.1 defor2.2 defor2.3
#NIR/red/green

plotRGB(defor2, 1,2,3, stretch="lin")
plotRGB(defor2, 1,2,3, stretch="hist")

#per creare le firme spettrali utilizzeremo la funzione click
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#Possiamo fare click su foreste e acqua per creare la firma spettrale

#Creiamo dei vettori
band<-c(1,2,3)
forest<-c(206,6,19) #Questi sono i valori risultanti dal click!
water<- c(40,99,139)

#creare un dataframe
spectrals<-data.frame(band,forest,water)

#plot delle firme spettrali

ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=forest), color="green") +
  geom_line(aes(y=water), color="blue") +
  labs(x="band",y="reflectance")


#Adesso possimao fare delle analisi multitemporali
defor1 <- brick("defor1.jpg")
plotRGB(defor1,1,2,3, stretch="lin")


#creiamo firme spettrali defor 1

click(defor1, id=T,xy=T, cell=T,type="p",pch=16, col= "yellow")


#     x     y  cell defor1.1 defor1.2 defor1.3
#1 53.5 365.5 80022      214      157      148
#x     y  cell defor1.1 defor1.2 defor1.3
#1 71.5 352.5 89322      165      101       91
#x     y  cell defor1.1 defor1.2 defor1.3
#1 112.5 352.5 89363      219      110      107
#x     y  cell defor1.1 defor1.2 defor1.3
#1 129.5 380.5 69388      190       78       94
#x     y   cell defor1.1 defor1.2 defor1.3
#1 129.5 334.5 102232      216        3       25


#dataframe

band <-c(1,2,3)
#Creiamo i vettori che ci serviranno per formare un dataframe:
#Mettiamo il tempo uno di defor1 e il tempo 2 di defor 2
#Di entrambi prendiamo 2 misurazioni (dell'acqua e della foresta)
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2<-c(218,16,38)
time2 <- c(197,163,151)
time2p2<-c(149,157,133)


spectralst <- data.frame(band, time1, time2,time1p2,time2p2)

#Infine possiamo plottare il tutto

ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=time1), color="red") +
  geom_line(aes(y=time1p2), color="purple") +
  geom_line(aes(y=time2), color="green") +
  geom_line(aes(y=time2p2), color="black") +
  labs(x="band",y="reflectance")


#facciamo lo stesso con un'immagine dall'osservatorio NASA

eo<-brick("img.jpg")
plotRGB(eo,1,2,3, stretch="lin")
click(eo, id=T,xy=T, cell=T,type="p",pch=16, col= "yellow")


#       x      y    cell img.1 img.2 img.3
#1 1400.5 1157.5 2726673   226   201   144
#x     y    cell img.1 img.2 img.3
#1 1270.5 962.5 3324998   233   240   246
#x     y    cell img.1 img.2 img.3
#1 1604.5 768.5 3920718   228   232   233

band<-c(1,2,3)
x1<-c(226,201,144)
x2<-c(233,240,246)
x3<-c(228,232,233)

datax<-data.frame(band,x1,x2,x3)
datax


ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=x1), color="red") +
  geom_line(aes(y=x2), color="purple") +
  geom_line(aes(y=x3), color="green") +
  labs(x="band",y="reflectance")

#Quello che vedremo saranno le firme spettrali
#################################################################
