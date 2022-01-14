#install packages----
install.packages("ncdf4")
install.packages("raster")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("rgeos")
install.packages("maptools")
install.packages("rworldxtra")
install.packages("sf")
install.packages("jpeg")
install.packages("RStoolbox")

#library----
library(raster)
library(RStoolbox) # classification #avrei potuto fare una ricerca di indici già presenti ma no vi era il NDSI
library(ggplot2)
library(gridExtra)
library(ncdf4)
library(dplyr)
library(knitr)
library(tidyverse)
library(ggplot2)
library(sp)
library(rgdal)
library(sf)
library(maptools)
library(tidyr)
library(lattice)

#set working directory----
setwd("c:/esame/")
getwd()

#import file 2013----

#landsat8<-list.files(pattern = "13banda")
#landsat8<-lapply(landsat8,raster)
#landsat8<-stack(landsat8)

aereosol<-raster("13banda1.TIF")
BLUEband<-raster("13banda2.TIF")
GREENband<-raster("13banda3.TIF")
REDband<-raster("13banda4.TIF")
NIRband<-raster("13banda5.TIF")
SWIR1band<-raster("13banda6.TIF")
SWIR2band<-raster("13banda7.TIF")

#create landsat 8 2013----
landsat8_13<-stack(aereosol, BLUEband,GREENband,REDband,NIRband,SWIR1band,SWIR2band)
plot(landsat8_13)
plotRGB(landsat8_13,4,3,2,stretch="lin")

#extend fuji----

#ext<-drawExtent() #only for understand the coordinates
# ext
#class      : Extent 
#xmin       : 288759.5 
#xmax       : 311842.3 
#ymin       : 3908119 
#ymax       : 3923782 

fujiext<-extent(c(288759.5,311842.3,3908119,3923782))

#crop 2013----
fuji13<-crop(landsat8_13,fujiext) 
plotRGB(fuji13,4,3,2, stretch="lin")

#import data 2021----
aereosol21<-raster("21banda1.TIF")
BLUEband21<-raster("21banda2.TIF")
GREENband21<-raster("21banda3.TIF")
REDband21<-raster("21banda4.TIF")
NIRband21<-raster("21banda5.TIF")
SWIR1band21<-raster("21banda6.TIF")
SWIR2band21<-raster("21banda7.TIF")

#create landsat 2021----
landsat8_21<-stack(aereosol21,BLUEband21,GREENband21,REDband21,NIRband21,SWIR1band21,SWIR2band21)
plotRGB(landsat8_21,3,2,1,stretch="lin")

#crop landsat 2021----
fuji21<-crop(landsat8_21,fujiext)
plotRGB(fuji21,4,3,2, stretch="lin")

#firme spettrali----

fuji2013ss<-brick("fuji2013.jpg")
fuji2021ss<-brick("fuji2021.jpg")

par(mfrow=c(1,2))#possiamo usare ggplot con gridextra
plotRGB(fuji2013ss,1,2,3, stretch="lin")
plotRGB(fuji2021ss,1,2,3, stretch="lin")
dev.off()


plotRGB(fuji2013ss,1,2,3, stretch="lin")
click(fuji2021ss, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="red")

#click(fuji2013ss, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="red")
#x     y    cell fuji2013.1 fuji2013.2 fuji2013.3
#1 783.5 721.5 1131592        238        238        238

#x      y   cell fuji2013.1 fuji2013.2 fuji2013.3
#1 527.5 1138.5 512508         61         61         37


#       x     y   cell fuji2013.1 fuji2013.2 fuji2013.3
#1 1180.5 928.5 824801         19         42         32



#Creiamo dei vettori
bande<-c(1,2,3)
neve<-c(238,238,238) #Questi sono i valori risultanti dal click!
foresta<- c(61,61,37)
lago<-c(19,42,32)   # Lake Yamanaka 

#aggiungere altri dati successivamente

spsign<-data.frame(bande,neve,foresta,lago)
view(spsign)



ggplot(data = spsign, aes(x = bande, y="reflectance")) +
  geom_line(aes(y = neve, colour = "neve",cex=1)) +
  geom_line(aes(y = foresta, colour = "foresta",cex=1)) +
  geom_line(aes(y = lago, colour = "lago",cex=1)) +
  scale_colour_manual("Legend", values = c("neve"="yellow", "foresta"="green", 
                                 "lago"="blue")) + 
  labs(title="Firma spettrale")+
  scale_x_continuous(breaks = c(1,2,3),labels = c("RED","GREEN","BLUE"))




#analisi multitemporale----

list<-list.files(pattern = "fuji")
diffsnow<-lapply(list, raster)
diffsnow<-stack(diffsnow)
plot(diffsnow)

diffsnow <-diffsnow$fuji2021-diffsnow$fuji2013
clb<-colorRampPalette(c('blue','white','red'))(100)
plot(diffsnow, col=clb)

#NDSI----

#green-swir/green+swir
NDSI13<-(fuji13$X13banda3-fuji13$X13banda6)/(fuji13$X13banda3+fuji13$X13banda6)
NDSI21<-(fuji21$X21banda3-fuji21$X21banda6)/(fuji21$X21banda3+fuji21$X21banda6)

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(NDSI13, col=cld, main="NDSI 2013")
plot(NDSI21, col=cld, main="NDSI 2021")

#differenza di NDSI----
diffNDSI<-NDSI21- NDSI13
plot(diffNDSI, col=clb)
#mappe con viridis e cividis----
par(mfrow=c(2,2))
plot(diffNDSI, col=cividis(256),main="cividis")
plot(diffNDSI, col=viridis(256),main="viridis")


#"magma" (or "A")
#"inferno" (or "B")
#"plasma" (or "C")
#"viridis" (or "D")
#"cividis" (or "E")
#"rocket" (or "F")
#"mako" (or "G")
#"turbo" (or "H")
