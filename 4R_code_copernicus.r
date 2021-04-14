#Soil Water Index - 10-daily SWI 12.5km Global V3


#usiamo dati copernicus
library(raster)
install.packages("ncdf4") #seve proprio per leggere i file NC
library(ncdf4)
setwd("C:/lab/")
getwd()
swi<-raster("swi.nc")
swi
