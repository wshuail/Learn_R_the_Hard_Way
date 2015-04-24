# chapter 9
# 9.6 Applied Lab: Support Vector Machines
library(e1071)

# 9.6.1 support vectors classifier
set.seed(1)
x <- matrix(rnorm(20*2), ncol = 2)
y <- c(rep(-1, 10), rep(1, 10))
x[y == 1, ] = x[y == 1, ] + 1

# check the linear condition
plot(x, col = (3 - y))

# fit the support vector classfifier
# encode the response to be the factor variable
df <- data.frame(x = x, y = as.factor(y))
df

svm <- svm(y ~ ., data = df, kernel = 'linear', cost = 10,
           scale = F)
svm
plot(svm, df)
names(svm)
svm$index
summary(svm)

# decrease the cost
svm_2 <- svm(y ~ ., data = df, kernel = 'linear', cost = 0.1,
           scale = F)
plot(svm_2, df)
summary(svm_2)
svm_2$index

# use the tune function for cross validation
set.seed(27)
tune <- tune(svm, y ~ ., data = df, kernel = 'linear',
             ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))
# an error occured, clean the workspace and restart the R
# according Machine Learning With R Cookbook
summary(tune)

# access the best method
best_model <- tune$best.model
summary(best_model)

# test the data by predict
set.seed(54)
xtest <- matrix(rnorm(20*2), ncol = 2)
ytest <- sample(c(-1, 1), 20, rep = T)
xtest[ytest == 1, ] = xtest[ytest == 1, ] + 1
df_test <- data.frame(x = xtest, y = as.factor(ytest))

predict <- predict(best_model, df_test)
table(predict, df_test$y)

# try cost = 0.01
svm_2 <- svm(y ~ ., data = df, kernel = 'linear', cost = 0.01,
             scale = T)
predict_2 <- predict(svm_2, df_test)
table(predict_2, df_test$y)

# consider anoth condition
x[y == 1, ] = x[y == 1, ] + 0.5
plot(x, col = (y + 5)/2, pch = 19)
df_3 <- data.frame(x = x, y = as.factor(y))
svm_3 <- svm(y ~ ., data = df_3, kernel = 'linear', cost = 1e5)
summary(svm_3)
plot(svm_3, df_3)

svm_4 <- svm(y ~ ., data = df_3, kernel = 'linear', cost = 1)
summary(svm_4)
plot(svm_4, df_3)

# 9.6.2 Support vector machine
# set the data
set.seed(26)
x = matrix(rnorm(200*2), ncol = 2)
x[1: 100, ] = x[1:100, ] + 2
x[101: 150, ] = x[101: 150, ] + 2
y <- c(rep(1, 150), rep(2, 50))
# specilize the 'y = ' 
df <- data.frame(x = x, y = as.factor(y))
df
plot(x, col = y)

# split the data
train <- sample(200, 100)
svm <- svm(y ~ ., data = df[train, ], kernel = 'radial',
           gamma = 1, cost = 1)
plot(svm, df[train, ])
summary(svm)

svm_2 <- svm(y ~ ., data = df[train, ], kernel = 'radial',
           gamma = 1, cost = 1e5)
summary(svm_2)
plot(svm_2, df[train, ])

# use tune to choose best model by cross validation

tune <- tune(svm, y ~ ., data = df[train, ], kernel = 'radial',
             ranges = list(cost = c(0.1, 1, 10, 100, 1000)),
             gamma = c(0.5, 1, 2, 3, 4))
summary(tune)

tune_pred <- predict(tune$best.model, df[-train, ])
table(tune_pred, df[-train, ]$y)

# 9.6.3 ROC curve
library(ROCR)

#  write a function
rocplot <- function(pred, truth, ...){
     predob <- prediction(pred, truth)
     pref <- performance(predob, 'tpr', 'fpr')
     plot(perf, ...)
}

svm_2 <- svm(y ~ ., data = df[train, ], kernel = 'radial',
             gamma = 1, cost = 1, decision.value = T)

predict_2 <- predict(svm_2, df[train, ], decision.values = T)
fit <- attributes(predict_2)$decision.values

# plot the ROC
par(mfrow = c(1, 2))
rocplot(fit, df[train, 'y'], main = 'Training Data')

# 9.6.4 SVM with multiple classes
set.seed(654)
x <- rbind(x, matrix(rnorm(50*2), ncol = 2))
y <- c(y, rep(0, 50))
x[y == 0, 2] = x[y == 0, 2] + 2
df <- data.frame(x = x, y = as.factor(y))
df
plot(x, col = (y + 1))

svm_3 <- svm(y ~ ., data = df, kernel = 'radial', cost = 10, 
             gamma = 1)
summary(svm_3)
plot(svm_3, df)


# 9.6.5 Application to gene expression data
library(ISLR)
names(Khan)
head(Khan)

str(Khan$xtrain)
str(Khan$xtest)
str(Khan$ytrain)
str(Khan$ytest)
df_gene <- data.frame(x = Khan$xtrain, y = as.factor(Khan$ytrain))
svm_gene <- svm(y ~ ., df_gene, kernel = 'linear', cost = 10)
summary(svm_gene)
table(svm_gene$fitted, df_gene$y)

# predict the result on test data
df_gene_test <- data.frame(x = Khan$xtest, 
                           y = as.factor(Khan$ytest))
gene_pred <- predict(svm_gene, newdata = df_gene_test)
table(gene_pred, df_gene_test$y)

