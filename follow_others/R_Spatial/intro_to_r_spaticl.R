
x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap") 
lapply(x, library, character.only = TRUE)

lnd <- readOGR(dsn = './R/from_github/Creating-maps-in-R/data/', layer = 'london_sport')

head(lnd@data, n = 2)
mean(lnd$Partic_Per)

head(lnd@polygons[[1]]@Polygons[[1]]@coords, n = 3)
plot(lnd@polygons[[1]]@Polygons[[1]]@coords)


plot(lnd)
plot(lnd@data)

lnd@data[lnd$Partic_Per < 15, ]
sel <- lnd$Partic_Per > 20 & lnd$Partic_Per < 25
plot(lnd[sel, ])
head(sel)

plot(lnd, col = 'lightgrey')
sel <- lnd$Partic_Per > 25
plot(lnd[sel, ], col = 'turquoise', add = TRUE)

names(lnd)
lnd$name
qtm(shp = lnd, fill = c('Pop_2001', 'Partic_Per'), ncol = 2, fill.palette = c('Blues'))


print(lnd)

df <- data.frame(x = 1: 3, y = c(1/2, 2/3, 3/4))
mat <- as.matrix(df)
sp1 <- SpatialPoints(coords = mat)
class(sp1)
spdf <- SpatialPointsDataFrame(sp1, data = df)
class(spdf)


## Setting and transforming CRS in R
proj4string(lnd) <- NA_character_
proj4string(lnd) <- CRS('+init=epsg:27700')

EPSG <- make_EPSG()
EPSG[grepl('WGS 84$', EPSG$note), ]

lnd84 <- spTransform(lnd, CRS('+init=epsg:4326'))


## Attributes Join
plot(lnd)
nrow(lnd)
crime_data <- read.csv('./from_github/Creating-maps-in-R/data/mps-recordedcrime-borough.csv', stringsAsFactors = FALSE)
head(crime_data, 3)

crime_theft <- crime_data[crime_data$CrimeType == 'Theft & Handling', ]
head(crime_theft, 3)


crime_ag <- aggregate(CrimeCount ~ Borough, FUN = sum, data = crime_theft)
head(crime_ag)

crime_ag <- crime_theft %>%
    select(CrimeCount, Borough) %>%
    group_by(Borough) %>%
    summarise(CrimeCount = sum(CrimeCount))
head(crime_ag)


lnd$name %in% crime_ag$Borough

lnd$name[!lnd$name %in% crime_ag$Borough]

crime_ag$Borough[!crime_ag$Borough %in% lnd$name]
crime_ag[crime_ag$Borough == 'NULL', ]

crime_ag <- rename(crime_ag, name = Borough)
head(crime_ag)

lnd@data <- left_join(lnd@data, crime_ag, by = 'name')
head(lnd@data)
nrow(lnd@data)

library(tmap)
qtm(lnd, 'CrimeCount')
qtm(shp = lnd, fill = c('CrimeCount', 'Partic_Per', 'Pop_2001'), 
    nrow = 2)

## Clipping and spatial joins
library(rgdal)
stations <- readOGR(dsn = './R/from_github/Creating-maps-in-R/data/', layer = 'lnd-stns')

proj4string(stations)
proj4string(lnd)

bbox(stations)
bbox(lnd)

stations27700 <- spTransform(stations, 
                             CRSobj = CRS(proj4string(lnd)))
stations <- stations27700
rm(stations27700)

plot(lnd)
points(stations)
summary(stations)

stations_backup <- stations
stations <- stations_backup[lnd, ]
plot(stations, add = T)

sel <- over(stations_backup, lnd)
head(sel)
head(stations_backup)
stations_2 <- stations_backup[!is.na(sel[, 1]), ]
plot(stations_2)

stations_agg <- aggregate(x = stations['CODE'], by = lnd,
                          FUN = length)
head(stations_agg@data)

lnd$n_points <- stations_agg$CODE


lnd_n <- aggregate(stations['NUMBER'], by = lnd, FUN = mean)
brks <- quantile(lnd_n$NUMBER)
brks

labs <- grey.colors(n = 4)
q <- cut(lnd_n$NUMBER, brks, labels = labs, include.lowest = T)
summary(q)

