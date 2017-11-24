# This file contains file for me to exercise R
# Chapter 5 for <R in Action>

# 5.2.1 mathematical functions

setwd("E:/R/RStudio/directory/R_in_Action")
ls()

#abs(x)
abs(-5)

#sqrt(x)
sqrt(2)
sqrt(2, 4) #error
sqrt(c(2, 4))

x <- c(2, 4)
sqrt(x)


#ceiling()
ceiling(5.27)
ceiling(5.27, 9.78) #error
ceiling(c(5.27, 9.78))

#floor(x)
floor(5.27)

#trnnc(x) truncate
trunc(5.99)

#round(x, digits=n)
round(5.27, digits=1)
round(5.27, digits=3) # no increase
round(5.2788, digits=3)

#signif(x, digits=n)
signif(5.27, digits=1) #5
signif(5.27, digits=2) #5.3
signif(5.76, digits=2) #5.8

#cos(x), sin(x), tan(x)
sin(2) #0.909

#acos(), asin(x), atan()
asin(0.9092974)

#asinh(), acosh(), atanh()

#log(x, base=n)
log(100, base=10)

#log(x)
log(100)
log(1)
log(e) #error

#log10(x)
log10(100)

#exp(x)
exp(2)
exp(1)

# 5.2.2 statistical functions

#mean(x)
mean(1,2)
mean(c(1, 2))

#median(x)
median(1, 2)
median(c(1, 2))

#sd(x)
sd(c(1,2,3))

#var(x)
var(c(1, 2, 3))

#mad(x)
mad(c(1, 2, 3))

#quantile(x, probs)
quantile(x, c(.3, .8))


#range(x)
xrange <- c(1, 2, 4, 9)
range(xrange)
diff(range(xrange))

#sum(x)
sum(c(1, 2, 4, 9))

#diff(x, lag=n) 
xdiff <- c(1, 2, 4, 9)
diff(xdiff, lag=2)

#min(x)
min(c(1, 2, 9))

#max(x)
max(c(1, 2, 9))

#scale(x, center=TRUE, scale=TRUE)


#exercise
x <- c(1, 2, 3, 4, 5, 6, 7, 8)
mean(x)
sd(x)

n <- length(x)
meanx <- sum(x)/n
css <- sum((x-meanx)^2)
sdx <- sqrt(css/(n-1))
meanx
css
sdx


# 5.2.3 probability functions

# [dpqr]distribution_abbreviation()
# d: density
# p: distribution function
# q: quantile function
# r: ramdom generation

x <- pretty(c(-3, 3), 30)
y <- dnorm(x)
plot(x, y, xlab='Normal Deviation', ylab='Density')

pnorm(1.96)

qnorm(0.9, mean=500, sd=100)

rnorm(50, mean=50, sd=10)

# set set.seed for generation of random number

#runif()
runif(5)

runif(5)

#set.seed()
set.seed(123)
runif(5)

set.seed(123)
runif(5)

runif(5)

# generating multivariate normal data

#mvnnorm(n, mean, sigma)

library(MASS)

option(digits = 3)
set.seed(1234)
mean <- c(230.7, 1546.7, 3.6)
sigma <- matrix(c(16360.8, 7653.9, -65.9, 
                  7634.9, 4367.2, -42.9
                  -35.1, -56.8, 0.8), nrow=3, ncol=3)
mydata <- mvrnorm(500, mean, sigma)
mydata <- as.data.frame(mydata)
names(mydata) <- c('y', 'x1', 'x2')
dim(mydata)
head(mydata, n=10)

# 5.2.4 character functions

#nchar(x)

x <- c('a', 'ab', 'hsgsfs')
length(x)
nchar(x[3])


#substr(x, start, stop)

x <- 'absjshjsjs'
substr(x, 2, 4)
substr(x, 2, 4) <- '88888888'
substr(x, 2, 4)

#grep(pattern, x, ignore.case=FALSE, fixed=FALSE)

x <- c('AADFG')
grep('A', x, ignore.case=TRUE,fixed=FALSE)

#sub(pattern, replacement, x, ignore.case=FALSE, fixed=TRUE)

sub('\\s', '.', 'Hello World', fixed=FALSE)

# strsplit(x, split, fixed=FALSE)

strsplit('abc', '', fixed=TRUE)

# paste(...., sep=' ')

paste('x', 1:3, sep='')

paste('x', 1:3, sep='M')

paste('Today is', date())

# toupper(x)

toupper('abc')

#tolower(x)

tolower('ABC')

# other useful function

#length(x)

length(c(1:1000))

#seq(from, to, by)

seq(1, 100, 5)

#rep(x, n)

rep(1:3, 2)

#cut(x, n)

cut(1:10, 2)

#pretty(x, n)

#cat(..., file='myfile', append=FALSE) cat:concatenate

firstname <- c('JUNE')
cat('HELLO', firstname, '\n')

x <- ('JUNE', 'JULY')
cat('HELLO', x, '\n') #error

names <- 'Bob'
cat('Hello', names, '\b.\n', 'Isn\'t R', '\t', 'GREAT?\n')

test word

#appling functions to matrices and frames

a <- 2
sqrt(a)

b <- c(1.243, 5.654, 2.990)
round(b)

c <- matrix(runif(12), nrow=3)
c

mean(c)

# apply function
#apply(x, MARGIN, FUN, ...)
# MARGIN=1 means row, MARGIN=2 means column.

mydata <- matrix(rnorm(30), nrow=6)
mydata

apply(mydata, 1, mean)
apply(mydata, 2, mean, trim=0.2)
apply(mydata, 1, median)
apply(mydata, 2, median)


#a solution for our data management challenge

