library(knitr)
#Definiamo la cartella di lavoro

setwd("C:/lab/") 


#usiamo un gestore di testo dove copieremo tutto il codice che vogliamo importare
#mettiamo all'interno della nostra cartlla tutto il necessario (sia i file come immagini che il codice)

setwd("c:/lab/greenland1") #questo nel nostro caso ma bisogna selezionare la cartella corrispondente
getwd() #per controllare la cartella di lavoro

#cosa stiamo facendo in questa maniera? stiamo importando dalla cartella selezionata il file contenente il codice per creare un pdf unico
#questo pdf avrà al suo interno tutto quello su cui abbiamo lavorato.
#Per fare questo utilizziamo la funzione stitch dove per prima cosa metteremo il nome del file di testo che abbiamo creato
stitch("greenland.r", template = system.file("misc", "knitr-template.Rnw", package="knitr"))

#ci restituirà un file leggibile in LaTex con tutto il codice corrispondente
