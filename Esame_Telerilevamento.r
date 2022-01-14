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


library(raster)
library(RStoolbox) # classification
library(ggplot2)
library(gridExtra)
library(raster)
library(ncdf4)
library(dplyr)
library(knitr)
library(tidyverse)
library(ggplot2)
library(colorist)
library(rnaturalearth)
library(dismo)
library(rnaturalearthdata)
library(rgeos)
library(sp)
library(rgdal)
library(sf)
library(maptools)
library(fuzzySim)
library(sdm)
library(tidyr)
library(usdm)
library(rworldxtra)
library(rworldmap)
library(maps)
library(maptools)
library(rgbif)


#crs(lol1) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
#proj4string(lol1) <- CRS("+init=epsg:4326")

setwd("C:/esame/")

tibet_87<-brick("tibet_1987.jpg")
tibet_21<-brick("tibet_2021.jpg")

par(mfrow=c(3,1))
plot(tibet_87)
plot(tibet_21)
plotRGB(tibet_21,stretch="lin")
plotRGB(tibet_87, stretch="lin")


tibet<-list.files(pattern = "tibet")
tibetimp<-lapply(tibet, raster)
tibetstack<-stack(tibetimp)

amount<- tibetstack$tibet_2021- tibetstack$tibet_1987
plot(amount)

levelplot(tibet_21$tibet_2021.1)
ggRGB(tibet_21, r=1, g=2, b=3, stretch="lin")


fuji2013<-brick("fuji2013.jpg")
fuji2021<-brick("fuji2021.jpg")
par(mfrow=c(1,2))
plot(fuji2013)
plot(fuji2021)

plotRGB(fuji2013,1,2,3, stretch="lin")
plotRGB(fuji2021,1,2,3, stretch="lin")
dev.off()

fuji2013<- brick("termal2013.jpg")



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

landsat8_13<-stack(aereosol, BLUEband,GREENband,REDband,NIRband,SWIR1band,SWIR2band)
plot(landsat8_13)
plotRGB(landsat8_13,3,2,1,stretch="lin")

#ext<-drawExtent() #only for understand the coordinates
# ext
#class      : Extent 
#xmin       : 288759.5 
#xmax       : 311842.3 
#ymin       : 3908119 
#ymax       : 3923782 

fujiext<-extent(c(288759.5,311842.3,3908119,3923782))
fuji13<-crop(landsat8_13,fujiext) 
plotRGB(fuji13,4,3,2, stretch="lin")

aereosol21<-raster("21banda1.TIF")
BLUEband21<-raster("21banda2.TIF")
GREENband21<-raster("21banda3.TIF")
REDband21<-raster("21banda4.TIF")
NIRband21<-raster("21banda5.TIF")
SWIR1band21<-raster("21banda6.TIF")
SWIR2band21<-raster("21banda7.TIF")

landsat8_21<-stack(aereosol21,BLUEband21,GREENband21,REDband21)

plotRGB(landsat8_21,3,2,1,stretch="lin")
fuji21<-crop(landsat8_21,fujiext)
plotRGB(fuji21,4,3,2, stretch="lin")

#firme spettrali

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



ggplot(data = spsign, aes(x = band, y="reflectance")) +
  geom_line(aes(y = neve, colour = "neve",cex=1)) +
  geom_line(aes(y = foresta, colour = "foresta",cex=1)) +
  geom_line(aes(y = lago, colour = "lago",cex=1)) +
  scale_colour_manual("Legend", values = c("neve"="grey", "foresta"="green", 
                                 "lago"="blue")) + 
  labs(title="Firma spettrale")+
  scale_x_continuous(breaks = c(1,2,3),labels = c("RED","GREEN","BLUE"))

