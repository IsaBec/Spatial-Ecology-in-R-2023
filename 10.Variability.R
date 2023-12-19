# measurement of RS based on variability
library(terra)
library(imageRy)
library(viridis)

im.list()
sent <- im.import("sentinel.png")

#plot image
#band 1= NIR
#band 2= red
#band 3= grreen
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)  #veg in green bare soil/rocks violet

nir <- sent[[1]]
plot(nir)

##calculate sd of a moving window all over 
#function focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)  #variable (band), matrix- composed by 9 pixels 1-9, distributed 3 x 3, and then sd

##color and plot
viridis <- colorRampPalette(viridis(7))(255)  ##seven diff colors of viridis palette, 255 amount of colors used
plot(sd3, col=viridis)

