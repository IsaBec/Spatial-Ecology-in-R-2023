###missed class
### Classifying satellite images and estimate the amount of change

library(terra)
library(imageRy)
library(ggplot2)

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





######PEDRITO'S CODE + my notes
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



p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
