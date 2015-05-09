update.packages()
devtools::install_github("hadley/bigrquery")

install.packages('RPostgreSQL')

library(RPostgreSQL)
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, user = 'postgres', password = 'spatial',
                 dbname = 'census')

con <- dbConnect(drv, host='localhost', port='5432', dbname='Swiss',
                 user='postgres', password='123456')

con <- dbConnect(drv, dbname="tempdb")
con <- dbConnect(drv, dbname="R_Project")












