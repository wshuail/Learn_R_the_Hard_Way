# Chapter 4

# 4.1 A Working Example

manager <- c(1, 2, 3, 4, 5)
date <- c('10/24/08', '10/28/09', '10/1/08',
          '10/12/08', '5/1/09')
country <- c('US', 'US', 'UK', 'UK', 'UK')
gender <- c('M', 'F', 'F', 'M', 'F')
age <- c(32, 45, 25, 39, 99)

q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country,
                       gender, q1, q2, q3, q4, q5,
                       stringsAsFactors = FALSE)

leadership

# Creating a new variable

# variable <- expression

# +
# -
# *
# /
# ^ or **
# x%%y modules (x mode y), 5 %% 2 = 1
# x%/%y integer division 5%/%2 = 2

mydata <- data.frame(x1 = c(2, 2, 6, 4),
                     x2 = c(3, 4, 2, 6))

mydata$sum <- mydata$x1 + mydata$x2
mydata$mean <- (mydata$x1 + mydata$x2)/2

attach(mydata)
mydata$sum <- x1 + x2
mydata$mean <- (x1 + x2)/2
detach(mydata)

mydata <- transform(mydata,
                    sumx = x1 + x2,
                    meanx = (x1 + x2)/2)

# Recording varibales

# <
# >
# <=
# >=
# ==
# !=
# !x
# x|y
# x&y
# isTRUE(x)

# variable[statement] <- expression
leadership$age[leadership$age == 99] <- NA

leadership$agecat[leadership$age > 75] <- 'Elder'
leadership$agecat[leadership$age <= 75]&
        leadership$age[leadership$age >= 55] <- 'Middle Age'
leadership$agecat[leadership$age < 55] <- 'Young'


leadership <- within(leadership, {
        agecat <- NA
        agecat[age > 75] <- 'Elder'
        agecat[age >= 55 & age <= 75] <- 'Middle Age'
        agecat[age < 55] <-  'Young'
})

# within

# 4.4 Renaming variables

# fix(leadership)

# rename(dataframe, c(oldnames = 'newnames', ...))

# library(reshape)
# leadership <- rename (leadership,
#             c(manager = 'managerID', date = 'testDate'))

# names(leadership)[2] <- 'testDate'

leadership <- leadership[1:9]

names(leadership)

names(leadership)[2] <- 'testDate'
leadership

# names(leadership)[5:9] <- c('item1', 'item2', 'item3',
                             'item4', 'item5')


# 4.5 Missing values

# is.na()

y <- c(1, 2, 3, NA)

is.na(y)

is.na(leadership[ , 5:9])

# NA == NA is NA, but not TRUE

# 4.5.1 Recording values to missing

# leadership$age(leadership$age == 99) <- NA

# 4.5.2 Excluding missing values from analyses

x <- c(1, 2, NA, 3)
y <- x[1] + x[2] + x[3] + x[4]
z <- sum(x)
y
z
z <- sum(x, na.rm = TRUE)
z

# na.omit()

leadership

newdata <- na.omit(leadership)
newdata

# 4.6 Date values

# as.Date()
# as.Date(x, 'input_format')

# %d
# %a
# %A
# %m
# %b
# %B
# %y
# %Y

mydates <- as.Date(c('2007-06-22', '2004-02-23'))
mydates

strDate <- c('01/05/1965', '08/16/1975')
dates <- as.Date(strDate, '%m/%d/%Y')
dates

myformat <- '%m/%d/%y'
leadership$date <- as.Date(leadership$testDate, myformat)
leadership$date

Sys.Date()
date()

today <- Sys.Date()
format(today, format='%B %d %Y')
format(today, '%B %d %Y')
format(today, '%A')

startdate <- as.Date('2004-02-13')
enddate <- as.Date('2011-01-22')
days <- enddate - startdate
days
difftime(startdate, enddate, units =  'weeks')

# 4.6.1 converting dates to character variables

# strdate <- as.character(dates)

# 4.6.2 Going further

# install.packages('lubridate')
# install.packages('fCalender')

# 4.7 Type conversions

#     test      |       Convert
#is.numeric()   | as.numeric()
#is.character() | as.character()
#is.vector()    | as.vector()
#is.matrix()    | as.matrix()
#is.data.frame()| as.date.frame()
#is.factor()    | as.factor()
#is.logical()   | as.logical()
#is.datatype()  | as.datatype()

a <- c(1, 2, 3)
a

is.numeric(a)

is.vector(a)

a <- as.character(a)
a

is.numeric(a)

is.character(a)

# 4.8 Sorting data

# order()

newdata <- leadership[order(leadership$age), ]

attach(leadership)
newdata <- leadership[order(gender, -age), ]
detach(leadership)
newdata

# 4.9 Merging datasets

# 4.9.1 Adding columns

# merge()

# total <- merge(dataframeA, dataframeB, by='ID')

# total <- merge(daraframeA, daraframeB, by='ID', 'country')

# join two matrices or data frames horizontally
# cbind()
A <- c(1, 2)
B <- c(3, 4)
total <- cbind(A, B)
total

# 4.9.2 Adding rows

# rbind()

total <- rbind(dataframeA, dataframeB)

A <- c(1, 2)
B <- c(3, 4)
total <- rbind(A, B)
total

# 4.10 Subsetting datasets

# 4.10.1 Selecting (keeping) variables

newdata <- leadership[ ,c(5:9)]
newdata

attach(leadership)
myvars <- leadership('q1', 'q2', 'q3', 'q4', 'q5')
newdata <- leadership[myvars]
newdata

# paste()
myvars <- paste('q', 1:5, sep='')
newdata <- leadership[myvars]
newdata

# 4.10.2 Excluding (dropping) variables
# selecting q3 and q4
myvars <- names(leadership) %in% c('q3', 'q4')
# exclude q3 and q4
newdata <- leadership[!myvars]

newdata <- leadership[c(-8, -9)]

leadership$q3 <- leadership$q4 <- NULL

# Selecting varibales

newdata <- leadership[1:3, ]

newdata <- leadership[which(leadership$gender == 'M' 
                            & leadership$age > 30), ]

attach(leadership)
newdata <- leadership[which(gender == 'M' & 
                                    age > 30), ]
detach(leadership)

leadership$data <- as.Date(leadership$date, '%m/%d/%y')
startdata <- as.Date('2009-01-01')
enddate <- as.Date('2009-10-31')
newdata <- leadership$date[which
                           (leadership$date >= startdate&
                        leadership$data <= enddate), ]

# 4.10.4 The subset() function

newdata <- subset(leadership, age >= 35 | age < 24,
                  select = c(q1, q2, q3, q4))

newdata <- subset(leadership, gender == 'M' & age > 25,
                  select = gender:q4)

# 4.10.5 Random samples

# sample()

mysample <- leadership[sample(1:nrow(leadership), 3,
                              replace=FALSE)]

# install.packages('sampling')
# install.packages('survey')

# 4.11 Using SQL statements to manipulate data frames

# install.packages('sqldf')

# 4.12 Summary








