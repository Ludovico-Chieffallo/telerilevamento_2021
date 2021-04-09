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
tgr<-stack(import)
plot(tgr)



plotRGB(tgr, r=2,g=3,b=4, stretch="lin")


install.packages("rasterVis")
library(rasterVis)



library(rasterVis)
library(raster)

levelplot(Tgr)
levelplot(Tgr$lst_2000)
cl<-colorRampPalette(c('blue','light blue','pink','red'))(100)

levelplot(Tgr, col.regions=cl)
#cambiare nome alle mappe plot
levelplot(Tgr, col.regions=cl, main="LST variation in time", names.attr=c('july 2000','july 2005','july 2010','july 2015'))


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
