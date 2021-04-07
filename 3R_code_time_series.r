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




rlist<-list.files(pattern = "lst")
rlist
import<- lapply(rlist, raster)
import
#import e rlist sono nomi x
#list.files serve per creare una lista accomunata da una variabile
#lapply si serve della lista fatta con list.files per importare i file in R e applica una funzione che in questo caso è raster
#come si riuniscono tutti questi file raster? con Stack
unico<-stack(import)
plot(lol)
