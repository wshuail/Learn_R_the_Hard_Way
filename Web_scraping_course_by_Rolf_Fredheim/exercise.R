var <- 201401
url <- paste('http://stats.grok.se/json/en/', var, '/web_scraping', sep='')
url
browseURL(url)
rawdata <- readLines(url, warn = 'F')
rawdata
install.packages('rjson')
require(rjson)
rd <- fromJSON(rawdata)
rd
rd.view <- rd$daily_views
rd.view

rd.views <- unlist(rd.view)
rd.views
df <- data.frame(rd.views)
df
dim(df)
row.names(df)

fd <- fromJSON(readLines(url, warn = F))
df2 <- data.frame(unlist(fd$daily_views))
df2

require(lubridate)
df$Date <- as.Date(row.names(df))
df$Date
df
colnames(df) <- c('views', 'date')
df

require(ggplot2)
ggplot(df, aes(date, views)) +
        geom_line(color = 'red') +
        geom_smooth() +
        theme_bw(base_size = 20)

plusOne <- function(x){
        return (x +1)
}
plusOne(1)
plusOne(100)

plusTwo <- function(num){
        return (num + 2)
}
plusTwo(6)

for (num in 1:5){
        print (num)
}

a <- c(1, 2, 3, 4, 5)
for (num in a){
        print (plusOne(num))
}


for (i in 1:length(a)){
        print (plusTwo(a[i]))
}

a + 1

plusOne(a)

sapply(a, plusTwo)

for (month in 1:12){
        print (paste0(2014, month))
}


# save the data

dates <- NULL

for (month in 0:9){
        date <- paste0(2014, 0, month)
        dates <- c(dates, date)
}

for (month in 10:12){
        date <- paste0(2014, month)
        dates <- c(dates, date)
}

print (as.numeric(dates))


date_2 <- c(c(20140101, 20140102), 20140103)
date_2

for (year in 2012:2013){
        for (month in 1:9){
                print (paste0(year, 0, month))
        }
        for (month in 10:12){
                print (paste0(year, month))
        }
}


for (year in 2012:2013){
        for (month in 0:9){
                print (paste0('http://stats.grok.se/json/en/',
                             year,
                             0,
                             month,
                             '/web_scraping'))
        }
        for (month in 10:12){
                print (paste0('http://stats.grok.se/json/en/',
                              year,
                              month,
                              '/web_scraping'))
        }
}


printName <- function(x){
        print ('My name is Who')
}

printName(x)

sillySimulation <- function(x){
        x1 <- runif(500, 80, 100)
        x2 <- runif(500, 0, 100)
        v1 <- c(x1, x2)
        x3 <- runif(1000, 0, 100)
        df <- data.frame(v1, x3)
        require(ggplot2)
        print (ggplot(df, aes(v1, x3)) + geom_point() +
                              ggtitle('Silly simulation'))
}

sillySimulation(x)


desperateTimes <- function(x){
   print (paste0('Roff is struggling to finish his Phd on time. ',
                      'Remaining time: 6 months'))
}

desperateTimes(x)

desperateTimes_2 <- function(name){
        print (paste0(name,
                      ' is struggling to finish his Phd on time. ',
                      'Remaining time: 6 months.'))
}

desperateTimes_2('Tom')

desperateTimes_3 <- function(name, gender){
        if (gender == 'm'){
                pronoun = 'his'
        } else {
                pronoun = 'her'
        }
        print (paste0(name,
                      ' is struggling to finish ',
                      pronoun,
                      ' Phd on time. ',
                      'Remaining time: 6 months.'))
}

desperateTimes_3('Marry', 'f')
desperateTimes_3('Tom', 'm')

desperateTimes_4 <- function(name, gender, degree){
        if (gender == 'm'){
                pronoun = 'his'
        } else {
                pronoun = 'her'
        }
        print (paste0(name,
                      ' is struggling to finish ',
                      pronoun,
                      ' ',
                      degree,
                      ' on time. Remaining time: 6 months.'))
}
desperateTimes_4('Jenny', 'f', 'PhD')


