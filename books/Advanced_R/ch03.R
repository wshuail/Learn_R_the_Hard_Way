
## Chapter 3 Subseting

# Three subseting operation
# Six types of subseting
# For different types of object
# in conjection with assignment

## 3.1 Data Types 
## 3.1.1 Atomic vector
x <- c(2.1, 4.2, 3.3, 5.4)

## Positive integers
x[c(3, 1)]
x[order(x)]
x[c(1, 1)]
x[c(2.1, 2.9)]

# Negative integers
x[-c(3, 1)]
x[c(-1, 2)]  ## can't mix positive and nagtive integers

# Logical vectors
x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]

x[c(TRUE, FALSE)]
x[c(TRUE, FALSE, TRUE, FALSE)]
x[c(TRUE, FALSE, NA, FALSE)]  # Missing value

# Nothing
x[]

# Zero
x[0]

# Charactor vectors
y <-  setNames(x, letters[1: 4])
y

y[c('d', 'c', 'a')]
y[c('a', 'a', 'a')]

z <- c(abc = 1, def = 2)
z[c('a', 'd')]


## 3.1.2 Lists
# [ return a list
# [[ and $ can pull out of the components

## 3.1.3 Matrix and Arrays
# mulpiple vectors
# single vectors
# matrix

a <- matrix(1: 9, nrow = 3)
colnames(a) <- c('a', 'b', 'c')
a
a[1: 2, ]
a[c(T, F, T), c('b', 'a')]
a[0, -2]


vals <- outer(1: 5, 1: 5, FUN = 'paste', sep = ',')
vals
typeof(vals)
str(vals)
vals[c(4, 15)]

select <- matrix(ncol = 2, byrow = T,
                 c(1, 1, 3, 1, 2, 4))
select
vals[select]


## 3.1.4 Data.frame

df <- data.frame(x = 1: 3, y = 3: 1, z = letters[1: 3])
df

df[df$x == 2, ]
df[c(1, 3), ]

# two way to select a column
df[c('x', 'z')]  # like a list
df[, c('x', 'z')]  # like a matrix

# special case for one column
df['x']
str(df['x'])
df[, 'x']
str(df[, 'x'])



## 3.1.5 S3 objects

## 3.1.4 S4 objects
## @, $, slot(), [[



## Subbseting operations ==============

## [[ works for list
a <- list(a = 1, b = 2)
a
a[1]
a[[1]]
a['a']
a[['a']]

b <- list(a = list(b = list(c = list(d = 1))))
b
b[[c('a', 'b', 'c', 'd')]]
b[['a']][['b']][['c']][['d']]


## 3.2.1 simplfing vs preserving subseting

# atomic vector
x <- c(a = 1, b = 2)
x
x[1]
x[[1]]

# list
y <- list(a = 1, b = 2)
y
str(y[1])
str(y[[1]])

# factor
z <- factor(c('a', 'b'))
z
typeof(z)
z[1]
z[1, drop = T]

# matrix or array
a <- matrix(1: 4, nrow = 2)
a
a[1, ]
a[1, , drop = T]

# data frame

df <- data.frame(a = 1: 2, b = 1: 2)
df
df[1]
str(df[1])
df[, 1]
str(df[, 1])
df[[1]]
str(df[[1]])


## 3.2.2 $
# x$y equivalent to x[['y', exact = F]]
var <- 'cyl'
mtcars$var
mtcars[[var]]

x <- list(abc = 1)
x
x$a
x[['a']]


## 3.2.3 missing/out of bounds indices
x <- 1: 4
str(x[5])
str(x[NA_real_])
str(x[NULL])

mod <- lm(mpg ~ wt, data = mtcars)
summary(mod)
typeof(mod)
str(mod)
mod[['residuals']]


## 3.3 Subseting and assignment
x <- 1: 5
x[c(1, 2)] <- 2: 3
x

x[-1] <- 4: 1
x

x[c(1, 1)] <- 2: 3
x

x[c(1, NA)] <- c(1, 2)
x[c(T, F, NA)] <- 1
x

df <- data.frame(a = c(1, 10, NA))
df
df$a[df$a < 5] <- 0
df$a


mtcars[] <- lapply(mtcars, as.integer)
str(mtcars)

mtcars <- lapply(mtcars, as.integer)
str(mtcars)

x <- list(a = 1, b = 2)
x
x[['b']] <- NULL
x
str(x)

y <- list(a = 1)
y
y['b'] <- list(NULL)
str(y)


## 3.4 Application

# 3.4.1 lookup tables
x <- c('m', 'f', 'u', 'f', 'f', 'm', 'm')
lookup <- c(m = 'Male', f = 'Female', u = NA)
lookup[x]
unname(lookup[x])

lookup <- c(m = 'Male', f = 'Female', u = NA)[x]
lookup
unname(lookup)

## 3.4.2 Matching and Merging by hand
grades <- c(1, 2, 2, 3, 1)
info <- data.frame(
    grades = 1: 3,
    desc = c('Excellent', 'Good', 'Poor'),
    fail = c(F, F, T)
)
info

# using match
id <- match(grades, info$grades)
info
info[id, ]

# using rownames
rownames(info) <- info$grades
info
str(info)
info[as.character(grades), ]


## 3.4.3 Random samples/bootstrap

df <- data.frame(
    x = rep(1: 3, each = 2),
    y = 6: 1,
    z = letters[1: 6]
)
df

df[sample(nrow(df)), ]
df[sample(nrow(df), 3), ]
df[sample(nrow(df), 6, replace = T), ]


## ordering
x <- c('b', 'c', 'a')
order(x)
x[order(x)]

df2 <- df[sample(nrow(df)), 3: 1]
df2

df2[order(df2$x), ]
df2[, order(names(df2))]


## 3.4.5 EXpanding aggregated counts
df <- data.frame(
    x = c(2, 4, 1),
    y = c(9, 11, 6),
    n = c(3, 5, 1)
)
df

rep(1: nrow(df), df$n)
df[rep(1: nrow(df), df$n), ]


## 3.4.6 Removing columns from data.frame
df <- data.frame(x = 1: 3, y = 3: 1, z = letters[1: 3])
df$z <- NULL
df

df <- data.frame(x = 1: 3, y = 3: 1, z = letters[1: 3])
df[c('x', 'y')]

df[setdiff(names(df), 'z')]


## 3.4.7 Selecting rows based on a condition

mtcars[mtcars$gear == 5, ]
mtcars[mtcars$gear == 5 & mtcars$cyl == 4, ]

subset(mtcars, gear == 5)
subset(mtcars, gear == 5 & cyl == 4)

# 3.4.8 Boolean algebra vs sets
# which converts boolean to integer
x <- sample(10)
x
x <- sample(10) < 4
x
which(x)

unwhich <- function(x, n){
    out <- rep_len(FALSE, n)
    out[x] <- TRUE
    out
}
unwhich(which(x), 10)


x1 <- (1: 10 %% 2 == 0)
x2 <- which(x1)

y1 <- (1: 10 %% 5 == 0)
y2 <- which(y1)

x1 & y1
intersect(x2, y2)

x1 | y1
union(x2, y2)

x1 & !y1
setdiff(x2, y2)
xor(x1, y1)
setdiff(union(x2, y2), intersect(x2, y2))



