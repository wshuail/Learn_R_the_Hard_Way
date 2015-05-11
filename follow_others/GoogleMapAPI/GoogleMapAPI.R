# Using google map API and R
# This tutorial is avaliable at: http://url9.org/baoZ

# This script uses RCurl and RJSONIO to download data from
# Google's API: latitude, longtitude, location type.
# There is a limite of 2500 call every day.

library(RCurl)
library(RJSONIO)
library(plyr)

# get the correct url
url <- function(address, return.call = 'json', sensor = 'false'){
     root <- 'http://maps.google.com/maps/api/geocode/'
     u <- paste(root, return.call, '?address=', address,
               '&sensor=', sensor, sep = '')
     return (URLencode(u))
}

# parse the information we want 
getCode <- function(address, verbose = FALSE){
     if (verbose)
          cat(address, '\n')
     u <- url(address)
     doc <- getURL(u)
     x <- fromJSON(doc, simplify = FALSE)
     if (x$status == 'OK'){
          lat <- x$result[[1]]$geometry$location$lat
          lng <- x$result[[1]]$geometry$location$lng
          location_type <- x$result[[1]]$geometry$location_type
          formatted_address <- x$result[[1]]$formatted_address
          return (c(lat, lng, location_type, formatted_address))
          Sys.sleep(0.5)
     } else{
          return (c(NA, NA, NA, NA))
     }
}

# test with a single address
address <- c('The White House, Washington, DC',
             'The Capitol, Washington, DC')
locations <- ldply(address, function(x) getCode(x))
names(locations) <- c('lat', 'lon', 'location_type', 'formatted_address')
head(locations)

# get the address of Brown University
address_BU <- c('Brown University, Providence, RI')
location_BU <- ldply(address, function(x) getCode(x))
names(location_BU) <- c('lat', 'lon', 'location_type', 'formatted_address')
location_BU

