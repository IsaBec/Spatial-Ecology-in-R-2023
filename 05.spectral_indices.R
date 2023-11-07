##vegetation 

library(imageRy)
library(terra)

im.list()  ##see objects we are going to use
im.list("matogrosso_l5_1992219_lrg.jpg")

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
## bands: 1=NIR, 2=red, 3= greens

im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 2, 1, 3)
im.plotRGB(m1992, 2, 3, 1)

#import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, 2, 3, 1)
