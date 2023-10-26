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
