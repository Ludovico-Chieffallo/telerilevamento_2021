#Impareremo ad usare la funzione Knitr per avere un file leggibile in LaTex

#Richiamiamo la funzione knitr una volta installata)
library(knitr)

#Definiamo la cartella di lavoro
setwd("C:/lab/") 


#Usiamo un gestore di testo dove copieremo tutto il codice che vogliamo importare
#Mettiamo all'interno della nostra cartlla tutto il necessario (sia i file come immagini che il codice)

setwd("c:/lab/greenland1") #Questo nel nostro caso ma bisogna selezionare la cartella corrispondente
getwd() #Per controllare la cartella di lavoro

#Cosa stiamo facendo in questa maniera? stiamo importando dalla cartella selezionata il file contenente il codice per creare un pdf unico
#Questo pdf avrà al suo interno tutto quello su cui abbiamo lavorato.
#Per fare questo utilizziamo la funzione stitch dove per prima cosa metteremo il nome del file di testo che abbiamo creato e salvato nella nostra cartella di riferimento.
stitch("greenland.r", template = system.file("misc", "knitr-template.Rnw", package="knitr"))


#Ci restituirà un file leggibile in LaTex con tutto il codice corrispondente
