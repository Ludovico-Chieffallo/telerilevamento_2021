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
install.packages("viridis")
install.packages("cowplot")
install.packages("Hmisc")

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
library(viridis)
library(rnaturalearth)
library(tidyr)
library(cowplot)
library(egg)
library(ggpubr)
library(Hmisc)


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
plotRGB(fuji21,r=4,g=3,b=2, stretch="lin")

#firme spettrali----

fuji2013ss<-brick("fuji2013.jpg")
fuji2021ss<-brick("fuji2021.jpg")

par(mfrow=c(1,2))#possiamo usare ggplot con gridextra
plotRGB(fuji2013ss,1,2,3, stretch="lin")
plotRGB(fuji2021ss,1,2,3, stretch="lin")
dev.off()


plotRGB(fuji2013ss,1,2,3, stretch="lin")
click(fuji2021ss, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="red")


plotRGB(fuji2021ss,1,2,3, stretch="lin")                                  #DA VERIFICARE
click(fuji2021ss, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="red") #DA VERIFICARE

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



  #Da rivedere e provare a fare le firme spettrali su immagini diverse
#analisi multitemporale----

list<-list.files(pattern = "fuji")
diffsnow<-lapply(list, raster)
diffsnow<-stack(diffsnow)
plot(diffsnow)

diffsnow <-diffsnow$fuji2021-diffsnow$fuji2013
clb<-colorRampPalette(c('blue','white','red'))(100)
plot(diffsnow, col=clb)
plot(diffsnow, col=viridis(256))

#possiamo fare un par
par(mfrow=c(1,2))
plot(diffsnow, col=clb, main="Difference snow 2021/2013")
plot(diffsnow, col=viridis(256),main="Difference snow 2021/2013 (Viridis)")
dev.off()
#NDSI----

#green-swir/green+swir
NDSI13<-(fuji13$X13banda3-fuji13$X13banda6)/(fuji13$X13banda3+fuji13$X13banda6)
NDSI21<-(fuji21$X21banda3-fuji21$X21banda6)/(fuji21$X21banda3+fuji21$X21banda6)

#Plot2013
par(mfrow=c(1,2))
plot(NDSI13, col=cld, main="NDSI 2013")
plot(NDSI13, col=cividis(256),main="NDSI 2013 (Cividis)")

#Plot2021
plot(NDSI21, col=cld, main="NDSI 2021")
plot(NDSI21, col=cividis(256),main="NDSI 2013 (Cividis)")
dev.off()

#differenza di NDSI----
diffNDSI<-NDSI21- NDSI13

#mappe con viridis e cividis----
par(mfrow=c(2,2))
plot(diffNDSI, main="Differenza NDSI 2021/2013")
plot(diffNDSI, col=cld ,main="Differenza NDSI 2021/2013 (cld)")
plot(diffNDSI, col=cividis(256),main="Differenza NDSI 2021/2013 (Cividis)")
plot(diffNDSI, col=viridis(256),main="Differenza NDSI 2021/2013 (Viridis)")


#classification----
class<-unsuperClass(fuji13, nClasses = 4)  #CAMBIARE I NOMI
class1<-unsuperClass(fuji21, nClasses = 4) 

par(mfrow=c(1,2))
plot(class$map, main="fuji13")
plot(class1$map, main="fuji21")
dev.off()


#temperatura media 1970-2000----
average<-list.files(pattern = "avg")
average
average1<-lapply(average,raster)
average<-stack(average1)

averagecrop70_20<-crop(average, extent(126,153,28,55))

plot(averagecrop70_20, col=viridis(256))


#temperatura massima futura----
proiezioni<-brick("temp_max_2021_40.tif")
max2021_40<-crop(proiezioni, extent(126,153,28,55))
plot(max2021_40, col=viridis(256))


#vediamo il risultato----
par(mfrow=c(1,2))
plot(max2021_40$temp_max_2021_40.1, col=viridis(256), main="2021-2040")
plot(averagecrop70_20$t_avg_jan, col=viridis(256),main="1970-2000")
dev.off()


#ggplot japan temperatura max 2021/2040----
datafuji2140<-as.data.frame(max2021_40$temp_max_2021_40.1,xy=TRUE)%>%drop_na()
head(datafuji2140)

#Geometry of japan----
japangeometry<-rnaturalearth:: ne_countries(country = "japan", returnclass = "sf")

#ggplot per la temperatura massima futura----
tempmaxgg<-ggplot()+
  geom_raster(aes(x=x,y=y, fill=temp_max_2021_40.1),data = datafuji2140)+
  geom_sf(fill="transparent",data = japangeometry)+
  scale_fill_viridis(name="C°",direction = 1)+
  labs(x="Longitude",y="Latitude", title = "Temperatura massima 2021-2040", 
       subtitle = "Area:Giappone", caption = "Source:Worldclim, 2021-2040")+
  cowplot::theme_cowplot()+
  theme(panel.grid.major = element_line(colour ="black",linetype = "dashed",size = 0.3 ),
        panel.grid.minor = element_blank(),
        panel.ontop = TRUE,
        panel.background = element_rect(fill=NA,colour = "black"))

tempmaxgg       

#ggplot japan temperatura media 1970/2000----

datafuji7020<-as.data.frame(averagecrop70_20$t_avg_jan,xy=TRUE)%>%drop_na()
head(datafuji7020)

tempavrgg<-ggplot()+
  geom_raster(aes(x=x,y=y, fill=t_avg_jan),data = datafuji7020)+
  geom_sf(fill="transparent",data = japangeometry)+
  scale_fill_viridis(name="C°",direction = 1)+
  labs(x="Longitude",y="Latitude", title = "Temperatura media 1970-2000", 
       subtitle = "Area:Giappone", caption = "Source:Worldclim, 1970-2000")+
  cowplot::theme_cowplot()+
  theme(panel.grid.major = element_line(colour ="black",linetype = "dashed",size = 0.3 ),
        panel.grid.minor = element_blank(),
        panel.ontop = TRUE,
        panel.background = element_rect(fill=NA,colour = "black"))
     
tempavrgg

#Uniamo i 2 ggplot----
ggarrange(tempavrgg, tempavrgg, ncol=2, nrow=1, common.legend = TRUE, legend="right")

#Analisi a histogrammi della vartiazione di temperatura passata e futura----
hist(max2021_40$temp_max_2021_40.1)
hist(averagecrop70_20$t_avg_jan)


primo<- hist(max2021_40$temp_max_2021_40.1,)            #cambiare le labels e posizionare questo grafico in fondo     
secondo<- hist(averagecrop70_20$t_avg_jan)                     
plot( secondo , col=rgb(1,0,0,1/4), xlim=c(-40,20), xlab="Gradi Celsius", ylab="Frequenza di Temperatura", 
      main="Picchi massimi di temperatura possibili entro il 2040")
plot( primo , col=rgb(0,0,1,1/4), xlim=c(-40,20), add=T)  
minor.tick(tick.ratio = 0.4)



 




