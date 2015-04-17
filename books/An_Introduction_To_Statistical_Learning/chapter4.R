# chapter 4
# 4.6 Lab: Logistic Regression, LDA, QDA and KNN

# 4.6.1 The stock market data
library(ISLR)
head(Smarket)
summary(Smarket)

pairs(Smarket)
cor(Smarket[, -9])

plot(Smarket$Volume)

# 4.6.2 Logistic Regression
# The glm() function returns a generalized linear model
glm_1 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
                  Volume, data = Smarket, family = binomial)
summary(glm_1)
names(glm_1)
summary(glm_1$coef)

coef(glm_1)

contrasts(Smarket$Direction)
glm_2 <- predict(glm_1, type = 'response')
glm_2[1:10]

glm_3 <- rep('Down', 1250)
glm_3[glm_2 > 0.5] = 'Up'
glm_3[1:10]

table(glm_3, Smarket$Direction)
(145 + 507)/1250
mean(glm_3 == Smarket$Direction)

train <- (Smarket$Year < 2005)
class(train)
length(train)
Smarket_2005 <- Smarket[!train, ]

Direction_2005 <- Smarket$Direction[!train]
length(Direction_2005)

glm_4 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
                  Volume, data = Smarket, family = binomial,
             subset = train)
glm_5 <- predict(glm_4, Smarket_2005, type = 'response')
length(glm_5)
dim(Smarket_2005)

glm_6 <- rep('Down', 252)
length(glm_6)
glm_6[glm_5 > 0.5] = 'Up'
table(glm_6, Direction_2005)

mean(glm_6 == Direction_2005)
mean(glm_6 != Direction_2005)

glm_7 <- glm(Direction ~ Lag1 + Lag2, data = Smarket, 
             family = binomial, subset = train)
glm_7_pre <- predict(glm_7, Smarket_2005, type = 'response')
glm_7_re <- rep('Down', 252)
glm_7_re[glm_7_pre > 0.5] = 'Up'
glm_7_re
Direction_2005
table(glm_7_re, Direction_2005)

mean(glm_7_re == Direction_2005)

glm_7_set <- predict(glm_7, 
                     newdata = data.frame(Lag1 = c(1.2, 1.5),
                                          Lag2 = c(1.1, 0.8)),
                     type = 'response')

# 4.6.3 Linear Discriminant Analysis
library(MASS)

lda <- lda(Direction ~ Lag1 + Lag2, data = Smarket, 
           subset = train)
lda

plot(lda)
lda_pred <- predict(lda, Smarket_2005)
names(lda_pred)

lda_class <- lda_pred$class
lda_pred$posterior
lda_pred$x

table(lda_class, Direction_2005)
mean(lda_class == Direction_2005)

sum(lda_pred$posterior[, 1] >= 0.5)
sum(lda_pred$posterior[, 1] < 0.5)

lda_pred$posterior[1:20, 1]
lda_class[1:20]


# 4.6.4 Quadratic Discriminant Analysis

qda <- qda(Direction ~ Lag1 + Lag2, data = Smarket, 
           subset = train)
qda

qda_pred <- predict(qda, Smarket_2005)
names(qda_pred)

table(qda_pred$class, Direction_2005)

mean(qda_pred$class == Direction_2005)

# K-Nearest Neighbors
library(class)
train.X <- cbind(Smarket$Lag1, Smarket$Lag2)[train, ]
test.X <- cbind(Smarket$Lag1, Smarket$Lag2)[!train, ]
train.Direction <- Smarket$Direction[train]
set.seed(1234)

class(train.X)

# K=1
knn_pred <- knn(train.X, test.X, train.Direction, k = 1)
table(knn_pred, Direction_2005)

mean(knn_pred == Direction_2005)

# K=3
knn_pred_k3 <- knn(train.X, test.X, train.Direction, k = 3)
table(knn_pred_k3, Direction_2005)

mean(knn_pred_k3 == Direction_2005)

# K=5
knn_pred_k5 <- knn(train.X, test.X, train.Direction, k = 5)
table(knn_pred_k5, Direction_2005)
mean(knn_pred_k5 == Direction_2005)

# 4.6.6 An application to caravan insurance data
head(Caravan)
summary(Caravan$Purchase)

