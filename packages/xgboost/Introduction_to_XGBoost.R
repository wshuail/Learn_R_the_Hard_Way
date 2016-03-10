# Introduction to XGBoost R package
# http://dmlc.ml/rstats/2016/03/08/xgboost.html

install.packages("drat", repos="https://cran.rstudio.com")
drat:::addRepo("dmlc")
install.packages("xgboost", repos="http://dmlc.ml/drat/", type = "source")

library(xgboost)

data(agaricus.train, package = 'xgboost')
data("agaricus.test", package = 'xgboost')

train <- agaricus.train
test <- agaricus.test

model <- xgboost(data = train$data, label = train$label,
                 nrounds = 2, objective = 'binary:logistic')
preds <- predict(model, test$data)

## Cross Validation
cv_model <- xgb.cv(data = train$data, label = train$label,
                   nfold = 2, nrounds = 2,
                   objective = 'binary:logistic')

## Cusomerized Objective
loglossobj <- function(preds, dtrain) {
    labels <- getinfo(dtrain, 'label')
    preds <- 1/(1 + exp(-preds))
    grad <- preds - labels
    hess <- preds * (1 - preds)
    return(list(grad = grad, hess = hess))
}

model <- xgboost(data = train$data, label = train$label,
                 nrounds = 2, objective = loglossobj,
                 eval_metric = 'error')

## Early Stopping

bst <- xgb.cv(data = train$data, label = train$label, nfold = 5,
              nrounds = 20, objective = 'binary:logistic',
              early.stop.round = 3, maximize = FALSE)


## Continue Training
dtrain <- xgb.DMatrix(train$data, label = train$label)
model <- xgboost(data = dtrain, nrounds = 2, 
                 objective = 'binary:logistic')
preds <- predict(model, dtrain, outputmargin = TRUE)
setinfo(dtrain, 'base_margin', preds)
model <- xgboost(data = dtrain, nrounds = 2, 
                 objective = 'binary:logistic')

## Handle Missing Values
dat <- matrix(rnorm(128), 64, 2)
labels <- sample(0: 1, nrow(dat), replace = T)
for (i in 1: nrow(dat)) {
    ind <- sample(2, 1)
    dat[i, ind] <- NA
}

model <- xgboost(data = dat, label = labels, missing = NA,
                 nrounds = 2, objective = 'binary:logistic')

## Model Inspection
bst <- xgboost(data = train$data, label = train$label,
               max.depth = 2, eta = 1, nthread = 2, 
               nrounds = 2, objective = 'binary:logistic')
xgb.plot.tree(feature_names = train$data@Dimnames[[2]],
              model = bst)

bst <- xgboost(data = train$data, label = train$label,
               max.depth = 2, eta = 1, nthread = 2, 
               nrounds = 10, objective = 'binary:logistic')
xgb.plot.tree(feature_names = train$data@Dimnames[[2]],
              model = bst)


bst <- xgboost(data = train$data, label = train$label,
               max.depth = 15, eta = 1, nthread = 2, 
               nrounds = 30, objective = 'binary:logistic',
               min_child_weight = 50)
xgb.plot.multi.trees(feature_names = train$data@Dimnames[[2]],
              model = bst, features.keep = 3)


## Feature Importance

bst <- xgboost(data = train$data, label = train$label,
               max.depth = 2, eta = 1, nthread = 2, 
               nrounds = 2, objective = 'binary:logistic')
importance_matrix <- xgb.importance(train$data@Dimnames[[2]],
                                    model = bst)
xgb.plot.importance(importance_matrix)

## Deepness
bst <- xgboost(data = train$data, label = train$label,
               max.depth = 15, eta = 1, nthread = 2, 
               nrounds = 30, objective = 'binary:logistic',
               min_child_weight = 50)
xgb.plot.deepness(model = bst)


