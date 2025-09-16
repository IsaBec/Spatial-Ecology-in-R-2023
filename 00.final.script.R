##Final script including all diff scripts during lectures

#summary with Duccio's code
#01 Beginning
#02.1 Population density
#02.2 Population distribution
#03.1 Commmunity multivariate analysis
#03.2 Community overlap
#04 Remote sensing data visualization
#05 Spectral indices
#06 Time series
#07.1 External data code
#07.2 External data import
#08 Copernicus data
#09 Classification
#10 Variability
#11 Principle component analysis

#-----------------------
#01 Beginning
# Here I can write anything I want!!! 42 is the meaning of life univcerse and all!

# Here I can write anything I want
# part of the exam is actually manner of how much you comment your code because the comments help to understand what the code is running.

# R as a calculator
2+3

# Assign to an object
zima <- 2+3

duccio <- 5+3
duccio

zima*duccio

final <- zima*duccio
final
final^2

# Array
sophi <- c(10, 20, 30, 50, 70) # microplastics 
#to concatenate all the numbers and allow R to read an array we use the function c()
#inside the functions there are the arguments

paula <- c(100, 500, 600, 1000, 2000) # people

plot(paula, sophi)
plot(paula, sophie, xlab="number of people", ylab="microplastics")

people <- paula
microplastics <- sophie

plot(people, microplastics, pch=19, cex=2, col="blue")
#pch = point character https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6gmJapH_j6E3zWbTCOuDKJDUrH80VvTYdgCNVMh16OA&s
#cex = character exageration, it defines the dimensions of the points
#col = color

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
plot(bei, cex=.2) #decereases the size of the dots plotted (cex=0.5)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev) # $ linking elev and dataset
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements, when you dont know the variable name double [] bc they are images
elevation2 <- bei.extra[[1]]
plot(elevation2)

###look at density - build density map
#passing from points to a continuous surface -interpl
densitymap <- density(bei)
densitymap
plot(densitymap)

##put points on density map (adding)
points(bei, cex=.2)    #right after plot(densitymap) so yoy dont overwrite other function

##change color for daltonics!

cl <- colorRampPalette(c("black","red","orange","yellow"))(100)    # case sensitive #the 100 is the gradient
plot(densitymap, col=cl)

cl <- colorRampPalette(c("black","red","orange","yellow"))(4)   ##no continuity bc gradient very low (bc of 4)
plot(densitymap, col=cl)      

##to find colors in R google color names in R
#create a map with own colors
cl <- colorRampPalette(c("cyan3","snow","darkorchid1","darkgreen"))(100)   
plot(densitymap, col=cl)

##additional variables
plot(bei.extra)    #gradient and elevation
#want to select only one (first)
elev <- bei.extra[[1]] #since image double quadrats (similar to parenthesis)
## can also be done: bei.extra$elev
plot(elev)

##multiframes- several variables
#first create a multiframe for two elements
par(mfrow=c(1,2)) #1 row, 2 columns
#plot inside the two frames
plot(densitymap)
plot(elev)
##have to grab all three elements for it to plot them together

##in case you want to put placemenet differently one on top of another
par(mfrow=c(2,1))    #so 2 rows, 1 column
plot(densitymap)
plot(elev)

##multiframe with three elements 
par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

#-----------------------

# 02.2 Population distribution

# Why populations disperse over the landscape in a certain manner?
#predictors - environmental variables - why distribution is like that
#first look at path of file
## can be like this: path <- system.file("external", package="sdm") 
#or directly as done previously. deal with rasters (images)
#file <- system.file("external/species.shp", package="sdm")
#rana <- vect(file) 

library(sdm) #species distribution model sdm
library(terra)

file <- system.file("external/species.shp", package="sdm")

rana <- vect(file) #spatial vector
rana$Occurrence #codes-these are presence absences of data
#zero is uncertain data (in this case real absence)

plot(rana)

# Selecting presences #called species in rocchini's code
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
dev.off() #close other graphs, in case of graphical nulling

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

