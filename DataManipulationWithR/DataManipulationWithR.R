
# Data in R

mylist  = list(a = c(1, 2, 3), 
               b = c('cat', 'dog', 'duck'),
               d = factor('a', 'b', 'c'))
sapply(mylist, mode)

sapply(mylist[2], mode)

sapply(mylist, class)

x <- c(1, 2, 5, 10)
x
mode(x)
class(x)

y <- c(1, 2, 'cat', 3)
y
mode(y)

z <- c(5, T, 3, 7)
z
mode(z)

all <- c(x, y, z)
all
mode(all)
class(x)

h <- c(1, 2, one, two)
mode(h)

X1 <- c('one' = 1, 'two' = 2, 'three' = 3)
x1

x2 <- c(1, 2, 3)
x2

names(x2) <- c('one','two', 'three')
x2

names(x2) [1:2] <- c('foo', 'bar')
x2

nums = 1:10
nums + 1

nums = 1:10
nums + c(1, 2)
c(1, 2) + nums
nums + c(1, 2, 3)

## matrix

rmat <- matrix(rnorm(15), nrow = 5, ncol = 3,
               dimnames = list(NULL, c('A', 'B', 'C')))
rmat
dimnames(rmat)

rmat = matrix(rnorm(15), 3, 5, byrow = FALSE)
rmat

## list

mylist <- list(c(1, 4, 6), 'dog', 3,
               'cat', TRUE, c(9, 10, 11))
mylist
sapply(mylist, mode)

mylist <- list(first = c(1, 3, 5),
               second = c('one', 'three', 'five'),
               third = 'end')
mylist
names(mylist)

## conversion of an object

nums <- c(rnorm(10), 5, 5)
tt <- table(nums)
tt
names(tt)
sum(names(tt) * tt)
sum(as.numeric(names(tt)) * tt)

x <- c(1, 3, 4, 5, 7)
list(x)
as.list(x)

## Missing values

## sequences

length(gl(3, 10))

thelevels <- data.frame(group = gl(3, 10, length = 30),
                        subgroup = gl(5, 2, length = 30),
                        obs = gl(2, 1, length = 30))
names(thelevels) <- c('A', 'B', 'C')

head(thelevels, n = 10)

oe <- expand.grid(odd = seq(1, 5, by = 2),
                  even = seq(2, 5, by = 2))
oe

## sample

sequence <- sample(1:10)
rle(sequence)

rle.seq <- rle(sequence)
index <- which (rle.seq$values == 2 & rle.seq$lengths >= 1)
cumsum(rle.seq$values)[index]

# factor

data <- sample(10)
fdata <- factor(data)
fdata

data <- sample(1:3, 10, replace = T)
data
rdata <- factor(data, label = c('A', 'B', 'C'))
rdata

slevels <- levels(InsectSprays$spray)
slevels

InsectSprays$spray <- with(InsectSprays, 
                           reorder(spray, count, mean))
reorderslevels <- levels(InsectSpray$spray)
reorderslevels

fert <- sample(1:3, 10, replace = T)
fert <- factor(fert, levels = c(1, 2, 3), ordered = T)
fert
mean(fert)
mean(as.numeric(fert))
mean(as.numeric(levels(fert)[fert]))
mean(as.numeric(as.character(fert)))

lets <- sample(letters, 100, replace = T)
lets <- factor(lets)
table(lets[1:5])
table(lets[1:5, drop = T])
table(factor(lets[1:5]))

fact1 <- sample(letters, 10, replace = T)
fact2 <- sample(letters, 10, replace = T)
fact1 <- factor(fact1)
fact2 <- factor(fact2)
fact1
fact2
fact12 <- factor(c(levels(fact1)[fact1],
                   levels(fact2)[fact2])
                 )
fact12

## levels
x <- gl(2, 4, 8)
levels(x)[x]
levels(x)[1] <- 'low'
levels(x)[2] <- 'high'
x

