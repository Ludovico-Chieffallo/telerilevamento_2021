# 10. R code variability

# R_code_variability.r
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