require(lubridate)
require(ggplot2)
deadline <- as.Date('2015-05-30')
days_left <- deadline - Sys.Date() 
days_left
totDays <- deadline - as.Date('2012-09-01')
totDays

print (paste0('Rolf is struggling to finish his PhD on time. ',
              'Days remaining: ', days_left))

print (paste0('Percentage to go: ',
              round(as.numeric(days_left)/as.numeric(totDays)*100),
              '%'))


df <- data.frame(days = c(days_left, totDays - days_left),
                 lab = c('to go', 'completed'))
df

ggplot(df, aes(1, days, fill = lab)) + 
        geom_bar(stat = 'identity', position = 'fill')


# all in one 
timeToWarry <- function(x){
        require(lubridate)
        require(ggplot2)
        deadline <- as.Date('2015-05-30')
        days_left <- deadline - Sys.Date()
        totDays <- deadline - as.Date('2012-09-01')
        print (paste0('Rolf is struggling to finish his PhD on time. ',
              'Days remaining: ', days_left))
        print (paste0('Percentage to go: ',
              round(as.numeric(days_left)/as.numeric(totDays)*100),
              '%'))
        df <- data.frame(days = c(days_left, totDays - days_left),
                 lab = c('to go', 'completed'))
        ggplot(df, aes(1, days, fill = lab)) + 
                geom_bar(stat = 'identity', position = 'fill')
}

timeToWarry(x)


# creat a function to get data by url
getData <- function(url){
        require(rjson)
        require(lubridate)
        raw.data <- readLines(url, warn = F)
        rd <- fromJSON(raw.data)
        rd.views <- rd$daily_views
        rd.views <- unlist(rd.views)
        rd <- as.data.frame(rd.views)
        rd$date <- rownames(rd)
        rownames(rd) <- NULL
        rd$date <- as.Date(rd$date)
        return (rd)
}




# creating functions to get urls

getUrls <- function(t1, t2, term){
        root <- 'http://stats.grok.se/json/en/'
        urls <- NULL
        for (year in t1:t2){
                for (month in 1:9){
                        urls <- c(urls,
                                  paste0(root,
                                         year,
                                         0,
                                         month,
                                         '/',
                                         term))
                }
                for (month in 10:12){
                        urls <- c(urls,
                                  paste0(root,
                                         year,
                                         month,
                                         '/',
                                         term))
                }
        }
        return (urls)
}

urls_1 <- getUrls(2013, 2014, 'Euromaidan')
urls_1

results <- NULL
for (url in urls_1){
        results <- rbind(results, getData(url))
}

head(results)
ggplot(tail(results, 100), aes(date, rd.views)) + 
        geom_line()

require(XML)
require(RCurl)
wiki_url <- 'http://en.wikipedia.org/wiki/Euromaidan'
wiki <- getURL(wiki_url, encoding = 'UTF-8')
substring(wiki_doc, 1, 200)

wiki_doc <- htmlParse(wiki)

wiki_root <- xmlRoot(wiki_doc)
wiki_root
length(wiki_root)

wiki_children <- xmlChildren(wiki_root)
wiki_children
length(wiki_children)
wiki_c1 <- wiki_children[[1]]
wiki_c2 <- wiki_children[[2]]

xmlName(wiki_c1)
xmlSize(wiki_c1)
xmlAttrs(wiki_c1)
xmlValue(wiki_c1)

wiki_c1_1 <- xmlChildren(wiki_c1)
length(wiki_c1_1)
sapply(wiki_c1_1, xmlName)
sapply(wiki_c1_1, xmlValue)

wiki_c1_1_x <- NULL
for (i in 1:24){        
        wiki_c1_1_x <- c(wiki_c1_1_x, xmlName(wiki_c1_1[[i]]))
}

wiki_c1_1_x



xmlName(wiki_c1_1[[1]])
xmlName(wiki_c1_1[[2]])

xpathSApply(wiki_doc, path = '//h1')
xpathSApply(wiki_doc, path = '//h1', xmlValue)

xpathSApply(wiki_doc, path = '//h2', xmlValue)

