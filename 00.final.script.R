##Final script including all diff scripts during lectures

#summary with Duccio's code
#01 Beginning
#02.1 Population density
#02.2 Population distribution
#03.1 Commmunity multivariate analysis
#03.2 Communities overlap
#04 Remote sensing data visualization


#-----------------------
#01 Beginning
# Here I can write anything I want!!! 42 is the meaning of life univcerse and all!

# R as a calculator
2 + 3

# Assign to an object
zima <- 2 + 3
zima

duccio <- 5 + 3
duccio

final <- zima * duccio
final

final^2

# array
sophi <- c(10, 20, 30, 50, 70) # microplastics 
# fcuntions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000) # people

plot(paula, sophi)

plot(paula, sophi, xlab="number of people", ylab="microplastics")


people <- paula
microplastics <- sophi

plot(people, microplastics)
plot(people, microplastics, pch=19)
# https://www.google.com/search?client=ubuntu-sn&hs=yV6&sca_esv=570352775&channel=fs&sxsrf=AM9HkKknoSOcu32qjoErsqX4O1ILBOJX4w:1696347741672&q=point+symbols+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwia9brkm9qBAxVrQvEDHbEYDuMQ0pQJegQIChAB&biw=1760&bih=887&dpr=1.09#imgrc=lUw3nrgRKV8ynM

plot(people, microplastics, pch=19, cex=2)
plot(people, microplastics, pch=19, cex=2, col="blue")

#-----------------------

#02.1 Population density

# Code related to population ecology

# A package is needed for point pattern analysis
install.packages("spatstat")
library(spatstat)

# let's use the bei data:
# data description:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data
plot(bei)

# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev)
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements
elevation2 <- bei.extra[[1]]
plot(elevation2)

# passing from points to a countinuous surface
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2)

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl)

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)
plot(densitymap, col=cl)

clnew <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(densitymap, col=clnew)

plot(bei.extra)

elev <- bei.extra[[1]] # bei.extra$elev
plot(elev)

# multiframe
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)

par(mfrow=c(2,1))
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

#-----------------------

# 02.2 Population distribution

# Why populations disperse over the landscape in a certain manner?

library(sdm)
library(terra)

file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)
rana$Occurrence

plot(rana)

# Selecting presences
pres <- rana[rana$Occurrence==1,]
plot(pres)

# exercise: select absence and call them abse
abse <- rana[rana$Occurrence==0,]
plot(abse)

# exrecise: plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# your new friend in case of graphical nulling:
dev.off()

# exercise: plot pres and abse altogether with two different colours
plot(pres, col="dark blue")
points(abse, col="light blue")

# predictors: environmental variables
# file <- system.file("external/species.shp", package="sdm")
# rana <- vect(file)

# elevation predictor
elev <- system.file("external/elevation.asc", package="sdm") 
elevmap <- rast(elev) # from terra package
plot(elevmap)
points(pres, cex=.5)

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <- rast(temp) # from terra package
plot(tempmap)
points(pres, cex=.5)

# exrcise: do the same with vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm") 
vegemap <- rast(vege) # from terra package
plot(vegemap)
points(pres, cex=.5)

# exrcise: do the same with vegetation cover
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) # from terra package
plot(precmap)
points(pres, cex=.5)

# final multiframe

par(mfrow=c(2,2))

# elev
plot(elevmap)
points(pres, cex=.5)

# temp
plot(tempmap)
points(pres, cex=.5)

# vege
plot(vegemap)
points(pres, cex=.5)

# prec
plot(precmap)
points(pres, cex=.5)

#-----------------------

#03.1 Commmunity multivariate analysis

library(vegan)

data(dune)
head(dune)

ord <- decorana(dune)

ldc1 =  3.7004 
ldc2 =  3.1166 
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1
pldc2

pldc1 + pldc2

plot(ord) 

#-----------------------

#03.2 Communities overlap

# relation among species in time

library(overlap)

data(kerinci)
summary(kerinci)

kerinci$timeRad <- kerinci$Time * 2 * pi

tiger <- kerinci[kerinci$Sps=="tiger",]

timetig <- tiger$timeRad
densityPlot(timetig, rug=TRUE)

# exercise: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)

timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)

overlapPlot(timetig, timemac)

#-----------------------

#04 Remote sensing data visualization

# RS data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools

library(imageRy)
library(terra)
# in case you have not terra
# install.packages("terra")

# list the data
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif") 

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(b2, col=cl)

# import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)

# import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# import the NIR band from Sentinel-2 (band 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

# multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stack images
stacksent <- c(b2, b3, b4, b8)
dev.off() # it closes devices
plot(stacksent, col=cl)

plot(stacksent[[4]], col=cl)

# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, r=4, g=3, b=2)
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent)
