### This is a script to visualize satellite data

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

