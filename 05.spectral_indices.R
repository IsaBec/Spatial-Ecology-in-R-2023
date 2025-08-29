##vegetation 

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
