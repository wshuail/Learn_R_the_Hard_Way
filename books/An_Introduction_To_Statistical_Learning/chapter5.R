# chapter 5
# 5.3 Applied: Cross-Validation and the Bootstrap

# 5.3.1 The validation set approach

library(ISLR)
set.seed(1733)
dim(Auto)
train <- sample(392, 196)
length(train)
lm_1 <- lm(mpg ~ horsepower, data = Auto, subset = train)
lm_prob <- predict(lm_1, Auto)

mean_1 <- mean((Auto$mpg - lm_prob)[-train]^2)

lm_2 <- lm(mpg ~ poly(horsepower, 2), data = Auto, subset = train)
lm_2_prob <- predict(lm_2, Auto)
mean_2 <- mean((Auto$mpg - lm_2_prob)[-train]^2)
mean_2

lm_3 <- lm(mpg ~ poly(horsepower, 3), data = Auto, subset = train)
lm_3_prob <- predict(lm_3, Auto)
mean_3 <- mean((Auto$mpg - lm_3_prob)[-train]^2)
mean_3

# 5.3.2 Leave-One-Out Cross-Validation

glm_1 <- glm(mpg ~ horsepower, data = Auto)
coef(glm_1)

lm_1 <- lm(mpg ~ horsepower, data = Auto)
coef(lm_1)

library(boot)
cv_err <- cv.glm(Auto, glm_1)
summary(cv_err)
cv_err$call
cv_err$K
cv_err$delta
cv_err$seed

cv_error <- 1:5

cv_error <- c()
for (i in 1:10){
     glm <- glm(mpg ~ poly(horsepower, i), data = Auto)
     cv_error[i] <- cv.glm(Auto, glm)$delta[1]
}
cv_error

# K-fold cross-validation
set.seed(11)
cv_error_k10 <- c()
for (i in 1:10){
     glm <- glm(mpg ~ poly(horsepower, i), data = Auto)
     cv_error_k10[i] <- cv.glm(Auto, glm, K = 10)$delta[1]
}
cv_error_k10

# The Bootstrap
# Estimating the accuracy of a statistic of interest

alpha <- function(data, index){
     X = data$X[index]
     Y = data$Y[index]
     return ((var(Y) - cov(X, Y))/(var(X) + var(Y) - 2*cov(X, Y)))
}

head(Portfolio)
dim(Portfolio)
alpha(Portfolio, 1:100)

set.seed(12)
index <- sample(100, 100, replace = T)
alpha(Portfolio, index)

boot(Portfolio, alpha, R = 1000)

# Estimiting the Accuracy of a linear regression model

boot_fun <- function(data, index){
     return (coef(lm(mpg ~ horsepower, data = data, subset = index)))
}
boot_fun(Auto, 1:392)

set.seed(13)
boot_fun(Auto, sample(392, 392, replace = T))
boot_fun(Auto, sample(392, 392, replace = T))
boot(Auto, boot_fun, 1000)

summary(lm(mpg ~ horsepower, Auto))$coef

boot_func <- function(data, index){
     return (coefficients(lm(mpg ~ poly(horsepower, 2),
                             data = data, subset = index)))
}

set.seed(13)
boot(Auto, boot_func, 1000)

summary(lm(mpg ~ poly(horsepower, 2), Auto))$coef

# Applied
# 5
library(ISLR)
head(Default)
str(Default)
set.seed(15)
glm <- glm(default ~ balance + income, data = Default,
           family = binomial)
glm_prob <- predict(glm, Default)
glm_pred <- rep('No', 10000)
glm_pred[glm_prob >= 0.5] <- 'Yes'
table(glm_pred, Default$default)
(9648 + 75)/10000
75/(75 + 19)

set.seed(17)
train_1 <- sample(10000, 5000)
train_data = Default[train_1, ]
str(train_data)
glm_train_1 <- glm(default ~ balance + income, 
                  data = Default,
                  family = binomial,
                  subset = train)
glm_1_prob <- predict(glm_train_1, Default[-train_1, ])
length(glm_1_prob)
contrasts(Default$default)
glm_1_pred <- rep('No', 5000)
glm_1_pred[lm_1_prob >= 0.5] = 'Yes'
table(glm_1_pred, Default[-train_1, ]$default)
(4814 + 69)/5000
69/(27 + 69)

