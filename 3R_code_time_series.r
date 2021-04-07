#time series analysis
#greenland increase of temperature
#Data and Code from Emanuela Cosma

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