# scale function
standardized.X = scale(Caravan[, -86])
var(Caravan[, 1])
var(Caravan[, 2])
var(standardized.X[, 1])
var(standardized.X[, 2])

# split the data
test <- 1:1000
train.X <- standardized.X[-test, ]
test.X <- standardized.X[test, ]
train.Y <- Caravan$Purchase[-test]
test.Y <- Caravan$Purchase[test]

set.seed(273)
knn_pred <- knn(train.X, test.X, train.Y, k = 1)
table(knn_pred, test.Y)
mean(knn_pred == test.Y)
mean(test.Y != 'No')
# only the people who may purchase are concerned
9/(68 + 9)

# K = 3
knn_pred_k3 <- knn(train.X, test.X, train.Y, k = 3)
table(knn_pred_k3, test.Y)
5/(20 + 5)

# K = 5
knn_pred_k5 <- knn(train.X, test.X, train.Y, k = 5)
table(knn_pred_k5, test.Y)
4/(11 + 4)

# k = 7
knn_pred_k7 <- knn(train.X, test.X, train.Y, k = 7)
table(knn_pred_k7, test.Y)
2/(5 + 2)


glm <- glm(Purchase ~ ., data = Caravan, family = binomial,
           subset = -test)

glm_prob <- predict(glm, Caravan[test, ], type = 'response')
glm_pred <- rep('No', 1000)
glm_pred[glm_prob > 0.5] = 'Yes'
table(glm_pred, test.Y)

glm_pred_2 <- rep('No', 1000)
glm_pred_2[glm_prob > 0.25] = 'Yes'
table(glm_pred_2, test.Y)
11/(22 + 11)

# Applied
# 10
# (a)

library(ISLR)
head(Weekly)
str(Weekly)

weekly <- Weekly[, -9]
library(car)
scatterplotMatrix(weekly)
cor(weekly)
plot(weekly$Volume)

# (b)
glm_1 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5
             + Volume, data = Weekly, family = 'binomial')
summary(glm_1)

glm_prob <- predict(glm_1, type = 'response')
glm_prob[1: 10]
contrasts(Weekly$Direction)

glm_pred <- rep('Down', 1089)
glm_pred[glm_prob > 0.5] = 'Up'
table(glm_pred, Weekly$Direction)

(54 + 557)/(1089)

# (d)
train <- (weekly$Year <= 2008)
weekly_train <- Weekly[train, ]
weekly_test <- Weekly[!train, ]
dim(weekly_train)
head(weekly_train)

dim(weekly_test)
head(weekly_test)

glm_2 <- glm(Direction ~ Lag2, data = weekly_train,
             family = 'binomial')
summary(glm_2)

glm_2_prob <- predict(glm_2, weekly_test, type = 'response')
length(glm_2_prob)
glm_2_prob

glm_2_pred <- rep('Down', 104)
glm_2_pred[glm_2_prob >= 0.5] = 'Up'
table(glm_2_pred, weekly_test$Direction)
61/(43 + 61)

# (e)
library(MASS)
lda <- lda(Direction ~ Lag2, data = weekly_train, subset = train)
lda
plot(lda)

lda_prob <- predict(lda, weekly_test)
names(lda_prob)
lda_prob$class

table(lda_prob$class, weekly_test$Direction)
(9 + 56)/104

# quadratic discriminant analysis
qda <- qda(Direction ~ Lag2, data = weekly_train,
           subset = train)
qda

qda_prob <- predict(qda, weekly_test)
table(qda_prob$class, weekly_test$Direction)
(61)/104

# K-Nearest Neighbors

train.X <- cbind(Weekly$Lag2)[train, ]
train.X <- as.matrix(train.X)
class(train.X)

test.X <- cbind(Weekly$Lag2)[!train, ]
test.X <- as.matrix(test.X)

train.Direction <- Weekly$Direction[train]
test.Direction <- Weekly$Direction[!train]

library(class)
set.seed(123)
knn <- knn(train.X, test.X, train.Direction, k = 1)
table(knn, test.Direction)
(21 + 32)/104

knn_3 <- knn(train.X, test.X, train.Direction, k = 3)
table(knn_3, test.Direction)
(16 + 41)/104

knn_5 <- knn(train.X, test.X, train.Direction, k = 5)
table(knn_5, test.Direction)
(15 + 41)/104
