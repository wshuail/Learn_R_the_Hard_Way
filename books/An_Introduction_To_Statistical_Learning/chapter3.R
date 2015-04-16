# Chapter 3

# 3.6 Lab: Linear Regression
# 3.6.1 Libraries
library(MASS)
library(ISLR)

# 3.6.2 Simple Linear Regression
fix(Boston)
names(Boston)

lm.fit <- lm(medv ~ lstat, data = Boston)
lm.fit
summary(lm.fit)

# medv = lstat * (-0.95005) + 34.55384
# RSE: 6.22
# R^2: 0.544
# F: 602
# p-value: <2e-16

names(lm.fit)
coef(lm.fit)
confint(lm.fit)

# the predict function
predict_conf <- predict(lm.fit, data.frame(lstat = c(5, 10, 15)),
                   interval = 'confidence')
predict_conf

predict_pred <- predict(lm.fit, data.frame(lstat = c(5, 10, 15)),
                        interval = 'prediction')
predict_pred

plot(Boston$lstat, Boston$medv)
abline(lm.fit)
abline(lm.fit, lwd = 3)
abline(lm.fit, lwd = 3, col = 'red')

plot(Boston$lstat, Boston$medv, col = 'red')
plot(Boston$lstat, Boston$medv, pch = 20)
plot(Boston$lstat, Boston$medv, pch = '+')

plot(1:20, 1:20, pch = 20, col = 'red')

# diagnostic plots
par(mfrow = c(2, 2))
plot(lm.fit)

plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))

plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

# Multiple Linear Regression
lm.fit_2 <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit_2)

lm.fit_3 <- lm(medv ~ ., data = Boston)
summary(lm.fit_3)
names(lm.fit_3)

lm.fit_3$coefficients
lm.fit_3$residuals
lm.fit_3$effects
lm.fit_3$rank
lm.fit_3$fitted.values
lm.fit_3$assign
lm.fit_3$qr
lm.fit_3$df.residual
lm.fit_3$xlevels
lm.fit_3$call
lm.fit_3$terms
lm.fit_3$model

library(car)
vif(lm.fit_3)

lm.fit_4 <- lm(medv ~ .-age, data = Boston)
summary(lm.fit_4)

# 3.6.4 Interaction terms

lm.fit_5 <- lm(medv ~ lstat*age, data = Boston)
summary(lm.fit_5)

# Non-Linear Transformations of the Predications

lm.fit_6 <- lm(medv ~ lstat + I(lstat^2), data = Boston)
summary(lm.fit_6)
lm.fit_7 <- lm(medv ~ lstat, Boston)
anova(lm.fit_7, lm.fit_6)

par(mfrow = c(2, 2))
plot(lm.fit_6)

lm.fit_8 <- lm(medv ~ poly(lstat, 5), Boston)
summary(lm.fit_8)

lm.fit_9 <- lm(medv ~ log(rm), Boston)
summary(lm.fit_9)
lm.fit_10 <- lm(medv ~ rm, Boston)
anova(lm.fit_9, lm.fit_10)

# 3.6.6 Quantitive Predictors
head(Carseats)

lm.fit_11 <- lm(Sales ~ . + Income:Advertising + Price: Age, 
                Carseats)
summary(lm.fit_11)

contrasts(Carseats$ShelveLoc)
?contrasts

# 3.6.7 Writing Functions

# 3.7 Exercise

# Applied
# 8
list.files()

auto <- read.csv('Auto.csv', sep = ',', header = T,
                 stringsAsFactors = T, na.strings = '?')
auto <- na.omit(auto)
?read.csv
head(auto)
names(auto)
class(auto)
lm_1 <- lm(horsepower ~ mpg, auto)
summary(lm_1)
# positive relationship between them
# hp = 194.48 - 3.8 * mpg 
?confint
confint(lm_1, level = 0.98)
confint(lm_1, level = 0.95)

plot(auto$mpg, auto$horsepower)
abline(lm_1)

par(mfrow = c(2, 2))
plot(lm_1)

# 9

library(car)
# The string should be taken as factor
scatterplotMatrix(auto, spread = F, lty = 2, 
                  main = 'Scatter Plot Matrix')
library(dplyr)
auto_1 <- select(auto, -name)

cor(auto_1)

lm_2 <- lm(mpg ~ ., auto_1)
summary(lm_2)

plot(lm_2)

lm_3 <- lm(mpg ~ (cylinders + displacement + horsepower + 
                weight + acceleration + year + origin)^2, auto_1)
summary(lm_3)

lm_4 <- lm(mpg ~ log(weight), auto)
summary(lm_4)
lm_5 <- lm(mpg ~ weight, auto)
summary(lm_5)

# 10
library(ISLR)
data(Carseats)
head(Carseats)
lm_6 <- lm(Sales ~ Price + Urban + US, Carseats)
summary(lm_6)

# Sales = 13.043 - 0.054*Price - 0.022*Urban + 1.201*US
#         (Urban is 1, or 0; US is 1, or 0)

library(car)
lm_7 <- lm(Sales ~ ., Carseats)
summary(lm_7)
vif_car <- vif(lm_7)
sqrt(vif_car)

lm_8 <- lm(Sales ~ CompPrice + Income + Advertising + Price + 
                ShelveLoc + Age, Carseats)
summary(lm_8)

confint(lm_8)

outlierTest(lm_7)

# 11
set.seed(1)
x = rnorm(100)
y = 2*x + rnorm(100)

# regression y onto x
lm_9 <- lm(y ~ x + 0)
summary(lm_9)

# coefficient: 1.9682
# residual standard error: 1.033 on 99%
# t-test: p < 0.0016 

# regression x onto y
lm_10 <- lm(x ~ y + 0)
summary(lm_10)
#coefficient: 0.401
# rse: 0.466 on 99%
# p < 0.0016

# 13
?rnorm
set.seed(1)
x <- rnorm(100, 0, 1)
x
eps <- rnorm(100, 0, 0.25)
eps
y <- (-1) + 0.5*x + eps
y

lm_11 <- lm(y ~ x)
summary(lm_11)
# y = 0.48663*x - 0.99309

plot(x, y)
abline(lm_11, col = 'blue')
legend()


lm_12 <- lm(y ~ x + I(x)^2)
summary(lm_12)

# 14
set.seed(1)
x1 <- runif(100)
x1

x2 <- 0.5 * x1 + rnorm(100)/10
y <- 2 + 2 * x1 + 0.3 * x2 + rnorm(100)

# 
lm_13 <- lm(x2 ~ x1)
plot(x1, x2)
abline(lm_13)

# y onto x1 and x2
lm_14 <- lm(y ~ x1 + x2)
summary(lm_14)
# y + 1.9778*x1 + 0.1140*x2 + 2.1506

# y onto x1
lm_15 <- lm(y ~ x1)
summary(lm_15)

# y onto x2
lm_16 <- lm(y ~ x2)
summary(lm_16)

x1 <- c(x1, 0.1)
x2 <- c(x2, 0.8)
y <- c(y, 6)

#  y onto x1 and x2
lm_17 <- lm(y ~ x1 + x2)
summary(lm_17)
outlierTest(lm_17)
plot(hatvalues(lm_17))

# y onto x1
lm_18 <- lm(y ~ x1)
summary(lm_18)
outlierTest(lm_18)
plot(hatvalues(lm_18))

# y onto x2
lm_19 <- lm(y ~ x2)
summary(lm_19)
outlierTest(lm_19)
plot(hatvalues(lm_19))

# 15
head(Boston)
scatterplotMatrix(Boston)

lm_20 <- lm(crim ~ ., Boston)
summary(lm_20)

