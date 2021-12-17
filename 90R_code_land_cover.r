# 9. R code land cover

# R_code_land_cover.r
#install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("gridExtra")

library(raster)
library(RStoolbox) # classification
library(ggplot2)
library(gridExtra) # for grid.arrange plotting

setwd("C:/lab/") # Windows

# NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #Abbiamo usato RStoolbox per creare questo plot

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")


# multiframe con ggplot2 e gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #può essere anche ncol per impostarle su 2 colonne
                              

#Unsupervised classification
#si chiama così perchè appunto non è supervisionata da noi, ma viene fatto tutto dal software 
#(nella supervised siamo noi che chiediamo al software i training site)

d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
d1c

# class 1: forest
# class 2: agriculture

# Set.seed() se vogliamo avere sempre lo stesso risultato

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)

# class 1: agriculture
# class 2: forest

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#Vogliamo calcolare la frequenza dei pixel di una certa classe
#Quante volte ho i pixel dela classe foresta per esempio?

freq(d1c$map)

#   value  count
# [1,]     1 306583
# [2,]     2  34709

#A questo punto vogliamo fare la proporzione 
#Quindi prima facciamo una somma
s1 <- 306583 + 34709

prop1 <- freq(d1c$map) / s1
prop1

# prop forest: 0.8983012
# prop agriculture: 0.1016988


#Facciamo lo stesso per la seconda mappa
s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop forest: 0.5206958
# prop agriculture: 0.4793042

#costruiamo un dataframe
#creiamo una la colonna con i fattori
#cosa sono i fattori? variabili categoriche (non numeriche)
#nel nostro caso i fattori sono foreste e agricoltura
#se il valore è una parola mettiamo le virgolette altrimenti non mettiamo niente

cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#A questo punto iniziamo a plottare il tutto con ggplot 2
#Vediamo com'è organizzata la funzione:
#c'è una parte di dataframe e una parte definita Aesthetics
#Poi c'è la parte della geometria
#"identity" significa che utilizzeremo i dati proprio come li abbiamo caricati noi

ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + 
  geom_bar(stat="identity", fill="white")

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + 
  geom_bar(stat="identity", fill="white")

#Facciamo un Par per vedere i risultati insieme

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

grid.arrange(p1, p2, nrow=1)