xpathSApply(wiki_doc, path = '//h3', xmlValue)

length(xpathSApply(wiki_doc, '//a/@href'))

head(xpathSApply(wiki_doc, 
                 '//span[@class =\'citation news\']',
                 xmlValue))

links <- xpathSApply(wiki_doc,
               '//span[@class = \'citation news\']/a/@href')

browseURL(links[1])

xpathSApply(wiki_doc,
            '//span[@class = \'citation news\'][17]/a/@href')

# * selects any node or tag
xpathSApply(wiki_doc,
            '//*[@class = \'citation news\'][17]/a/@href')

wiki_ref <- NULL
wiki_ref <- c(wiki_ref,
              xpathSApply(wiki_doc,
                          '//*[@class = \'citation news\']/a/@href'))
head(wiki_ref)


# @* selects any attribute (used to define nodes)
xpathSApply(wiki_doc,
            '//span[@class = \'citation news\'][17]/a/@*')


# use functions
# syntax [function(attribute, string)]
head(xpathSApply(wiki_doc,
                 '//span[starts-with(@class, \'citation\')][17]/a/@href'))

head(xpathSApply(wiki_doc,
                 '//span[contains(@class, \'citation\')][17]/a/@href'))

# example

bbc_url <- "http://www.bbc.co.uk/news/world-europe-26333587"
bbc_doc <- htmlParse(bbc_url)
xpathSApply(bbc_doc,
            '//h1[@class = \'story-header\']',
            xmlValue)

bbc_news <- NULL
bbc_news <- c(bbc_news,
              xpathSApply(bbc_doc,
                          '//*[@class = \'story-header\']',
                          xmlValue))
head(bbc_news)

xpathSApply(bbc_doc,
            '//span[@class = \'date\']',
            xmlValue)

xpathSApply(bbc_doc,
            '//span[@class = \'time\']',
            xmlValue)

xpathSApply(bbc_doc,
            '//span[@class = \'time-text\']',
            xmlValue)

xpathSApply(bbc_doc,
            '//meta[@name = \'OriginalPublicationDate\']/@content')

xpathSApply(bbc_doc, 
            '//meta[@property = \'rnews:datePublished\']/@content')

# make a scapper

bbcScapper <- function(url){
        require(XML)
        sou <- getURL(url, encoding = 'UTF-8')
        bbc_con <- htmlParse(sou)
        title <- xpathSApply(bbc_con,
                              '//h1[@class = \'story-header\']',
                              xmlValue)
        time <- xpathSApply(bbc_doc,
                            '//meta[@name = \'OriginalPublicationDate\']/@content')
        return (c(title, time))
}




bbcScapper2 <- function(url){
        require(XML)
        title = time = NA
        sou <- getURL(url, encoding = 'UTF-8')
        bbc_con <- htmlParse(sou)
        title <- xpathSApply(bbc_con,
                              '//h1[@class = \'story-header\']',
                              xmlValue)
        time <- xpathSApply(bbc_doc,
                    '//meta[@name = \'OriginalPublicationDate\']/@content')
        if (is.null(time) == TRUE){
                time <- xpathSApply(bbc_con,
                                    '//span[@class = \'date\']',
                                    xmlValue)
        }
        return (c(title, time))
}

bbcScapper(bbc_url)

bbcScapper2(bbc_url)

# test another url

bbc_url2 <- 'http://www.bbc.co.uk/sport/0/football/26332893'

bbcScapper(bbc_url2)

bbcScapper2(bbc_url2)

# take another example

guardian_url <- 'http://www.theguardian.com/commentisfree/2014/feb/25/how-much-cost-growers-bananas-68p-per-kilo'

guardian_source <- getURL(guardian_url, encoding = 'UTF-8')

guardian_doc <- htmlParse(guardian_source)

class(guardian_doc)

author <- xpathSApply(guardian_doc,
                      '//meta[@name = \'author\']/@content')
author

time <- xpathSApply(guardian_doc,
                    '//time[@itemprop = \'datePublished\']/@datetime')
                    xmlValue)
time

