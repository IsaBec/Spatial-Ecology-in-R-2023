# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

install.packages("ncdf4")
library(ncdf4)
library(terra)

#in COPERNICUS-- there are four main variables:VEGETATION, ENERGY,WATER CYCLE AND CRYOSPHERE

###VEGETATION:
#FAPAR -> fraction of absorbed photosynthetically active radiation. 
          #Related to the red band (used by plants for photosynthesis)
#NDVI -> Normalized difference vegetation index
#VCI -> vegetation condition index. it compares the current NDVI to the range of 
          #values observed during the same period in previous years
#VPI -> vegetation productivity index. it assess the vegetation condition by referencing the
          #current value of the NDVI with the long-term statistics for the same period.
#dry matter productivity -> represents the overall growth rate
#burnt area -> maps the burnt scars over the planet.
#surface soil moisture
#soil water index -> is the relative water content of the top few centimeters of soil.


###ENERGY:
#top of canopy reflectance -> the spectral reflectance by the fraction at the top of vegetation, soil, houses (or whatever)
#surface albedo 
#land surface temperature -> the radiative skin surface temperature of land


###WATER CYCLE
#water temperatures of lakes LSWT 
#lake water quality -> monitoring water quality in lakes and reservoirs is key in maintaining safe water ...
#estimate of water bodies present in the whole planet
#water level

###CRYOSPHERE
#Snow cover -> estimate of the amount of snow in a certain area
#lake ice extent
#snow water equivalence -> passage from solid (snow) to liquid (water) phase

setwd("/Users/alvarobecdach/Downloads")
vegproperties <- rast("c_gls_LAI_202006130000_GLOBE_PROBAV_V1.5.1.nc")  ##put .nc or whatever the file ending

plot(vegproperties)  ##really image on leaf area index globally

plot(vegproperties[[1]])  ##get 1st image
cl <- colorRampPalette(c("red","orange","yellow"))(100)
plot(vegproperties[[1]], col=cl)

#using the function "crop()" to pick only a single region of our interest
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
