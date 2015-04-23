# chapter 8
# 8.3 Applied Decision Tree
# 8.3.1 Fitting Classfication trees
library(tree)
carseats <- Carseats
high <- ifelse(carseats$Sales <= 8, 'No', 'Yes')
head(carseats)
carseats <- data.frame(carseats, high)

# tree function
tree <- tree(high ~ . - Sales, carseats)
summary(tree)
plot(tree)
text(tree, pretty = 0)
tree

# test error
# split the data
set.seed(138)
train <- sample(1:nrow(carseats), 200)
carseats_train <- carseats[train, ]
carseats_test <- carseats[-train, ]
high_test <- high[-train]

# test
tree_2 <- tree(high ~ . -Sales, data = carseats, subset = train)
tree_pred <- predict(tree_2, carseats_test, type = 'class')
table(tree_pred, high_test)
(90 + 60)/200

# cross validation
set.seed(135)
cv_tree <- cv.tree(tree_2, FUN = prune.misclass)
names(cv_tree)
cv_tree
# dev means the cv error rate

# plot the error rate
par(mfrow = c(1, 2))
plot(cv_tree$size, cv_tree$dev, type = 'b')
plot(cv_tree$k, cv_tree$dev, type = 'b')

# obtain the nine-nodes tree by prune.misclass() function
prune <- prune.misclass(tree_2, best = 9)
plot(prune)
text(prune, pretty = 0)

# how well does this function perform
tree_pred_2 <- predict(prune, carseats_test, type = 'class')
table(tree_pred_2, high_test)
(86 + 63)/200

# increase the values of the best
prune_2 <- prune.misclass(tree_2, best = 15)
plot(prune_2)
text(prune_2, pretty = 0)

tree_pred_3 <- predict(prune, carseats_test, type = 'class')
table(tree_pred_3, high_test)
(86 + 63)/200

# 8.3.2 Fitting Regression Trees

# load the Boston data set
library(MASS)
set.seed(536)
train <- sample(1: nrow(Boston), nrow(Boston)/2)

tree_boston <- tree(medv ~ ., Boston, subset = train)
summary(tree_boston)

# plot the tree
plot(tree_boston)
text(tree_boston, pretty = 0)

# cross validation error
cv_tree_boston <- cv.tree(tree_boston)
cv_tree_boston
par(mfrow = c(1, 2))
plot(cv_tree_boston$size, cv_tree_boston$dev, type = 'b')
plot(cv_tree_boston$k, cv_tree_boston$dev, type = 'b')

# prune the tree
prune_boston <- prune.tree(tree_boston, best = 5)
plot(prune_boston)
text(prune_boston, best = 0)

# make predication
boston_pred <- predict(tree_boston, newdata = Boston[-train, ])
boston_test <- Boston$medv[-train]
plot(boston_pred, boston_test)
abline(0, 1)
mean((boston_pred - boston_test)^2)

# Bagging and Random Forest
library(randomForest)

# bagging
set.seed(26)
bag_boston <- randomForest(medv ~ ., data = Boston, 
                           subset = train, mtry = 13,
                           importance = T)
bag_boston

# Evaludate the performance
bag_pred <- predict(bag_boston, Boston[-train, ])
plot(bag_pred, Boston$medv[-train])
abline(0, 1)
mean((bag_pred - Boston$medv[-train])^2)

# change the number of the tree grown
bag_boston_2 <- randomForest(medv ~ ., data = Boston, subset = train,
                           mtry = 13, ntree = 25)
bag_pred_2 <- predict(bag_boston_2, newdata = Boston[-train, ])
bag_boston_2
mean((bag_pred_2 - Boston$medv[-train])^2)

# forest random method
set.seed(675)
forest_boston <- randomForest(medv ~ ., data = Boston, 
                              subset = train, mtry = 6,
                              importance = T)
forest_boston_pred <- predict(forest_boston, 
                              newdata = Boston[-train, ])
mean((forest_boston_pred - Boston$medv[-train])^2)

# use importance function to view the importance of each varibale
importance(forest_boston)
# plot
varImpPlot(forest_boston)

# 8.3.4 Boosting
library(gbm)
set.seed(7654)
boost_boston <- gbm(medv ~ ., data = Boston[train, ],
                    distribution = 'gaussian', 
                    n.trees = 5000, interaction.depth = 4)
boost_boston
summary(boost_boston)
par(mfrow = c(1, 2))
plot(boost_boston, i = 'rm')
plot(boost_boston, i = 'lstat')

# to predict the test data set
boost_boston_pred <- predict(boost_boston, Boston[-train, ],
                             n.trees = 5000)
mean((boost_boston_pred - Boston$medv[-train])^2)

# change the value of lambda
boost_boston_2 <- gbm(medv ~ ., data = Boston[train, ],
                    distribution = 'gaussian', 
                    n.trees = 5000, interaction.depth = 4,
                    shrinkage = 0.2, verbose = F)
boost_boston_pred_2 <- predict(boost_boston_2, Boston[-train, ],
                             n.trees = 5000)
mean((boost_boston_pred_2 - Boston$medv[-train])^2)






