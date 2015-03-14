# This is a tutional from http://rstudio-pubs-static.s3.
# amazonaws.com/12422_b2b48bb2da7942acaca5ace45bd8c60c.html

library(XML)
library(RCurl)

data <- list()
pytest <- 'http://sebug.net/paper/books/LearnPythonTheHardWay/ex3.html'

pyhtml <- htmlParse(getURL(pytest))

pyroot <- xmlRoot(pyhtml)

pyroot

length(pyroot)
pyroot[[1]]

pychildren <- xmlChildren(pyhtml)

pychildren

length(pychildren)

pychildren[[1]]

pychildren[[2]]

sapply()



for( i in 1:52){
     tmp <- paste(i, '.html', sep='')
     url <- paste('http://sebug.net/paper/books/LearnPythonTheHardWay/ex', tmp, sep='')
     html <- htmlParse(getURL(url))
     url.list <- xpathSApply(html, "//div[@class='title']/a[@href]", xmlAttrs)
     data <- rbind(data, paste('www.ptt.cc', url.list, sep=''))
}
data <- unlist(data)

getdoc <- function(line){
     start <- regexpr('www', line)[1]
     end <- regexpr('html', line)[1]
     
     if(start != -1 & end != -1){
          url <- substr(line, start, end+3)
          html <- htmlParse(getURL(url), encoding='UTF-8')
          doc <- xpathSApply(html, "//div[@id='main-content']", xmlValue)
          name <- strsplit(url, '/')[[1]][4]
          write(doc, gsub('html', 'txt', name))
     }      
}