qc <- as.character(q)
plot(lnd_n, col = qc)
legend(legend = paste0('Q', 1: 4), fill = levels(q), 'topright')
areas <- sapply(lnd_n@polygons, function(x) x@area)
plot(lnd_n$NUMBER, areas)

levels(stations$LEGEND)
seq <- grepl('A Road Sing|Rapid', stations$LEGEND)
sym <- as.integer(stations$LEGEND[sel])


## Making maps with tmap, ggplot2 and leaflet

vignette(package = 'tmap')
vignette('tmap-nutshell')

qtm(shp = lnd, fill = 'Partic_Per', fill.palette = '-Blues')
qtm(shp = lnd, fill = c('Partic_Per', 'Pop_2001'),fill.palette = c('Blues'), ncol = 2)

tm_shape(lnd) + 
    tm_fill('Pop_2001', thres.poly = 0) + 
    tm_facets('name', free.coords = T, drop.shapes = T) + 
    tm_layout(legend.show = F, 
              title.position = c('center', 'center'),
              title.size = 20)

p <- ggplot(lnd@data, aes(Partic_Per, Pop_2001)) +
    geom_point(aes(color = Partic_Per, size = Pop_2001)) +
    geom_text(size = 2, aes(label = name))
    
print(p)

lnd_f <- fortify(lnd)
summary(lnd_f)
head(lnd_f, 2)
row.names(lnd)
lnd$id <- row.names(lnd)
head(lnd@data, 2)

lnd_f <- left_join(lnd_f, lnd@data, by = 'id')
head(lnd_f)

ggplot(lnd_f, aes(x = long, y = lat, 
                  group = group, fill = Partic_Per)) +
    geom_polygon() +
    coord_equal() +
    labs(x = 'Easting(m)', y = 'Northing(m)',
         fill = '% Sports\nParticipations') +
    ggtitle('London Sports Participations') +
    scale_fill_gradient(low = 'white', high = 'black')


lnd84 <- readRDS('./R/from_github/Creating-maps-in-R/data/lnd84.Rds')
summary(lnd84)

bb <- bbox(lnd84)
bb

b <- (bb - rowMeans(bb)) * 1.05 + rowMeans(bb)
b

lnb_b1 <- ggmap(get_map(location = b))

lnd_wgs84_f <- fortify(lnd84, region = 'ons_label')
summary(lnd_wgs84_f)

unique(lnd_wgs84_f$id)
unique(lnd84@data$ons_label)

head(lnd84@data)

lnd_wgs84_f <- left_join(lnd_wgs84_f, lnd84@data,
                         by = c('id' = 'ons_label'))
str(lnd_wgs84_f)

lnb_b1 + geom_polygon(data = lnd_wgs84_f,
                      aes(x = long, y = lat, group = group,
                          fill = Partic_Per),
                      alpha = 0.5)

lnd_b2 <- ggmap(get_map(location = b, source = 'stamen',
                        maptype = 'toner', crop = T))
print(lnd_b2)

lnd_b2 + geom_polygon(data = lnd_wgs84_f, 
                      aes(x = long, y = lat, group = group,
                          fill = Partic_Per),
                      alpha = 0.5)

lnd_b3 <- ggmap(get_map(location = b, source = 'stamen',
                        maptype = 'toner', crop = T,
                        zoom = 11))
lnd_b3 + geom_polygon(data = lnd_wgs84_f, 
                      aes(x = long, y = lat, group = group,
                          fill = Partic_Per),
                      alpha = 0.5)

library(leaflet)
leaflet() %>%
    addTiles() %>%
    addPolygons(data = lnd84)

london_data <- read.csv('./from_github/Creating-maps-in-R/data/census-historic-population-borough.csv')
library(tidyr)
head(london_data)
london_data_tidy <- gather(london_data, date, pop, -Area.Code, -Area.Name)
head(london_data_tidy)

head(lnd_f, 2)

london_data <- rename(london_data_tidy, ons_labels = Area.Code)
head(london_data)
lnd_f <- left_join(lnd_f, london_data, by = 'ons_labels')

