options(digits = 2)
Student <- c('John Davis', 'Angela Williams', 
             'Bullwinkle Moose', 'David Jones', 
             'Hanice Markhammer', 'Cheryl Cushing', 
             'Reuven Ytzrhak', 'Greg Knox', 
             'Joel England', 'Mary Rayburn')
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(Student, Math, Science, English)
score <- apply(roster[2:4], 1, mean)
roster <- cbind(roster, score)

y <- quantile(roster$score, c(0.8, 0.6, 0.4, 0.2))
roster$grade[score > y[1]] <- 'A'
roster$grade[score >= y[2] & score < y[1]] <- 'B'
roster$grade[score >= y[3] & score < y[2]] <- 'C'
roster$grade[score >= y[4] & score < y[3]] <- 'D'
roster$grade[score < y[4]] <- 'E'

names <- strsplit(Student, ' ')
Firstname <- sapply(names, '[', 1)
Lastname <- sapply(names, '[', 2)

roster <- cbind(Firstname, Lastname, roster[ ,-1])
roster[order(Lastname), ]

roster <- data.frame(Student, Math, Science, English,
                     stringAsFactors=FALSE)
z <- scale(roster[, 2:4])
score <- apply(z, 1, mean)
roster <- cbind(roster, score)
y <- quantile(score, c(.8, .6, .4, .2))
roster$grade[score >= y[1]] <- 'A'
roster$grade[score <y[1] &
                     score >= y[2]] <- 'B'
roster$grade[score < y[2] &
                     score >= y[3]] <- 'C'
roster$grade[score < y[3] &
                     score >= y[4]] <- 'D'
roster$grade[score < y[4]] <- 'E'

names <- strisplit((roster$Students), '')
lastname <- sapply(name, '[', 2)
firstname <- sapply(name, '[', 1)
roster <- cbind(firstname, lastname, roster[ ,-1])
roster <- roster[order(lastname, firstname), ]
roster

# 5.4 control flow
# 5.4.1 repetition and looping
# for (var in seq) statement
# seq is a sequence of numbers or character string
# statement is a single R statement or a compound statement ( a group 
# of R statements enclosed in curly brances{} and separated by semicolons)
for (i in 1:10) print ('Hello')

# while (cond) statement
# cond is an expression that resolves of true or false
i <- 10
while (i > 0)  {print ('Hello'); i <- i -1}

# apply functions are better.

# 5.4.2 conditional execusion

# IF-ELSE
# if (cond) statement
# if (cond) statement else statement2

if (is.character(grade)) grade <- as.factor(grade)
if (!is.character(grade)) grade <- as.factor(grade) 
else print ('Grade is already is a factor')

#IFELSE
# iselse( cond, statement, statement2)

ifelse (score > 0.5, print ('Passed'), print('Failed'))
outcone <- ifelse (score > 0.5, 'Passed', 'Failed')

# SWITCH
# switch (expr, ...)

feelings <- c('sad', 'afraid')
for (i in feelings)
        print (switch(i, 
                      happy = 'I am glade you are happy',
                      afraid = 'There is nothing to fear',
                      sad = 'Cheey up',
                      angry = 'Calm down now'
                      )
               )

# User-writtern functions

# myfunctions <- functions(arg1, arg2, ...){
# statements
# return(object)
}

mystats <- function(x, parametric=TRUE, print=FALSE){
        if(parametric){
                center <- mean(x); spread <- sd(x)
        }
        else{
                center <- median(x); spread <- mad(x)
        }
        if (print & parametric){
                cat('Mean=', center, '\n', 'SD=', spread, '\n')
        }
        else if (print & !parametric){
                cat('Median=', center, '\n', 'MAD=', spread, '\n')
        }
        result <- list(center=center, spread=spread)
        return (result)
}
        
set.seed(1234)
x <- rnorm(500)
y <- mystats(x, parametric=TRUE, print=FALSE)


mydate <- function (type = 'long'){
        switch(type,
               long = format(Sys.time(), '%A %B %d %Y'),
               short = format(Sys.time(), '%m-%d-%y'),
               cat(type, 'is not a recognized type\n')
        )
}

mydate('long')
mydate('short')
mydate()
mydate('medium')


# I will define of function my myselves.
exfunction <- function(x){
        if (x>0){
                print ('This is a positive num')
                }
        else{
                print ('This is a negative num')
        }
}
exfunction(5)
# Wow, seems successful.

# 5.6 Aggragation and restructuring
# 5.6.1 Transpose
cars <- mtcars[1:5, 1:4]
cars
t(cars)

# aggregating data
# aggregate(x, by, FUN)

options(digits=3)
attach(mtcars)
aggdata <- aggregate(mtcars, by = list(cyl, gear), 
                     FUN=mean, na.rm=TRUE)
<<<<<<< HEAD
aggdata

aggdata_2 <- aggregate(mtcars, 
                       by = list(Group.cyl = cyl, 
                                 Group.cyl = gear),
                       FUN=mean, na.rm=TRUE)
aggdata_2

# 5.6.3 The Reshape package

require(reshape)

ID <- c(1, 1, 2, 2)
Time <- c(1, 2, 1, 2)
X1 <- c(5, 3, 6, 2)
X2 <- c(6, 5, 1, 4)
mydata <- data.frame(ID, Time, X1, X2)
mydata

# melting
md <- melt(mydata, id = c('ID', 'Time'))
md

# casting
# newdata <- cast(md, fomula, FUN)
# formula: rowvar1 + rowvar2 ... ~ colvar1 + colvar2 + ...

# with aggregation

cast(md, ID ~ variable, mean)
cast(md, Time ~ variable, mean)

# without aggragation

cast(md, ID + Time ~ variable)

cast(md, ID ~ Time) # only return the number of the variables

cast(md, Time ~ variable) # the same with above code

cast(md, ID + variable ~ Time)
=======


