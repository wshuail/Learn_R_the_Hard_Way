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



