set.seed(18)
train_2 <- sample(10000, 7000)
train_data_2 = Default[train_2, ]
str(train_data_2)
glm_train_2 <- glm(default ~ balance + income, 
                   data = Default,
                   family = binomial,
                   subset = train_2)
glm_2_prob <- predict(glm_train_2, Default[-train_2, ])
length(glm_2_prob)
contrasts(Default$default)
glm_2_pred <- rep('No', 3000)
glm_2_pred[glm_2_prob >= 0.5] = 'Yes'
table(glm_2_pred, Default[-train_2, ]$default)
(2897 + 22)/3000
22/28

set.seed(19)
train_3 <- sample(10000, 9000)
train_data_3 = Default[train_3, ]
str(train_data_3)
glm_train_3 <- glm(default ~ balance + income, 
                   data = Default,
                   family = binomial,
                   subset = train_3)
glm_3_prob <- predict(glm_train_3, Default[-train_3, ])
length(glm_3_prob)
contrasts(Default$default)
glm_3_pred <- rep('No', 1000)
glm_3_pred[glm_3_prob >= 0.5] = 'Yes'
table(glm_3_pred, Default[-train_3, ]$default)
(967 + 5)/1000
5/7

# 6
# multiple logical regression function
glm <- glm(default ~ balance + income, data = Default,
           family = binomial)
summary(glm)
# intercept: 4.34e-01
# banlance: 2.27e-04
# income: 4.99e-06

# bootstrap model
boot_fun <- function(data, index){
     return (coef(glm(default ~ balance + income, 
                      data = data,
                      family = binomial,
                      subset = index)))
}
boot_fun(Default, 1: nrow(Default))
# intercept: -1.16e+01
# balance: 5.65e-03
# income: 2.08e-05

set.seed(20)
boot_fun(Default, sample(1000, 1000, replace = T))
set.seed(21)
boot_fun(Default, sample(1000, 1000, replace = T))
set.seed(22)
boot_fun(Default, sample(1000, 1000, replace = T))

# boot function
library(boot)
boot(Default, boot_fun, 1000)
# intercept: 4.52e-01
# balance: 2.37e-04
# income: 4.96e-06

# glm is better ????

data(Weekly)
head(Weekly)

glm_1 <- glm(Direction ~ Lag1 + Lag2, data = Weekly,
             family = binomial)
coef(glm_1)

str(Weekly)
glm_2 <- glm(Direction ~ Lag1 + Lag2, data = Weekly[2: 1089,],
             family = binomial)
coef(glm_2)

glm_2_prob <- predict(glm_2, Weekly[1, ])
glm_2_prob

if (glm_2_prob > 0.5) print ('1')

glm_2_pred <- c('Down')
glm_2_pred[glm_2_prob >= 0.5] <- 'Up'
glm_2_pred
table(glm_2_pred, Weekly[1, ]$Direction)


cv_error <- c()
for (i in 1098){
     glm <- glm(Direction ~ Lag1 + Lag2, data = Weekly[-i, ],
                family = binomial)
     glm_prob <- predict(glm, Weekly[i, ])
     if (glm_prob > 0.5){
          cv_error <- c(cv_error, 1)
     } else{
          cv_error <- c(cv_error, 0)
     }
     return (cv_error)
}


# 8
set.seed(31)
y <- rnorm(100)
x <- rnorm(100)
z <- x - 2*x^2 + rnorm(100)

library(ggplot2)
qplot(x, y)

df <- data.frame(x, y)

cv_error <- c()
for (i in 1:4){
     glm <- glm(y ~ poly(x, i), data = df)
     cv_error[i] <- cv.glm(df, glm)$delta[1]
}
cv_error


set.seed(33)
y <- rnorm(100)
x <- rnorm(100)
z <- x - 2*x^2 + rnorm(100)

df <- data.frame(x, y)

cv_error <- c()
for (i in 1:4){
     glm <- glm(y ~ poly(x, i), data = df)
     cv_error[i] <- cv.glm(df, glm)$delta[1]
}
cv_error








