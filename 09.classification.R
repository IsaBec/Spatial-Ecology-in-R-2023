###missed class
### Classifying satellite images and estimate the amount of change
#grouping pixels can be used to represent the final class on a graph with red, infrared and so on on the axes.
#amount of pixels and the amount of proportion related to that.
#vegetation area are reflective a lot in the infrared area (not in the red since they are doing photosynthesis)
#water absorbs all the infrared light and may reflect red
#these pixels are called TRAINING SITES, something that can explain to the software which clusters (or classes) are present.
#if we want to classify a pixel, without knowing its class, we must use the reflectance of the pixel
#and use the SMALLEST DISTANCE FROM THE NEAREST CLASS, to estimate to which class the pixel is most probable to be part of.
#this way we can classify every pixel in the image by class.

library(terra)
library(imageRy)
library(ggplot2)

im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun, num_clusters=3)
sunc
plot(sunc[[1]])
#the third class is the class with the highest energy, but it could be the class 1 or 2 or 3
plot(sun) #you can tell that the top right part is the one with the highest energy
plot(sunc) # => the highest energy is the third class

# classify satellite data
 #from the original we can see that the class number 3 is the class with the highest energy level
        #we now apply this to the image of mato grosso to see if there is a change.
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





######PEDRITO'S CODE + my notes (MISSED CLASS)
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)


im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun)

plotRGB(sun, 1, 2, 3)
plot(sunc)

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c <- im.classify(m1992, num_clusters=2)  ###cluster 1 is forest, cluster 2 is agriculture in my case check picture to see
m2006c <- im.classify(m2006, num_clusters=2)

plot(m1992c)
plot(m2006c)

##see freq of each cluster
freq1992 <- freq(m1992c)
freq1992

freq2006 <- freq(m2006c)
freq2006

### this is percentage of each cluster
tot1992 = ncell(m1992)
perc1992 = freq1992 * 100 / tot1992
perc1992

tot2006 = ncell(m2006)
perc2006 = freq2006 * 100 / tot2006
perc2006

### create vectors with info
cover <- c("forest","agriculture")
perc1992 <- c(83.08, 16.91)
perc2006 <- c(45.31, 54.69)

p <- data.frame(cover, perc1992, perc2006)
p

### create bargraphs
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white")
p1+p2

       #one plot (p1) related to the 1992 and the other related to the 2006 image. 
        #Then to merge them together we have to use the function patchwork()

        #the problem now we have the problem of having two different scales in the two different images.
        #to have the same scale in each image graph we have to use add the specification to each line --> +ylim(c(0,100))
        #in this way the range in the y axis will be the same.

p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
