# reshape and reshape2


require(reshape)
require(reshape2)

# melt(data, id.vars, measure.vars,
#     variable.name = "variable", ..., na.rm = FALSE, 
#     value.name = "value",
#     factorsAsStrings = TRUE)

names(airquality) <- tolower(names(airquality))
head(airquality)
# By default, melt has assumed that all columns with numeric 
# values are variables with values.
airmelt <- melt(airquality)
head(airmelt)
tail(airmelt)

# Maybe here we want to know the values of ozone, solar.r, wind, 
# and temp for each month and day. We can do that with melt by 
# telling it that we want month and day to be "ID variables". 
# ID variables are the variables that identify individual rows 
# of data.

airmetl <- melt(airquality, id=c("month", "day"))
airmetl

airmetl2 <- melt(airquality, id=c("month", "day"),
                 measure = 'wind', 'temp')
airmetl2

names(ChickWeight) <- tolower(names(ChickWeight))
ChickWeight
str(ChickWeight)
ChickWeight_melt <- melt(ChickWeight, id=2:4)
str(ChickWeight_melt)


head(mtcars)
mtcarsmelt <- melt(mtcars, id = c('am', 'vs'))
head(mtcarsmelt, n=10)

?melt.array
# melt(data, varnames = names(dimnames(data)), ...,
#      na.rm = FALSE, as.is = FALSE, value.name = "value")

a <- array(c(1:23, NA), c(2,3,4))
a
melt(a)
melt(a, na.rm = TRUE)
melt(a, varnames=c("X","Y","Z"))
dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a)[1] <- list(NULL)
melt(a)

?cast
# dcast(data, formula, fun.aggregate = NULL, ..., margins = NULL,
#       subset = NULL, fill = NULL, drop = TRUE,
#       value.var = guess_value(data))

# acast(data, formula, fun.aggregate = NULL, ..., margins = NULL,
#       subset = NULL, fill = NULL, drop = TRUE,
#       value.var = guess_value(data))

#Air quality example
names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
head(aqm)
unique(aqm$month)
unique(aqm$day)
dim(aqm)
names(aqm)

#Air quality example

cast(aqm, day + month ~ variable)
cast(aqm, day ~ month ~ variable)


#Chick weight example
names(ChickWeight) <- tolower(names(ChickWeight))



# acate
require(reshape2)
acast(aqm, day ~ month ~ variable)
acast(aqm, month ~ variable, mean)
acast(aqm, month ~ variable, mean, margins = TRUE)
dcast(aqm, month ~ variable, mean, 
      margins = c("month", "variable"))

library(plyr) # needed to access . function
acast(aqm, variable ~ month, mean, 
      subset = .(variable == "ozone"))
acast(aqm, variable ~ month, mean, subset = .(month == 5))

#Chick weight example
names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
head(chick_m)
unique(chick_m$time)

dcast(chick_m, time ~ variable, mean) # average effect of time
dcast(chick_m, diet ~ variable, mean) # average effect of diet
acast(chick_m, diet ~ time, mean) # average effect of diet & time

# How many chicks at each time? - checking for balance
acast(chick_m, time ~ diet, length)
acast(chick_m, chick ~ time, mean)
acast(chick_m, chick ~ time, mean, 
      subset = .(time < 10 & chick < 20))

acast(chick_m, time ~ diet, length)

dcast(chick_m, diet + chick ~ time)
acast(chick_m, diet + chick ~ time)
acast(chick_m, chick ~ time ~ diet)
acast(chick_m, diet + chick ~ time, length, margins="diet")
acast(chick_m, diet + chick ~ time, length, drop = FALSE)

#Tips example
head(tips)
melt(tips)
dcast(melt(tips), sex ~ smoker)
dcast(melt(tips), sex ~ smoker, mean)
dcast(melt(tips), sex ~ smoker, mean, 
      subset = .(variable == "total_bill"))

# French_fries example
head(french_fries)

ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
acast(ff_d, subject ~ time, length)
acast(ff_d, subject ~ time, length, fill=0)
dcast(ff_d, treatment ~ variable, mean, margins = TRUE)
dcast(ff_d, treatment + subject ~ variable, mean, 
      margins="treatment")
if (require("lattice")) {
        lattice::xyplot(`1` ~ `2` | variable, 
                        dcast(ff_d, ... ~ rep), aspect="iso")
}


?colsplit
# colsplit(string, pattern, names)
x <- c("a_1", "a_2", "b_2", "c_3")
vars <- colsplit(x, "_", c("trt", "time"))
vars
str(vars)

help(combine_factor)
# combine_factor(fac, variable=levels(fac), other.label="Other")

df <- data.frame(a = LETTERS[sample(5, 15, replace=TRUE)], 
                 y = rnorm(15))
head(df)
combine_factor(df$a, c(1,2,2,1,2))
combine_factor(df$a, c(1:4, 1))
(f <- reorder(df$a, df$y))
percent <- tapply(abs(df$y), df$a, sum)
combine_factor(f, c(order(percent)[1:3]))

?condense
# condense(data, variables, fun, ...)

?expand.grid.df
# expand.grid.df(..., unique=TRUE)

data.frame(a = 1, b = 1:2)
expand.grid.df(data.frame(a=1,b=1:2))
expand.grid.df(data.frame(a=1,b=1:2), data.frame())
expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2))
expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2), 
               data.frame(e=c("a","b")))

?funstofun
# funstofun(...)

funstofun(min, max)(1:10)
funstofun(length, mean, var)(rnorm(100))

?merge_all
# merge_all(dfs, ...)

?namerows
# namerows(df, col.name = "id")

head(mtcars)
dim(mtcars)
mtcars2 <- namerows(mtcars, col.name = 'Valiant')
dim(mtcars2)

?recast
# recast(data, formula, ..., id.var, measure.var)
recast(french_fries, time ~ variable, id.var = 1:4)


?rename
# rename(x, replace)
head(mtcars)
rename(mtcars, c(wt = "weight", cyl = "cylinders"))
a <- list(a = 1, b = 2, c = 3)
rename(a, c(b = "a", c = "b", a="c")) 
a

# Example supplied by Timothy Bates
names <- c("john", "tim", "andy")
ages <- c(50, 46, 25)
mydata <- data.frame(names,ages)
names(mydata) #-> "name",  "ages"

# lets change "ages" to singular.
# nb: The operation is not done in place, so you need to set your 
# data to that returned from rename

mydata <- rename(mydata, c(ages="age"))
names(mydata) #-> "name",  "age"

?rescaler
# rescaler(x, type="sd", ...)


?sort_df
# sort_df(data, vars=names(data))

head(mtcars)
s1 <- sort_df(mtcars, 'mpg')
s2 <- sort_df(mtcars, c('mpg', 'cyl'))
s1
s2
identical(s1, s2)

?sparseby
# sparseby(data, INDICES = list(), FUN, ..., GROUPNAMES = TRUE)

x <- data.frame(index=c(rep(1,4),rep(2,3)),value=c(1:7))
x
sparseby(x,x$index,nrow)

# The version below works entirely in matrices
x <- as.matrix(x)
sparseby(x,list(group = x[,"index"]), 
         function(subset) 
                 c(mean=mean(subset[,2])))

?stamp
# stamp(data, formula = . ~ ., fun.aggregate, ..., margins=NULL,
#       subset=TRUE, add.missing=FALSE)

?uniquedefault

# uniquedefault(values, default)


?untable
untable(df, num)


??save.table

?tapply
?tapply
?ddply




