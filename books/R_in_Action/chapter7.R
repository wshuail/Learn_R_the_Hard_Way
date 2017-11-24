# Chapter 7 Basic Statistics

# 7.1 Descriptive statistics

vars <- c('mpg', 'hp', 'wt')
head(mtcars[vars])

# 7.1.1 A menagerie of methods

# summary()

summary(mtcars[vars])

# sapply(x, FUN, options)
# mead, sd, var, min, max, median, length, range, quantile

mystats <- function(x, na.omit = FALSE){
     if (na.omit)
          x <- x[!is.na(x)]
     m <- mean(x)
     n <- length(x)
     s <- sd(x)
     skew <- sum((x-m)^3/s^3)/n
     kurt <- sum((x-m)^4/s^4)/n-3
     return(c(n = n, mean = m, stdev = s, skew = skew,
              kurtosis = kurt))
}
sapply(mtcars[vars], mystats)

# install.packages('Hmisc')
library(Hmisc)
describe(mtcars$vars)

# install.packages('pastecs')
library(pastecs)
stat.desc(x, basic = TRUE, desc = TRUE, norm = FALSE, p = 0.95)

# install.packages(psych)
library(psych)
describe(mtcars[vars])

# 7.1.2 Descriptive by groups

aggregate(mtcars[vars], by = list(am = mtcars$am), mean)

aggregate(mtcars[vars], by = list(am = mtcars$am), sd)

aggregate(mtcars[vars], by = list(am = mtcars$am), min)

aggregate(mtcars[vars], list(mtcars$am), mean)

# by(data, INDICES, FUN)

dstats <- function(x)(c(mean = mean(x), sd = sd(x)))
by(mtcars[vars], mtcars$am, dstats)

# install.packages('doBy')

# summaryBy(formula, data = dataframe, FUN = function)
# var1 + var2 + var3 ~ groupvar1 + groupvar2 + groupvar3

library(doBy)
summaryBy(mpg+hp+wt~am, data = mtcars, FUN = dstats)

# install.packages('psych')
library(psych)
describe.by(mtcars[vars], mtcars$am)


# 7.1.3 Visualizing results

# 7.2 fenquency and contingency tables

library(vcd)
head(Arthritis)

# Generating frequency tables

# table(var1, var2, ..., varN)
# xtabs(formula, data)
# prop.table(table, margins)
# margin.table(table, margins)
# addmargins(table, margins)
# ftable(table)

# One-way tables

mytable <- with(Arthritis, table(Improved))
mytable

prop.table(mytable)
prop.table(mytable)*100

# two-way tables

# mytable <- table(A, B)
# mytable <- xtabs(~A + B, data = mydata)

mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable

margin.table(mytable, 1)  # i indicates the 1st variable
prop.table(mytable, 1)

margin.table(mytable, 2)
prop.table(mytable, 2)

margin.table(mytable, 3)
prop.table(mytable, 3)  # 3 will cause error

prop.table(mytable)  # cell proportion

addmargins(prop.table(mytable))  # sum

addmargins(prop.table(mytable, 1), 2)  # collum sum

addmargins(prop.table(mytable, 1), 1)  # row sum

# the table() function ignores the missing value defaultly,
# useNA = 'ifancy'

# install.packages(gmodels)
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# multimimensional tables

# table()
# xtabs()
# margin.table()
# prop.table()
# addmargins()
# ftable()

mytable <- xtabs(~ Treatment + Sex + Improved,
                 data = Arthritis)
mytable

ftable(mytable)

margin.table(mytable, 1)

margin.table(mytable, 2)

margin.table(mytable, 3)

margin.table(mytable, c(1, 3))

ftable(prop.table(mytable, c(1, 2)))

ftable(addmargins(prop.table(mytable, c(1, 2)), 3))

# Test of indenpendence

# CHI-SQUARE of indenpendence

# chisq.test()