#change color
cl.veg <- colorRampPalette(c("light blue","snow","darkorchid1","darkgreen"))(100) 
plot(vegemap, col=cl.veg)
points(pres,cex=.5)

# exrcise: do the same with vegetation cover
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) # from terra package
plot(precmap)
points(pres, cex=.5)

# final multiframe- plot everything together

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
#ordination methods are basically multivariate analysis
#there are different datasets:
data(dune)  #show data
dune ##see the data
##or use head, shows only first 6 rows
head(dune)

#tail can also be used

#decorana detrended correspondence analysis
#another methods nonlinear multivariate scaling, mds, correspondence analysis-- all multivariate analysis
decorana(dune)
ord <-decorana(dune)
ord
##values interested is length of x-axis
##eg 1st axus DCA1 3.7004

##length of each
ldc1=3.7001
ldc2=3.1166
ldc3=1.30055
ldc4=1.47888

total= ldc1+ldc2+ldc3+ldc4

##percentage that each takes of the axis but when you plot it already knows which takes up the majority
pldc1=ldc1 * 100/total
pldc2=ldc2 * 100/total
pldc3=ldc3 * 100/total
pldc4=ldc4 * 100/total

pldc1
pldc2

pldc1+pldc2  ##these two axis encompass 71% of data 

#from the table it is almost impossible to understand the correspondence between the species, therefort I use a plot with only 2 axis

plot(ord) ##see final multivar space
##cannot see variable analysis with the table

#-----------------------

#03.2 Community overlap

# relation among species in time

# camera traps data
# data from Kerinci-Seblat National Park in Sumatra, Indonesia (Ridout and Linkie, 2009)
# Ridout MS, Linkie M (2009). Estimating overlap of daily activity patterns from camera trap data. 
# Journal of Agricultural, Biological, and Environmental Statistics, 14(3), 322–337.
##relation of species in time, overlap (space multivariate analysis)

library(overlap)
data(kerinci)

# tiger
# The unit of time is the day, so values range from 0 to 1. 
head(kerinci)

summary(kerinci)
#3 columns, zone, species, and time
tiger <- kerinci[kerinci$Sps=="tiger", ] ##comma closes queary

summmary(tiger)

##circular time, to make it from linear to round
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi
kerinci$Timerad <- kerinci$Time * 2 * pi
  head(kerinci)  ##see extra column
tiger <- kerinci[kerinci$Sps=="tiger", ]   
head(tiger) ##see additional column

plot(tiger$Timerad)

##or create new variable for time of tiger, kernel densities = amount of time in an axis

timetig <- tiger$Timerad
densityPlot(timetig, rug=TRUE)  #rug to smooth line

##another species .. excercise: select only the data on the macaque individuals
##use summary(kerinci) to see monkey name: macaque
maca <- kerinci[kerinci$Sps=="macaque", ]   
head(maca)

# selecting the time for the macaque
timemaca <- maca$Timerad
densityPlot(timemaca, rug=TRUE)
# the macaque is quite different from the tiger: the tiger has two peaks, whereas the macaque concentrates most of the data in the central part of the day

##check if there is a time where tiger can eat macaque, the two can meet
#overlap, overlapping kernel densities
overlapPlot(timetig, timemaca)
##grey part is overlap

#-----------------------

#04 Remote sensing data visualization

# RS data

### This is a script to visualize satellite data
# colors are representing the amount of reflectance of a pixel in a certain wavelenght
# plants use mostly red light to carry out photosynthesis

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")    ##another manner to install

library(imageRy)
library(terra)###
##lec 

#####what I did
install.packages("devtools")
yes
library(devtools)
install_github("ducciorocchini/imageRy") ###answer comments
library(imageRy)

###functions inside imagery start with im 
im.list() ###function for lists
##"sentinel.dolomites.b2.tif" ----- use sentinel -- satellite, dolomites 
##--taken in the dolomites (place), b2.etc- means diff bands-- b1 us coastal aerosol, b2 blue, b3 green,
        ##(how much they reflect in that wavelength etc
