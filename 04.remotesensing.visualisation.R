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
