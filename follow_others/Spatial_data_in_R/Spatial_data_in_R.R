# http://pakillo.github.io/R-GIS-tutorial/

library(sp)  # classes for spatial data
library(raster)  # grids, rasters
library(rasterVis)  # raster visualisation
library(maptools)
library(rgeos)
library(dismo)


mymap <- gmap('France')
plot(mymap)


mymap <- gmap('France', type = 'roadmap')
plot(mymap)
mymap <- gmap('France', type = 'hydrid')
plot(mymap)
mymap <- gmap('France', type = 'terrain')
plot(mymap)
mymap <- gmap('France', type = 'satellite', exp = 3, 
              filename = 'france,png')
plot(mymap)

mymap <- gmap('Europe')
plot(mymap)
select.area <- drawExtent()
mymap <- gmap(select.area)
plot(mymap)


## RgoogleMaps: Map your data onto Google Map tiles ------------
library(RgoogleMaps)
newmap <- GetMap(center = c(36.7, -5.9), zoom = 10, 
                 destfile = "newmap.png", 
                 maptype = "satellite")


# Now using bounding box instead of center coordinates:
newmap2 <- GetMap.bbox(lonR = c(-5, -6), latR = c(36, 37), 
                       destfile = "newmap2.png", 
                       maptype = "terrain")

# Try different maptypes
newmap3 <- GetMap.bbox(lonR = c(-5, -6), latR = c(36, 37), 
                       destfile = "newmap3.png", 
                       maptype = "satellite")

PlotOnStaticMap(lat = c(36.3, 35.8, 36.4), lon = c(-5.5, -5.6, -5.8), 
                zoom = 10, cex = 4, pch = 19, col = "red", 
                FUN = points, add = F)


## googleVis: visualise data in a web browser using 
## Google Visualisation API

library(googleVis)
data("Exports")
geo <- googleVis::gvisGeoMap(Exports, locationvar = 'Country',
                             numvar = 'Profit',
                             options = list(height = 400,
                                            dataMode = 'regions'))
plot(geo)

data(Andrew)
M1 <- gvisMap(Andrew, "LatLong", "Tip", 
    options = list(showTip = TRUE, showLine = F, 
                   enableScrollWheel = TRUE, 
    mapType = 'satellite', useMapTypeControl = TRUE, 
    width = 800, height = 400))
plot(M1)