##four bands of the same resolution 
# to make measuraments you use ellipsoids
# different ellipsoids are used in different regions to match the geoid perfectly
# datum = ellipsoid and where it is put [ex. Clark + Italy]

# the latitude is measured as the angle beetween a line perpendicular to the surface of the Earth and the equator
# if Earth is rapresented as a sphere the perpendicular line will intersect the center, but this is not the case for the ellipsoid
# when you provide lat and long you should also provide the datum you are using

# the world geodetic system (WGS) 84 is the one we are using.

# UTM is a map projection (way to represent the spherical Earth on a plane) system to assign cordinates to location to locations on the Earth surface
# if you know the initil reference system you can "translate it" to another one


# importing data
# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength  ##"" bc its saved like that in r
b2    ##get info on file, raster- image

###Lec 10
##earth geoid shape ##not a sphere
###use ellipsoid surface as reference of geoid surface

##continued

clb <-colorRampPalette(c("dark grey", "grey", "light grey"))(100)
plot(b2, col=clb)

##import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") # b2 is the green wavelength
b3
plot(b3, col=clb)


######
##class missed
##
##repeated below caught up
##copied
# stack images all together
stacksent <- c(b2, b3, b4, b8)

plot(stacksent, col = cl)

# to plot just one layer from the stack we can use the number of the "element" (layer)
plot(stacksent[[4]], col = cl)

# Let's put all the images in a single graph
# EXERCISE: Plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

cl2 <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
cl3 <- colorRampPalette(c("dark green", "green", "light green")) (100)
cl4 <- colorRampPalette(c("firebrick4", "firebrick", "red")) (100)
cl8 <- colorRampPalette(c("orangered", "gold", "yellow")) (100)

par(mfrow = c(2,2))
plot(b2, col = cl2)
plot(b3, col = cl3)
plot(b4, col = cl4)
plot(b8, col = cl8)


############################################################
###### RGB space #######
############################################################
# if the components are 3, we can use only 3 bands per time
# b2 = B; b3 = G; b4 = R; b8 = NIR (near infrared)
# then we associate each band to a specific component

#stacksent : 
#band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)

#we can change the position of the NIR, putting in the red component or in the green component
# (the highest amount of informations are given by nir)
im.plotRGB(stacksent, r=4, g=3, b=2) #you can see two types of vegetation: the dark part is forest, de light red is grassland
im.plotRGB(stacksent, r=3, g=4, b=2) #everything that is becoming fluorescent green is vegetation; bare soil is in violet
#final composition in which we can use the NIR: moving it from the green component to the blue one
im.plotRGB(stacksent, r=3, g=2, b=4) #everything reflecting the nir will become blue; cities in yellow



#####
##library(imageRy)
##library(terra)   to load again
# importing data
# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength
b2

# green band
b3 <- im.import("sentinel.dolomites.b3.tif") # b3 is the green wavelength
b3

# red band
b4 <- im.import("sentinel.dolomites.b4.tif") # b4 is the red wavelength
b4

# NIR band
b8 <- im.import("sentinel.dolomites.b8.tif") # b8 is the NIR wavelength
b8

###stack images

stacksent <- c(b2, b3, b4, b8)
dev.off() # it closes devices
plot(stacksent, col=cl)

# RGB space--- color venn diagram for red green blue (rgb) 
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)        ##r,g,b colors
im.plotRGB(stacksent, r=4, g=3, b=2)         ##everyhting red is vegetation, reflectance (near infrared on top of red)

im.plotRGB(stacksent, r=3, g=4, b=2)        ##everything green is vegetation, bare soil, roads etc will be violet
im.plotRGB(stacksent, r=3, g=2, b=4)        ## blue veg reflecting IR (bc more info by infrared)


##see if info is correlated with each other (bands) see how pixels relate to each other
##pairs - scatterplot matrices 
pairs(stacksent)        ## its gonna be 6 4x3)/2 idk 

