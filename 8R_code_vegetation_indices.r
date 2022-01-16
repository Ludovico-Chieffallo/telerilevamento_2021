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
