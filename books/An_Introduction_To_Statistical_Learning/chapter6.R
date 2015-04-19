# chapter6 
# Applied 6.5 
# Subseting method
# 6.5.1 Best Subset Selection
library(ISLR)
head(Hitters)

sum(is.na(Hitters))
hitters <- na.omit(Hitters)
str(hitters)

install.packages('leaps')
library(leaps)
regfit_full <- regsubsets(Salary ~ ., hitters)
summary(regfit_full)

regfit_full_2 <- regsubsets(Salary ~ ., hitters, nvmax = 19)
reg_summary_2 <- summary(regfit_full_2)
names(reg_summary_2)
reg_summary_2$rsq
reg_summary_2$rss
reg_summary_2$cp

par(mfrow = c(2, 2))
plot(reg_summary_2$rss, type = 'b')
plot(reg_summary_2$adjr2, type = 'b')

which.max(reg_summary_2$adjr2)
points(11, reg_summary_2$adjr2[11], col = 'red',
       cex = 2, pch = 20)

plot(reg_summary_2$cp, type = 'b')
which.min(reg_summary_2$cp)
points(10, reg_summary_2$adjr2[10], col = 'red',
       cex = 2, pch = 20)

plot(regfit_full_2, scale = 'r2')
plot(regfit_full_2, scale = 'adjr2')
plot(regfit_full_2, scale = 'Cp')
plot(regfit_full_2, scale = 'bic')

coef(regfit_full_2, 6)

# 6.5.2 Forward and backward stepwise selection

regfit_forward <- regsubsets(Salary ~ ., hitters, nvmax = 19,
                             method = 'forward')
summary(regfit_forward)

regfit_backward <- regsubsets(Salary ~ ., hitters, nvmax = 19,
                              method = 'backward')
summary(regfit_backward)

coef(regfit_full_2, 7)
coef(regfit_forward, 7)
coef(regfit_forward, 7)

# Choosing among models using the validation set approach and
# Cross-validation

set.seed(1)
train <- sample(c(TRUE, FALSE), nrow(hitters), rep = T)
test <- (!train)

regfit_best <- regsubsets(Salary ~ ., data = hitters[train, ],
                          nvmax = 19)

test_matrix <- model.matrix(Salary ~ ., data = hitters[test, ])

val_error <- c()
for (i in 1:19){
     coefi <- coef(regfit_best, id = i)
     pred <- test_matrix[ , names(coefi)] %*% coefi
     val_error[i] <- mean((hitters$Salary[test] - pred)^2)
}
val_error
which.min(val_error)
coef(regfit_best, 10)

predict_regsubsets <- function(object, newdata, id, ...){
     form <- as.formula(object$call[[2]])
     matrix <- model.matrix(form, newdata)
     coefi <- coef(object, id = id)
     xvars <- names(coefi)
     matrix[, xvars] %*% coefi
}


regfit_best_2 <- regsubsets(Salary ~ ., data = hitters, 
                            nvmax = 19)
coef(regfit_best_2, 10)

k = 10
set.seed(2)
folds <- sample(1: k, nrow(hitters), replace = T)
folds[1:30]
cv_errors <- matrix(NA, k, 19,
                    dimnames = list(NULL, paste(1: 19)))

for (i in 1:k){
     best_fit <- regsubsets(Salary ~ ., 
                            data = hitters[folds != j, ],
                            nvmax = 19)
     for (i in 1:19){
          pred <- predict_regsubsets(best_fit, 
                                     hitters[folds == j, ],
                                     id = i)
          cv_errors[j, i] <- mean((hitters$Salary[folds == j] - pred)^2)
     }
}

cv_errors

# Lab 2: Ridge Regression and the Lasso
install.packages('glmnet')
library(glmnet)

x <- model.matrix(Salary ~ ., hitters)[, -1]
y <- hitters$Salary

# 6.6.1 Ridge Regression
# alpha = 0 means ridge regression
# alpha = 1 means lasso

grid <- 10^seq(10, -2, length = 100)
grid
ridge_model <- glmnet(x, y, alpha = 0, lambda = grid)
dim(coef(ridge_model))

ridge_model$lambda[50]
coef(ridge_model)[, 50]
sqrt(sum(coef(ridge_model)[-1, 50]^2))


ridge_model$lambda[60]
coef(ridge_model)[, 60]
sqrt(sum(coef(ridge_model)[-1, 60]^2))

predict(ridge_model, s = 50, type = 'coefficients')[1:20, ]

set.seed(14)
train <- sample(1: nrow(x), nrow(x)/2)
test <- (-train)
y_test <- y[test]

ridge_model_2 <- glmnet(x[train, ], y[train], alpha = 0, 
                        lambda = grid, thresh = 1e-12)
ridge_2_pred <- predict(ridge_model_2, s = 4, newx = x[test, 1])
?predict


# 6.6.2 The Lasso
lasso_model <- glmnet(x[train, ], y[train], alpha = 1)
plot(lasso_model)

set.seed(7283)
cv_out <- cv.glmnet(x[train, ], y[train], alpha = 1)
plot(cv_out)

bestlam <- cv_out$lambda.min
bestlam

lasso_pred <- predict(lasso_model, s = bestlam, newx = x[test, ])
mean((lasso_pred - y_test)^2)

out <- glmnet(x, y, alpha = 1, lambda = grid)
lasso_coef <- predict(out, type = 'coefficients',
                      s = bestlam)[1:20, ]
lasso_coef
lasso_coef[lasso_coef != 0]

# 6.7 Lab 3
# PCR and PLS Regression
# 6.7.1 Principal Components Regression
install.packages('pls')
library(pls)
set.seed(2635)
pcr <- pcr(Salary ~ ., data = hitters, scale = T,
           validation = 'CV')
summary(pcr)

validationplot(pcr, val.type = 'MSEP')

set.seed(63)
pcr_2 <- pcr(Salary ~ ., data = hitters, subset = train,
             scale = T, validation = 'CV')
validationplot(pcr_2, vil.type = 'MSEP')

pcr_pred <- predict(pcr_2, x[test, ], ncomp = 7)
mean((pcr_pred - y_test)^2)

pcr_3 <- pcr(y ~ x, scale = T, ncomp = 7)
summary(pcr_3)

# 6.7.2 Partial Least Squares

set.seed(367)
pls <- plsr(Salary ~ ., data = hitters, subset = train,
            scale = T, validation = 'CV')
summary(pls)

validationplot(pls, val.type = 'MSEP')

pls_pred <- predict(pls, x[test, ], ncomp = 2)
mean((pls_pred - y_test)^2)

pls_full <- plsr(Salary ~., data = hitters, scale = T,
                 ncomp = 2)
summary(pls_full