#you obtain the graphs and the Pierson correlation coefficient.
#all the visible bans are highly correlated to each otehr
#if you use the nir, the values of correlation are lower, which means that this band is adding additional informations.

#-----------------------

#05 Spectral indices
# vegetation indices

library(imageRy)
library(terra)

im.list()  ##see objects we are going to use
im.list("matogrosso_l5_1992219_lrg.jpg")  ###doesnt work

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
## bands: 1=NIR, 2=red, 3= green
#it will make directly the plot of the image, with a 30m pixel resolution
#this image has been processed

im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 2, 1, 3) ##green infrared
im.plotRGB(m1992, 2, 3, 1) ##inr blue

#import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, 2, 3, 1)


##build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))    # 1 rows, 2 column
plot(m1992)
plot(m2006)


##or
##par(mfrow=c(1,2)) 
##im.plotRGB(m1992, 2, 3, 1)
##im.plotRGB(m2006, 2, 3, 1)

##plot
plot(m1992[[1]])

##using bits-- 1 bit=1 or 0 - binary code
##1 bit 2 info
# 2 bits 4
# 3 bits 8 info  
# 4 bits 16 info
# range bt 2-255

##diff bt 1st band in 1992 and second band of 1992
##dvi= NIR-RED
##the range of reflectance is from 0 to 255: this is because reflectance is the ratio between the incident flux of energy and the reflected flux
##but this would lead to float numbers and we want to avoid them because they require space in our computer.
##therefore, we use bits: 1 bit = or 0 or 1: the BINARY CODE
##we can use binary code to build every information in the computer
##With 1 bit you have 2 information: 0 or 1.
##With 2 bits you have 4 information: 00, 01, 10, 11
##With 3 bits you have 8 info
##with 4 bits you have 16 info
##most of the images are storaged in 8 BIT: they are a lot of information but reducing the storaging space required.

##a tree is reflecting a lot in the NIR and absorbing a lot in the RED
##DVI = DIFFERENCE VEGETATION INDEX ---> you make the difference between the total bits and the REDs (ex. 255-10 = 245 is the DVI of a living plant; 255-
##DVI = difference between NIR and RED

dvi1992=m1992[[1]]-m1992[[2]]
plot(dvi1992)
##green is healthy rest is suffering forest or bare soil
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi1992, col=cl)

##excercise: calculate dvi of 2006

dvi2006=m2006[[1]]-m2006[[2]]
plot(dvi1992)
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi2006, col=cl)


##to solve issue of range, 1992 large range and 2006 small range you can standarize
### eg 230-10/230+10=0.91
##or 3-1/3+1=0.5 ===== NDVI range from -1 to 1
##DVI radiometric resolution so NDVI better
##calculate NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
##or ndvi1992=dvi1992/(m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)
#you can see the new range is from -1 to 1 so it can be compared to any kind of image since the range will be the same
#the dark red parts indicate the healthy vegetation

##2006
ndvi2006 = (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

## plot
par(mfrow=c(1,2)) 
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

##another palette
# scientifically meaningful image for everyone!
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
par(mfrow=c(1,2)) 
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

##calculayes ndvi specifying NIR and red bands
##speeding up calculation use function:
ndvi2006a <- im.ndvi(m2006,1,2)
plot(ndvi2006a, col=cl)

#-----------------------

#06 Time series

# time series analysis

##time series analysis

library(imageRy)
library(terra)

##coronavirus pollution drop (NO2) heat maps

im.list()
EN01 <-im.import("EN_01.png")    ##situation in europe in junuary
EN13 <-im.import("EN_13.png")  #march

par(mfrow=c(2,1))
im.plotRGB.auto(EN01) ##directly in rgb bc of auto
im.plotRGB.auto(EN13)

##show difference bt bands, using first element of images -- i make the difference between the two images (january - march), using the first element (band)
dif = EN01[[1]]-EN13[[1]]
plot(dif)

##change color, common used but avoided, single or double quotes the same
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cldif)