f3 <- sample(letters, 10, replace = T)
f3 <- factor(f3)
levels(f3)
f3
f4 <- factor(f3)
levels(f4)
f4
f5 <- factor(f4)
f5


wfcat <- cut(women$weight, 3)
wfcat
table(wfcat)

wfcat <- cut(women$weight, pretty(women$weight, 3))
wfcat
table(wfcat)


## table

a <- letters[1:3]
table(a, sample(a))

wfcat <- cut(women$weight, 3, 
             labels = c('low', 'medium', 'high'))
table(wfcat)


wfcat <- cut(women$weight,
             quantile(women$weight, (0:4)/4))
table(wfcat)

everyday <- seq(from = as.Date('2005-01-01'),
                to = as.Date('2005-12.31'),
                by = 'day')
cmonth <- format(everyday, '%b')
months <- factor(cmonth, levels = unique(cmonth), 
                 ordered = T)
table(months)

newfact <- with(CO2,
                interaction(Plant, Type))
nlevels(newfact)

newfact <- with(CO2,
                interaction(Plant, Type, drop = T))
nlevels(newfact)

# subscripting

nums <- sample(1:20, 10)
nums > 10

nums[nums > 10]
which(nums > 10)

nums[nums > 10] <- 0
nums[nums > 10]
nums

matrix <- matrix(1:12, 4, 3)
matrix
matrix[, 1]
matrix[, c(1, 3)]
matrix[2, ]
matrix[10]
matrix[1]

stack.x.a <- stack.x[order(stack.x[, 'Air.Flow']), ]
head(stack.x.a, n = 10)

stack.x.a <- stack.x[order(stack.x[, 'Air.Flow'])]
head(stack.x.a, n = 10)


## could not find the 'sortframe'
with(iris, 
     sortframe(iris, Sepal.Length, Sepal.Width))

## the 'rev' function
riris = iris[rev(1:nrow(iris)), ]
head(riris)

x <- c(1:5, 5:3)
stopifnot(sort(x, decreasing = T) == rev(sort(x)))
stopifnot(rev(1:7) == 7:1)

x <- matrix(1:12, 4, 3)
x
x[, 1]
x[, 1, drop = F]
x[, 1] < 3
x[x[, 1] < 3, ]

matrix <- matrix(scan(), ncol = 3, byrow = T)
1 1 12 1 2 7 2 1 9 2 2 16 3 1 12 3 2 15 3  5 6 6 7 

## row and col function

m1 <- sample(1:10, 16, replace = T)
m2 <- sample(1:10, 16, replace = T)
mm <- table(m1, m2)
mm

offd <- row(mm) != col(mm)
offd

mm[offd]

## list

s <- list(a = c('fred', 'moon'), b = c(24, 56))
mode(s)
s[2]
mode(s[2])
mean(s[2])

mean(s$b)
mean(s[[2]])
mean(s[['b']])

s[1]
s[[1]]

s[c(1, 2)]
s[1:2]
s[c('a', 'b')]

dd <- data.frame(a = c(1, 2, 3, 4, 5, 6),
                 b = c(7, NA, 8, 9, NA, 15))
dd

dd[dd$b > 9, ]
dd[!is.na(dd$b) & dd$b > 9, ]
subset(dd, b > 9)

s <- subset(LifeCycleSavings,
            sr > 10,
            select = c(pop15, pop75))
head(s)

life1 <- subset(LifeCycleSavings,
                select = pop15:dpi)
head(life1)

life2 <- subset(LifeCycleSavings, select = 1:3)
head(life2)

life3 <- subset(LifeCycleSavings, 
                select = c(-pop15, -pop75))
head(life3)

life4 <- subset(LifeCycleSavings, select = -c(2, 3))
head(life4)

#  chapter 7 character manipulation


## nchar()
state.name
nchar(state.name)
length(state.name)

## cat
x =7
y =10
cat('x should be larger than y, but x =',
    x, 'and y =', y, '\n')

cat('long string can', 'be displayed over',
    'several lines using', 'the fill = argument',
    fill = 40)