keywords <- xpathSApply(guardian_doc,
                        '//a[@itemprop=\'keywords\']',
                        xmlValue)
keywords


keywords <- xpathSApply(guardian_doc,
                        '//a[@class=\' button button--small button--tag button--secondary\']'
                        xmlValue)


?gsub
grep("[a-z]", letters)
gsub("([ab])", "\\1_\\1_", "abc and ABC")


#-------------Week 3----------------------


bbcScraper2 <- function(url){
        sou <- getURL(url, encoding = 'UTF-8')
        bbc_con <- htmlParse(sou)
        title <- xpathSApply(bbc_con,
                             '//h1[@class = \'story-header\']',
                             xmlValue)
        time <- as.character(xpathSApply(bbc_con,
                            '//meta[@name = \'OriginalPublicationDate\']/@content'))
        if (is.null(time)) time <- NA
        if (is.null(title)) title <- NA
        return (c(title, time))
}



require(RCurl)
require(XML)
urls <- c('http://www.bbc.co.uk/news/business-26414285',
          'http://www.bbc.co.uk/news/uk-26407840',
          'http://www.bbc.co.uk/news/world-asia-26413101',
          'http://www.bbc.co.uk/news/uk-england-york-north-yorkshire-26413963')
results=NULL
for (url in urls){
        newEntry <- bbcScraper2(url)
        results <- rbind(results,newEntry)
}
data.frame(results)


temp <- NULL
temp <- rbind(temp, results[1, ])
temp
temp <- rbind(temp, results[2, ])
temp <- rbind(temp, results[3, ])
temp <- rbind(temp, results[4, ])
temp

# sapply

dat <- c(1, 2, 3, 4, 5)
sapply(dat, function(x) x*2)
sapply(dat, function(x) x^2)
require(plyr)
ldply(dat, function(x) x*3)

sapply(dat, sqrt)

urls <- c('http://www.bbc.co.uk/news/business-26414285',
          'http://www.bbc.co.uk/news/uk-26407840',
          'http://www.bbc.co.uk/news/world-asia-26413101',
          'http://www.bbc.co.uk/news/uk-england-york-north-yorkshire-26413963')

sapply(urls, bbcScraper2)

ldply(urls, bbcScraper2)

bbcScraper3 <- function(url){
        links = NULL
        search_result <- getURL(url, encoding = 'UTF-8')
        search_doc <- htmlParse(search_result)
        link <- xpathSApply(search_doc,
                            '//a[@href]')
        links <- c(links, link)
        return (links)
}


url_russian <- 'http://www.bbc.co.uk/search?v2=true&page=2&q=Russia'
search_result <- getURL(url_russian, encoding = 'UTF-8')
search_doc <- htmlParse(search_result)
link <- xpathSApply(search_doc, '//a[@href]', xmlValue)
link
title <- xpathSApply(search_doc, 
                     '//div/h1[@itemprop=\'headline\']', 
                     xmlValue)
title

getwd()
url_book <- 'http://lib.ru/SHAKESPEARE/hamlet8.pdf'
download.file(url, 'hamlet.pdf', mode = 'wb')

url_txtbook <- 'http://lib.ru/GrepSearch?Search=txt'
txtbook_info <- getURL(url_txtbook, encoding = 'UTF-8')
book_doc <- htmlParse(txtbook_info)
links <- xpathSApply(book_doc, '//a/@href')   
head(links)       
link_txt <- links[grep('txt', links)]    
links_txtbook <- paste0('http://lib.ru/', link_txt)        
  

library(stringr)
parts_1 <- str_split(links_txtbook[1], '/')
class(parts_1)
parts_2 <- unlist(parts)
class(parts_2)
parts_3 <- parts[length(parts)]
parts_3
class(parts_3)

for (i in 1:10){
        parts <- unlist(str_split(links_txtbook[i], '/'))
        outName <- parts[length(parts)]
        print (outName)
        download.file(links[i], outName)
}
        
# grep
grep('ABRAMOWICHM', links)
links[grep('ABRAMOWICHM', links)]      
        
grep('ABRAMOWIC*', links, value = T)        