##temp change(increase) in Greenland - #in the middle of greenland you have a huge area with very low temperatures

g2000<- im.import("greenland.2000.tif")
clg <- colorRampPalette(c('black','blue','yellow','red'))(100)
plot(g2000, col=clg)

g2005<- im.import("greenland.2005.tif")
g2010<- im.import("greenland.2010.tif")
g2015<- im.import("greenland.2015.tif")

plot(g2015,col=clg)

par(mfrow=c(2,1))
plot(g2005,col=clg)
plot(g2015,col=clg)

##stack images-data
stackg <-c(g2000,g2005,g2010,g2015)
plot(stackg, col=clg)
#stacking the data, with all bands together
####instead of importing and plotting them differently

#Exercise: make the diff bt 2000 and 2005 (first and the final elements of the stack)
difg <-stackg[[1]]-stackg[[4]]
##or difg <- g2000-g2015
plot(difg,col=cldif)
##shows high loss in greenland in the middle


##all images in stack together, but now first band will be placed in red, second (2005) placed in green and 2010 in blue
##Exercise: make RGB plot using diff years
im.plotRGB(stackg, r=1, g=2,b=3)

# in the western part you have the high temperature of the inland of the American continent, but also on the Greenland western coasts

##the im.plotRGB function gives you a plot in the RGB color with different layers:
## in this case we specify that the red color is associated to the first layer, the green to the second one and the blue to the third one. You can only work with 3 layers.
## Therefore, you represent the three layers (in this case, they are the same images from three diffrent years) and, depending on the color you have, you understand which layer (picture of which year)
##has the main influnece in that point.
## we took the first three images (1,2,3 = g2000, g2005, g2010)

#-----------------------

#07.1 External data code

##External data

library(terra)

#set the working directory based on your path:
##setwd("/Users/alvarobecdach/Downloads")

##my case 
setwd("/Users/alvarobecdach/Documents/Spatial Ecology in R")

naja2003 <-rast("najafiraq_etm_2003140_lrg.jpeg")  ##same thing as im.import() 

##previously using im.plotRGB 
##now
plotRGB(naja2003, r=1,g=2, b=3)

##second image 2023 of same place
naja2023 <-rast("najafiraq_oli_2023219_lrg.jpeg") 
plotRGB(naja2023, r=1,g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja2003, r=1,g=2, b=3)
plotRGB(naja2023, r=1,g=2, b=3)

##multitemporal change detection
najadif=naja2003[[1]]-naja2023[[1]]
cl <- colorRampPalette(c("brown", "grey", "orange"))(100)
plot(najadif, col=cl)

###own example Quito urbanization 1986-2019

quito1986 <-rast("quito432_tm5_1986259_lrg.jpeg")
quito2019 <-rast("quito543_oli_2019237_lrg.jpeg")

par(mfrow=c(2,1))
plotRGB(quito1986, r=2, g=1, b=3)
plotRGB(quito2019, r=2, g=1, b=3)    ### see better changes it is infrared 1,2,3 green 3,2,1 is blue 

quitodif=quito1986[[1]]-quito2019[[1]]
clq <- colorRampPalette(c("brown", "orange","blue"))(100)
plot(quitodif, col=clq)

#-----------------------

#07.2 External data import

##Available data:
#Earth Observatory (NASA):
#https://earthobservatory.nasa.gov/

#Video: https://www.youtube.com/watch?v=_aDeRFqZVgA

#Sentinel-2 data (ESA, 10m):
#https://www.youtube.com/watch?v=KA2L4bDmo98

#Landsat (30m) and MODIS (>500m) data (NASA):
#https://www.youtube.com/watch?v=JN-P04Dkx48

#Copernicus (ESA):
#https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

#Steps:
#Step 1:
#Download an image from the network

#Step 2:
#Store iot in your computer

#Step 3:
#Set the working directory: setwd("yourpath")

