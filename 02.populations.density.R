#code related to population ecology

#package is needed for point pattern analysis
install.packages("spatstat")
library(spatstat)  

#lets use the bei data:
#data description:
#https://CRAN.R-project.org/package=spatstat

bei

#plotttinng the data
plot(bei)

#canging dimension -cex
plot(bei, cex=0.5)  #decereases the size of the dots plotted
plot(bei, cex=0.2)

#changing the symbol -pch
plot(bei, cex=.2, pch=19)

#additional datasets
bei.extra
plot(bei.extra)

#lets use only part of the dataset: elev
bei.extra$elev  # $ linking elev and dataset
elevation <- bei.extra$elev
plot(elevation)
bei.extra


#second method to select elements, when you dont know the variable name double [] bc they are images
plot(bei.extra[[1]])
elevation2 <-bei.extra[[1]]
plot(elevation2)


#####Lec 5

install.packages("sdm")
install.packages("terra")
install.packages("rgdal")
Yes
library(sdm)
library(terra)
library(rgdal)

install.packages("spatstat")   ###bc new Rstudio
library(spatstat)


bei
plot(bei)

#changing dimension - cex
plot(bei, cex= 0.5)  #size of points  
plot(bei, cex=0.2)


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
    