## paste

paste(1, 'two', 3, 'four', 5)
paste(c(1, 'two', 3, 'four', 5), collapse = ' ')

paste(1:3, 'X', sep = '')
paste(c('X', 'Y'), 1:5, sep = '')
paste(c('X', 'Y'), 1:5, collapse = '')

paste(c('X', 'Y'), 1:5, sep = '_', collapse = '|')

paste(c('X', 'Y'), 1:5, '^', c('a', 'b'), 
      sep = '_', collapse = '|')

paste(c('X', 'Y'), 1:5, '^', c('a', 'b'), sep = '_')

## substring

substring(state.name, 2, 6)

mystring <- 'dog cat duck'
substring(mystring, c(1, 5, 9), c(3, 7, 12))
mystring2 <- 'hello world'
substring(mystring2, c(1, 6), c(5, 11))

state <- 'Mississippi'
ll <- nchar(state)
ltrs <- substring(state, 1:ll, 1:ll)
ltrs
which(ltrs == 's')

mystring <- 'dog cat duck'
substring(mystring, 5, 7) <- 'feline'
mystring

mystring <- 'dog cat duck'
substring(mystring, 5, 7) <- 'a'
mystring

# 7.4 Regular expression in R

expr <- '.*\\.txt'
nchar(expr)
cat(expr, '\n')
expr <- readline()

# . ^ $ + ? * ( ) [ ] { } | \

# [0-9][0-9][a-zA-Z]+
# (abc){3}
# ^[a-zA-z]+\\.jpg$

string <- c('chidren', 'dog', 'cat')
expr <- paste(string, collapse = '|')
expr

# 7.6 breaking apart character values

sentence <- 'R is a free software environment for statistocal computing'
parts <- strsplit(sentence, ' ')
parts
length(parts)
length(parts[[1]])

more <- c('R is a free software environment for statistocal 
              computing', 'It compiles and runs on a wide variaty
              of UNIX plantforms')
parts <- strsplit(more, ' +')
sapply(parts, length)

allparts <- unlist(parts)
allparts

str <- 'one two three four'
strsplit(str, ' ')

str <- c('one two', 'three four')
strsplit(str, '')

# 7.7 using regular expression in R

grep('^pop', names(LifeCycleSavings))
grep('^pop', names(LifeCycleSavings), value = TRUE)
head(LifeCycleSavings[, grep('^pop', names(LifeCycleSavings))])

inp <- c('run dog run', 'work doggedly', 'CAT AND DOG')
grep('\\<dog\\>', inp, ignore.case = TRUE)

# use any()

str1 <- c('The R Foundation', 'is a nor for profit organization',
          'work in the public interest')
str2 <- c('It was founded by the members', 'of the R core team in
          order to', 'provide support for the R project')
any(grep('profit', str1))
any(grep('thre', str1))
any(grep('profit', str2))

# regexpr()

tst <- c('one x7 two b1', 'three c5 four b9',
         'five six seven', 'a8 eight nine')
wh <- regexpr('[a-z][0-9]', tst)
wh
res <- substring(tst, wh, wh + attr(wh, 'match.length') - 1)
res
res[res != '']

#gregexpr

tst <- c('one x7 two b1', 'three c5 four b9',
         'five six seven', 'a8 eight nine')
wh2 <- gregexpr('[a-z][0-9]', tst)
wh2
res2 <- list()
for (i in 1:length(wh2)){
     res2[[i]] <- substring(tst[i], wh2[[i]],
                            wh2[[i]] + attr(wh2[[2]],
                                            'match.length') - 1)
}
res2

getexpr <- function(str, grep)substring(str, grep, 
                                        grep + attr(grep, 'match.length') - 1)
res3 <- mapply(getexpr, tst, wh)
res3

# 7.8 substitutions and tagging

value <- c('$11,317.35', '$11,234.51', '$11,275.89')
as.numeric(gsub('[$,]', '', value))












