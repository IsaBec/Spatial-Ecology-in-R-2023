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


###Class' example
soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023)

# there are two elements, let's use the first one!
plot(soilm2023[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2023[[1]], col=cl)

ext <- c(22, 26, 55, 57) # minlong, maxlong, minlat, maxlat
soilm2023c <- crop(soilm2023, ext)

plot(soilm2023c[[1]], col=cl)

# new image
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_24)
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)
