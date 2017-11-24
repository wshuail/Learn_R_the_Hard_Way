
# Chapter 6 ---------------

# 6.1 function conpoments
# body, formal, environment
f <- function(x) x^2
f
body(f)
formals(f)
environment(f)
is.function(f)


## primitive function
sum
body(sum)
formals(sum)
environment(sum)
is.primitive(sum)
is.primitive(f)

objs <- mget(ls('package:base'), inherits = T)
funs <- Filter(is.function, objs)
funs


# 6.2 Lexical scoping
# lexical scoping 
# name masking, function vs. variables, a fresh start, dynamic lookup

# 6.2.1 name masking
f <- function(){
    x <- 1
    y <- 2
    c(x, y)
}
f()
rm(f)

x <- 2
g <- function(){
    y <- 1
    c(x, y)
}
g()
rm(g)

x <- 1
h <- function(){
    y <- 2
    i <- function(){
        z <- 3
        c(x, y, z)
    }
    i()
}

h()
rm(x, h)

j <- function(x){
    y <- 2
    function(){
        c(x, y)
    }
}
k <- j(1)
k
rm(j, k)


# 6.2.2 functions vs variable
l <- function(x) x + 1
m <- function(){
    l <- function(x) x*2
    l(10)
}
m()
rm(l, m)

n <- function(x) x / 2
o <- function(){
    n <- 10
    n(n)
}
o()
rm(n, o)

# 6.2.3 a fresh start
j <- function(){
    if (! exists('a')){
        a <- 1
    } else {
        a <- a + 1
    }
    print(a)
}
j()
rm(j)


# 6.2.4 dynamic lookup

f <- function() x
x <- 15
f()
x <- 20
f()

f <- function() x + 1
codetools::findGlobals(f)

environment(f) <- emptyenv()
f()

# exercise
c <- 10
c(c = c)


## 6.3 Every operation is a function call
x <- 10
y <- 5
x + y
'+'(x, y)

for (i in 1: 2) print(i)
'for'(i, 1: 2, print(i))

if (x ==1) print('yes!') else print ('no!')
'if'(x == 1, print('yes!'), print('no!'))

x[3]
'['(x, 3)

{print(1); print(2); print(3)}
'{'(print(1), print(2), print(3))

add <- function(x, y) x + y
sapply(1: 10, add, 3)

sapply(1: 5, '+', 3)
sapply(1: 5, "+", 3)

c(1: 5) + 3

x <- list(1: 3, 4: 6, 7: 9)
sapply(x, '[', 2)
sapply(x, function(x) x[2])

## 6.4 function argument

# 6.4.1 calling function
f <- function(abcdef, bcde1, bcde2){
    list(a = abcdef, b1 = bcde1, b2 = bcde2)
}
str(f(1, 2, 3))
str(f(2, 3, abcdef = 1))
str(f(2, 3, a = 1))
str(f(1, 3, b = 2))

mean(1: 10)
mean(1: 10, trim = 0.05)


## 6.4.2 calling a function given a list of argument
args <- list(1: 10, na.rm = T)

mean(args)
do.call(mean, args)
do.call(mean, list(1: 10, na.rm = T))
mean(1: 10, na.rm = T)

## 6.4.3 default and missing arguments
f <- function(a = 1, b = 2){
    c(a, b)
}
f()
f(4, 5)

g <- function(a = 1, b = a * 2){
    c(a, b)
}
g()
g(1)
g(1, 2)
g(1, 3)

h <- function(a = 1, b = d){
    d <- (a + 1) ^ 2
    c(a, b)
}
h()
h(2)

i <- function(a, b){
    c(missing(a), missing(b))
}
i()
i(a = 1)
i(b = 1)
i(a = 1, b = 1)


## 6.4.4 Lazy Evaluation
f <- function(x){
    10
}
f(stop('This is an error!'))

f <- function(x){
    force(x)
    10
}
f(stop('This is an error!'))

add <- function(x){
    function(y) x + y
}
adders <- lapply(1: 10, add)
adders
adders[[1]](10)
adders[[10]](10)

add <- function(x){
    force(x)
    function(y) x + y
}
adders <- lapply(1: 10, add)
adders
adders[[1]](10)
adders[[10]](10)

add <- function(x) {
    x
    function(y) x + y
}

f <- function(x = ls()){
    a <- 1
    x
}
f()
f(ls())

x <- NULL
if (!is.null(x) && x > 0){
    
}

'&&' <- function(x, y){
    if (!x) return(FALSE)
    if (!y) return(FALSE)
    TRUE
}

a <- NULL
!is.null(a) && a > 0

if (is.null(a)) stop('a is null!')
!is.null(a) || stop('a is null!')


## 6.4.5 ...

plot(1: 5, col = 'red')
plot(1: 5, cex = 5, pch = 20)
plot(1: 5, bty = 'u')
plot(1: 5, labels = F)

f <- function(...){
    names(list(...))
}
f(a = 1, b = 2)

sum(1, 2, NA, na.rm = T)

# exercise
x <- sample(replace = T, 20, x = c(1: 10, NA))
x
y <- runif(min = 0, max = 1, 20)
y
cor(m = 'k', y = y, u = 'p', x = x)

f1 <- function(x = {y <- 1; 2}, y = 0){
    print (x)
    x + y
}
f1()

f2 <- function(x = z){
    z <- 100
    x
}
f2()


## 6.5 special calls
# infix and eplacement functions

# 6.5.1 infix functions
'%+%' <- function(a, b) paste(a, b, sep = '')
'new' %+% ' string'
'%+%'('new', ' string')

1 + 5
'+'(1, 5)

'% %' <- function(a, b) paste(a, b)
'%`%' <- function(a, b) paste(a, b)
'%/\\%' <- function(a, b) paste(a, b)

'a' % % 'b'
'a' %`% 'b'
'a' %/\% 'b'

'%-%' <- function(a, b) paste0('(', a, ' %-% ', b, ')')
'a' %-% 'b' %-% 'c'

'%||%' <- function(a, b) if (!is.null(a)) a else b
# function_that_might_return_null() || default value


# 6.5.2 replacement functions
'second<-' <- function(x, value){
    x[2] <- value
    x
}
x <- 1: 10
second(x) <- 5L
x

library(pryr)
x <- 1: 10
address(x)
second(x) <- 6L
address(x)

x <- 1: 10
address(x)
x[2] <- 7L
address(x)

'modify<-' <- function(x, position, value){
    x[position] <- value
    x
}
x <- 1: 10
modify(x, 1) <- 10L
x

x <- c(a = 1, b = 2, c = 5)
x
names(x)
names(x)[2] <- 'two'
x

## 6.4 return values

f <- function(x){
    if (x < 10){
        0
    } else {
        10
    }
}
f(5)
f(20)

f <- function(x){
    x$a <- 2
    x
}
x <- list(a = 1)
x
f(x)
x$a
 
f1 <- function() 1
f1()

f2 <- function() invisible(2)
f2()
f2() == 2
(f2())

a <- 2
(a <- 2)

a <- b <- c <- d <- 2
(a <- (b <- (c <- (d <- 2))))

## 6.6.1 on exit

in_dir <- function(dir, code){
    old <- setwd(dir)
    on.exit(setwd(old))
    
    force(code)
}

getwd()
in_dir('~', getwd())

