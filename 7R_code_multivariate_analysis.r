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