library(vcd)
mytable <- xtabs(~Treatment + Improved, data = Arthritis)
chisq.test(mytable)

mytable <- xtabs(~Improved + Sex, data = Arthritis)
chisq.test(mytable)

# fisher test
# fisher.test()

mytable <- xtabs(~Treatment + Improved, data = Arthritis)
fisher.test(mytable)

# Cochran-Mantel-Haenzel test

mytable <- xtabs(~Treatment + Improved + Sex, data = Arthritis)
mantelhaen.test(mytable)

# 7.2.3 Measure of association

library(vcd)

mytable <- xtabs(~Treatment + Improved, data = Arthritis)
assocstats(mytable)

# 7.2.4 Visualizing resuts

table2flat <- function(mytable){
     df <- as.data.frame(mytable)
     rows <- dim(df)[1]
     cols <- dim(df)[2]
     x <- NULL
     for (i in 1:rows){
          for (j in 1:df$Freq[i]){
               row <- df[i, c(i: (cols - 1))]
               x <- rbind(x, row)
          }
     }
     row.names(x) <- c(1:dim(x)[1])
     return(x)
}
mytable
table2flat


treatment <- rep(c('Placebo', 'Treated'), times = 3)
improved <- rep(c('None', 'Some', 'Marked'), each = 2)
Freq <- c(29, 13, 7, 17, 7, 21)
mytable <- as.data.frame(cbind(treatment, improved, Freq))
mydata <- table2flat(mytable)
mydata

# 7.3 Correlations

# 7.3.1  pearson, spearman, and kendall correlations

# cor(x, use = , method = )
# cov()
# use = all.obs, everything, complete.obs, pairwise.obs
# method = pearson, spearman, kendall

states <- state.x77[ , 1:6]
cov(states)
cor(states)
cor(states,  method = 'spearman')

x <- states[, c('Population', 'Income',
                'Illiteracy', 'HS Grad')]
y <- states[, c('Life Exp', 'Murder')]
cor(x, y)

# Partial correlations

library(ggm)
# pcor(u, s)

pcor(c(1, 5, 2, 3, 6), cov(states))

# 7.3.2 Testing correlations for significance

# cor.test(x, y, alternative = , method = )
# alternative = two.side, less, greater

cor.test(states[, 3], states[, 5])

library(psych)
corr.test(states, use = 'complete')

# r.test()
# pcor.test(r, q, n)

# 7.3.3 Visualizing correlations

# 7.4 t-tests

# 7.4.1 Indenpandent t-test

# t.test(y ~ x, data)

# t.test(y1, y2)

library(MASS)
t.test(Prob ~ So, data = UScrime)

# Dependent t-test

# t.test(y1, y2, paired = TRUE)

library(MASS)
sapply(UScrime[c('U1', 'U2')],
       function(x)(c(mean = mean(x), sd = sd(x))))

with(UScrime, t.test(U1, U2, paired = TRUE))

# 7.4.3 When there are two more groups

# 7.5 nonparametric tests of group difference

# 7.5.1  Comparing two groups

# wilcox.test (y ~ x, data)
# wilcox.test(y1, y2)

with(UScrime, by(Prob, So, median))

wilcox.test(Prob ~ So, data = UScrime)

sapply(UScrime[c('U1', 'U2')], median)

with(UScrime, wilcox.test(U1, U2, paired = TRUE))

# 7.5.2 Comparing more than two groups

# kruskal.test(y ~ A, data)

# friedman.test(y ~ A | B, data)

states <- as.data.frame(cbind(state.region, state.x77))
kruskal.test(Illiteracy ~ state.region, data = states)

class <- state.region
var <- state.x77[, c('Illiteracy')]
mydata <- as.data.frame(cbind(class, var))
rm(class, var)
library(npmc)
summary(npmc(mydata), type = 'BF')

aggregate(mydata, by = list(mydata$class), median)

# 7.6 Visualizing group differences

# 7.7 summary 