#Step 4:
#Import the data: library(terra) name <- rast("yourdata_in_the_working_directory")

#-----------------------

#08 Copernicus data

# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

install.packages("ncdf4")
library(ncdf4)
library(terra)

#in COPERNICUS-- there are four main variables:VEGETATION, ENERGY,WATER CYCLE AND CRYOSPHERE

###VEGETATION:
#FAPAR -> fraction of absorbed photosynthetically active radiation. 
          #Related to the red band (used by plants for photosynthesis)
#NDVI -> Normalized difference vegetation index
#VCI -> vegetation condition index. it compares the current NDVI to the range of 
          #values observed during the same period in previous years
#VPI -> vegetation productivity index. it assess the vegetation condition by referencing the
          #current value of the NDVI with the long-term statistics for the same period.
#dry matter productivity -> represents the overall growth rate
#burnt area -> maps the burnt scars over the planet.
#surface soil moisture
#soil water index -> is the relative water content of the top few centimeters of soil.


###ENERGY:
#top of canopy reflectance -> the spectral reflectance by the fraction at the top of vegetation, soil, houses (or whatever)
#surface albedo 
#land surface temperature -> the radiative skin surface temperature of land


###WATER CYCLE
#water temperatures of lakes LSWT 
#lake water quality -> monitoring water quality in lakes and reservoirs is key in maintaining safe water ...
#estimate of water bodies present in the whole planet
#water level

###CRYOSPHERE
#Snow cover -> estimate of the amount of snow in a certain area
#lake ice extent
#snow water equivalence -> passage from solid (snow) to liquid (water) phase

setwd("/Users/alvarobecdach/Downloads")
vegproperties <- rast("c_gls_LAI_202006130000_GLOBE_PROBAV_V1.5.1.nc")  ##put .nc or whatever the file ending

plot(vegproperties)  ##really image on leaf area index globally

plot(vegproperties[[1]])  ##get 1st image
cl <- colorRampPalette(c("red","orange","yellow"))(100)
plot(vegproperties[[1]], col=cl)

#using the function "crop()" to pick only a single region of our interest
ext <- c(10000, 13000, 3000,5000) ##min longitud, max longitud, min lat, max lat
vegpropertiesc <-crop(vegproperties[[1]], ext)
plot(vegpropertiesc, col=cl)

### download a second image
##crop in the same place and compare


###Class' example
soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023)

# there are two elements, let's use the first one!
plot(soilm2023[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2023[[1]], col=cl)

ext <- c(22, 26, 55, 57) # minlong, maxlong, minlat, maxlat
soilm2023c <- crop(soilm2023, ext)

plot(soilm2023c[[1]], col=cl)

# new image
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_24)
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)

#-----------------------

#09 Classification

# Classifying satellite images and estimate the amount of change

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun, num_clusters=3)

# classify satellite data

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
  
m1992c <- im.classify(m1992, num_clusters=2)                    
plot(m1992c)
# classes: forest=1; human=2

m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)
# classes: forest=1; human=2

par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

f1992 <- freq(m1992c)
f1992
tot1992 <- ncell(m1992c)
# percentage
p1992 <- f1992 * 100 / tot1992 
p1992
# forest: 83%; human: 17%

# percentage of 2006
f2006 <- freq(m2006c)
f2006
tot2006 <- ncell(m2006c)
# percentage
p2006 <- f2006 * 100 / tot2006 
p2006
# forest: 45%; human: 55%

# building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 

tabout <- data.frame(class, y1992, y2006)
tabout

# final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

#-----------------------

#10 Variability

# measurement of RS based variability

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
#we're going to calculate the variability. 
#the STD can be calculate only on one variable.
#but in this case we have 3 variables: the reflectance of the red, of the green and of the NIR

nir <- sent[[1]]
plot(nir)

# moving window
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

# Exercise: calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# Exercise 2: plot via par(mfrow()) the 3x3 and the 7x7 standard deviation
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

# original image plus the 7x7 sd
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)

#-----------------------
