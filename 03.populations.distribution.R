##Lec 5
##why populations disperse over the landscape in a certain manner?
library(sdm)  #species distribution model sdm
library(terra)  #species


file <- system.file("external/species.shp", package="sdm")    #file downloaded, shp type file famous ectension
file   #see the path in computer

#vector series of coordinates
#in terra these a function that deals with vectors

rana <- vect(file)  #spatial vector 
rana$Occurrence  #codes-these are presence absences of data
#zero is uncertain data (in this case real absence)

plot(rana)
plot(rana, cex=0.5)
#select only presence 
