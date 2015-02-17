# Chapter 2 Creating a dataset

# 2.1 Undertanding datasets
# 2.1.1 Data structures
# R has a large variety of data structures for holding data, 
# including, scalars, vectors, matrices, arrays, data frames,
# and lists.

# 2.2.1 Vectors
# c()
# a numeric vector
a <- c(1, 2, 5, 3, 6, -2, -4)
# a character vector
b <- c('one', 'two', 'three')
# a logical vector
c <- c(TRUE, FALSE, TRUE)

# scalar
# is a one-element vector
f <- 3
g <- "US"
h <- TRUE

a[1]
a[c(1, 2)]
a[1:3]
a[-1]
a[-2]
a[-7]
a[-10] # will not exlude scalar, but R will not warning.


# 2.2.2 Matrices
#mymatrix <- matrix(vector, nrow=m, ncol=n,
#                   byrow=TRUE, dimnames=list(
#                   rownames, colnames))

y <- matrix(c(1:20), nrow=5, ncol=4)
y

cells <- c(1, 26, 24, 69)
rnames <- c('R1', 'R2')
cnames <- c('C1', 'C2')
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE,
                   dimnames=list(rnames, rnames))
mymatrix

cells <- c(1, 26, 24, 69)
rnames <- c('R1', 'R2')
cnames <- c('C1', 'C2')
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=FALSE,
                   dimnames=list(rnames, rnames))
mymatrix

# the default is by column.
cells <- c(1, 26, 24, 69)
rnames <- c('R1', 'R2')
cnames <- c('C1', 'C2')
mymatrix <- matrix(cells, nrow=2, ncol=2,
                   dimnames=list(rnames, rnames))
mymatrix

x <- matrix(1:20, nrow=2)
x
x[2, ]
x[ ,1]
x[1, c(4, 5)]


# 2.2.3 Arrays
# myarray <- array(vector, dimensions, dimnames)
dim1 <- c('A1', 'A2')
dim2 <- c('B1', 'B2', 'B3')
dim3 <- c('C1', 'C2', 'C3', 'C4')
z <- array(1:24, c(2, 3, 4), dimnames=list(dim1, dim2, dim3))
z

# z[l, m, n] means the n matrix, the l row, and the n column. 
z[1, 2, 3]
z[1, 1, 1]
z[1, 2, 1]
z[1, 3, 1]
z[1, 3, 2] # will be 11? YES!

dim1 <- c('A1', 'A2')
dim2 <- c('B1', 'B2', 'B3')
dim3 <- c('C1', 'C2', 'C3', 'C4', 'C5')
z <- array(1:30, c(2, 3, 5), dimnames=list(dim1, dim2, dim3))
z

# 2.2.4 Data frames
# mydata <- data.frame(col1, col2, col3)
patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c('Type1', 'Type2', 'Type1', 'Type1')
status <- c('Poor', 'Improved', 'Excellet', 'Poor')
patientdata <- data.frame(patientID, age, diabetes, status)
patientdata

patientdata[1:2]
patientdata[c('diabetes', 'status')]
patientdata$age

table(patientdata$patientID, patientdata$status)

# ATTACH, DETACH AND WITH
summary(mtcars$mpg)
plot(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$wt)

attach(mtcars)
summary(mpg)
plot(mpg, disp)
plot(mpg, wt)
detach(mtcars)
# the attach function will fail when there are 
# objects with the same names.

with(mtcars, {
        summary(mpg, disp, wt)
        plot(mpg, disp)
        plot(mpg, wt)
})

# the function will be only valid in {}
with(mtcars, {
        stats <- summary(mpg)
        stats
})
stats

# the <<- can save this.
with(mtcars, {
        nokeepstates <- summary(mpg)
        keepstats <<- summary(mpg)
})
nokeepstats
keepstats # this can work.

# case identifications
# patientdata <- data.frame(patientID, age, diabetes, status,
# row.names=PatientID)

# 2.2.5 Factors

# nominal variable
# disbetes('Type1', 'Type2')

# ordinal variable
# status(poor, improved, excellent)

# continuous variable
# Age

# nominal and ordinal variables are called factors

# diabetes <- c('Type1', 'Type2', 'Type1', 'Type1')
# diabetes <- factor(diabetes)

# states <- c('Poor', 'Improved', 'Excellent', 'Poor')
# status <- factor(status, order=TRUE)
# 1=Excellent, 2=Improved, 3=Poor

# status <- factor(status, order=TRUE, 
#           level=c('Poor', 'Improved', 'Excellent'))

patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c('Type1', 'Type2', 'Type1', 'Type1')
status <- c('Poor', 'Improved', 'Excellet', 'Poor')
# conver two non-continuous variables into factors
diabetes <- factor(diabetes)
status<- factor(status, order=TRUE)
patientdata <- data.frame(patientID, age, diabetes, status)
str(patientdata)
summary(patientdata)

# 2.2.6 List
# mylist <- list(object1, object2, ...)
# mylist <- list(name1=object1, name2=object2, ...)

g <- 'My first list.'
h <- c(25, 26, 18, 39)
j <- matrix(1:10, nrow=5)
k <- c('One', 'Two', 'Three')
mylist <- list(title=g, ages=h, j, k)
mylist

mylist[[2]]
mylist[2] # what's the difference with the one above.
mylist['ages']



# assigning a value to a nonexistent element
x <- c(8, 6, 4)
x[7] <- 10
x

# 2.3 Data input
# 2.3.1 Entering data from the keyboard
# edit()
mydata <- data.frame(age=numeric(0),
                     gender=character(0), weight=numeric(0))
mydata <- edit(mydata)
mydata
newdata <- edit(mydata)
newdata

# 2.3.2 Importing data from a delimeter text file

# read.table()
# mydataframe <- read.table(file, header=logical_values,
#                 sep='delimeter', row.name='name')

#grades <- read.table('studentsgrade.csv', header=TRUE, sep=',',
#                 row.name='STUFENTID')

# stringsAsFactors=FALSE
# colclasses

# 2.4 Annotating datasets

# 2.5 Useful functions for working with data objects

# length()
# dim()
# str()
# class()
# mode()
# names()
# c(object, ....) combine objects into a vectors
# cbind()
# rbind()
# object
# head()
# tail()
# ls()
# rm()
# newobject <- edit()
# fix() 

