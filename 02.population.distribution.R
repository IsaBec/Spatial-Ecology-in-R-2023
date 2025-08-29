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

#select only presence  only ones  #called species in rocchini's code
pres <-rana[rana$Occurrence==1, ]

pres$Ocurrence #get only ones

plot(pres)

#excercise: select absence 
abse <-rana[rana$Occurrence==0, ]  #comma used to close the work
plot(abse)

#excercise: plot presences and absences, one beside the other
par(mfrow=c(1,2)) 
plot(pres)
plot(abse)

dev.off()  #close other graphs, in case of graphical nulling

#excercise:plot pres and abse together with two different colors

plot(pres, col= "dark blue")
points(abse, col= "light blue")    #will add to the graph instead of overwrite

#predictors - environmental variables - why distribution is like that
#first look at path of file
## can be like this: path <- system.file("external", package="sdm") 
#or directly as done previously. deal with rasters (images)
#file <- system.file("external/species.shp", package="sdm")
#rana <- vect(file) 

#elevation predictor
elev <- system.file("external/elevation.asc", package="sdm") #asc typical image file
elev #show you pathway
elevmap <-rast(elev)    #from terra package, instead of vect is rast (raster-image)
elevmap #give you info)
plot(elevmap)
#on top want the points
plot(elevmap)
points(pres,cex=.5)

#temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
temp
tempmap <-rast(temp)
plot(tempmap)
points(pres,cex=.5)

#excercise: do the same with vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <-rast(vege)
plot(vegemap)
points(pres,cex=.5)

#change color
cl.veg <- colorRampPalette(c("light blue","snow","darkorchid1","darkgreen"))(100) 
plot(vegemap, col=cl.veg)
points(pres,cex=.5)

#precipitation
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <-rast(prec)
plot(precmap)
points(pres,cex=.5)


##plot everything together in multiframe-- final multiframe
par(mfrow=c(2,2)) 
#elev
plot(elevmap)
points(pres,cex=.5)
#temp
plot(tempmap)
points(pres,cex=.5)
#veg
plot(vegemap)
points(pres,cex=.5)
#prec
plot(precmap)
points(pres,cex=.5)
