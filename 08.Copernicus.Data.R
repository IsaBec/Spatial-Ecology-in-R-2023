# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

install.packages("ncdf4")
library(ncdf4)
library(terra)

setwd("/Users/alvarobecdach/Downloads")
vegproperties <- rast("c_gls_LAI_202006130000_GLOBE_PROBAV_V1.5.1.nc")  ##put .nc or whatever the file ending

plot(vegproperties)  ##really image on leaf area index globally

plot(vegproperties[[1]])  ##get 1st image
cl <- colorRampPalette(c("red","orange","yellow"))(100)
plot(vegproperties[[1]], col=cl)

ext <- c(10000, 13000, 3000,5000) ##min longitud, max longitud, min lat, max lat
vegpropertiesc <-crop(vegproperties[[1]], ext)
plot(vegpropertiesc, col=cl)

### download a second image
##crop in the same place and compare


