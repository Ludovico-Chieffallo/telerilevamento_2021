

library(ggplot2)
library(rgdal)
library(raster)
setwd("c:/lab/")

defor2<-brick("defor2.jpg")
defor2
#defor2.1 defor2.2 defor2.3
#NIR/red/green

plotRGB(defor2, 1,2,3, stretch="lin")
plotRGB(defor2, 1,2,3, stretch="hist")

#per creare le firme spettrali utilizzeremo la funzione click
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")


band<-c(1,2,3)
forest<-c(206,6,19)
water<- c(40,99,139)

#creare un dataframe
spectrals<-data.frame(band,forest,water)

#plot delle firme soettrali

ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=forest), color="green") +
  geom_line(aes(y=water), color="blue") +
  labs(x="band",y="reflectance")


#fare analisi multitemporale
defor1 <- brick("defor1.jpg")
plotRGB(defor1,1,2,3, stretch="lin")


#creiamo firme spettrali defor 1

click(defor1, id=T,xy=T, cell=T,type="p",pch=16, col= "yellow")


#     x     y  cell defor1.1 defor1.2 defor1.3
#1 53.5 365.5 80022      214      157      148
#x     y  cell defor1.1 defor1.2 defor1.3
#1 71.5 352.5 89322      165      101       91
#x     y  cell defor1.1 defor1.2 defor1.3
#1 112.5 352.5 89363      219      110      107
#x     y  cell defor1.1 defor1.2 defor1.3
#1 129.5 380.5 69388      190       78       94
#x     y   cell defor1.1 defor1.2 defor1.3
#1 129.5 334.5 102232      216        3       25


#dataframe

band <-c(1,2,3)
# define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2<-c(218,16,38)
time2 <- c(197,163,151)
time2p2<-c(149,157,133)


spectralst <- data.frame(band, time1, time2,time1p2,time2p2)

#plot


ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=time1), color="red") +
  geom_line(aes(y=time1p2), color="purple") +
  geom_line(aes(y=time2), color="green") +
  geom_line(aes(y=time2p2), color="black") +
  labs(x="band",y="reflectance")


#immagine dall'osservatorio NASA

eo<-brick("img.jpg")
plotRGB(eo,1,2,3, stretch="lin")
click(eo, id=T,xy=T, cell=T,type="p",pch=16, col= "yellow")


#       x      y    cell img.1 img.2 img.3
#1 1400.5 1157.5 2726673   226   201   144
#x     y    cell img.1 img.2 img.3
#1 1270.5 962.5 3324998   233   240   246
#x     y    cell img.1 img.2 img.3
#1 1604.5 768.5 3920718   228   232   233

band<-c(1,2,3)
x1<-c(226,201,144)
x2<-c(233,240,246)
x3<-c(228,232,233)

datax<-data.frame(band,x1,x2,x3)
datax



ggplot(spectrals, aes(x=band)) +
  geom_line(aes(y=x1), color="red") +
  geom_line(aes(y=x2), color="purple") +
  geom_line(aes(y=x3), color="green") +
  labs(x="band",y="reflectance")

