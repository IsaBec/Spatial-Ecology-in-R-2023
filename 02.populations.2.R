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