grep('station', c('station', 'stationlkshs'), value = T)

grep('station\\b', c('station', 'stationlkshs'), value = T)

# gsub
author <- 'By Rolf Fredheim'
gsub('By ', '', author)
gsub('Rolf Fredheim', 'Tom', author)

annoyingString <- "\n    something HERE  \t\t\t"
nchar(annoyingString)
str_trim(annoyingString)
tolower(str_trim(annoyingString))

# formating date
require(lubridate)
as.Date('2013-03-30')
date <- as.Date('2013-03-30')
str(date)

date + years(1)

date - month(6)

date - days(100)

as.Date('01/10/2010', '%m/%d/%Y')
as.Date('03 Jun 1009', '%d %b %Y')

date_2 <- '03 Jun 2009'
dmy(date_2)

date_2 <- '03 Jun 2009 16:10:00'
dmy_hms(date_2, tz = 'GMT')

tele_url <- 'http://www.telegraph.co.uk/news/uknews/terrorism-in-the-uk/10659904/Former-Guantanamo-detainee-Moazzam-Begg-one-of-four-arrested-on-suspicion-of-terrorism.html'

tele_web <- getURL(tele_url, encoding = 'UTF-8')

tele_doc <- htmlParse(tele_web)

author <- xpathSApply(tele_doc,
                      '//meta[@name=\'DCSext.author\']/@content')
author

time <- xpathSApply(tele_doc,
                      '//meta[@name=\'DCSext.articleFirstPublished\']/@content')
time

author_test <-  "\r\n\t\t\t\t\t\t\tBy Miranda Prynne, News Reporter"
author_test <- str_trim(author_test)
author_test
author_test <- gsub('By ','', author_test)
author_test <- str_split(author_test, ',')
author_test <- unlist(author_test)
author_test[1]

time_test <- "1:30PM GMT 25 Feb 2014"
time_test <- str_split(time_test, 'GMT')
time_test <- unlist(time_test)
time_test[2]
as.Date(time_test[2], '%d %b %Y')
dmy(time_test[2])


# API

fqlQuery  = 'select share_count,like_count,comment_count from link_stat where url="'
url = 'http://www.theguardian.com/world/2014/mar/03/ukraine-navy-officers-defect-russian-crimea-berezovsky'
queryUrl = paste0('http://graph.facebook.com/fql?q=',fqlQuery,url,'"')  #ignoring the callback part
lookUp <- URLencode(queryUrl) #What do you think this does?
lookUp

require(rjson)
url = 'http://quantifyingmemory.blogspot.com/2014/02/web-scraping-basics.html'
queryUrl = paste0('http://graph.facebook.com/fql?q=',fqlQuery,url,'"')  #ignoring the callback part
lookUp <- URLencode(queryUrl)
rd <- readLines(lookUp, warn="F") 
dat <- fromJSON(rd)
dat

dat$data[[1]]$share_count
dat$data[[1]]$like_count
dat$data[[1]]$comment_count


getUrl <- function(address, sensor = 'false'){
        root <- 'http://maps.google.com/maps/api/geocode/json?'
        url <- paste0(root, 'address=', address, '&sensor=false')
        return (URLencode(url))
}
getUrl('Kremlin, Moscow')
require(RJSONIO)

target <- getUrl('Kremlin, Moscow')
dat <- fromJSON(target)
class(dat)
dat
lat <- dat$results[[1]]$geometry$location['lat']

lat <- unclass(lat)
class(lat)
lat <- data.frame(lat)
colnames(lat) <- c('para')
lat$para
latitude <- lat$para[1]
latitude

longtitude <- lat$para[2]
longtitude

address <- dat$results[[1]]$formatted_address
address

base <- 'http://maps.googleapis.com/maps/api/staticmap?center='
latitude <- 55.75
longitude <- 37.62
zoom <- 13
maptype <- 'hybrid'
suffix <- '&size=800x800&sensor=false&format=png'

map_url <- paste0(base, latitude, ',', longitude, '&zoom=',
                  zoom, '&maptype=', maptype, suffix)

download.file(map_url, 'test.png', mode = 'wb')







