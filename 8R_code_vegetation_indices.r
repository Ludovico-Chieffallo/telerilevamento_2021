library(raster)
setwd("c:/lab/")

defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#b1=nir / b2=red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1,1,2,3, stretch="lin")
plotRGB(defor2,1,2,3, stretch="lin")
