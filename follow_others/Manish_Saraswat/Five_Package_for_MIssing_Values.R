
# http://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/
# Tutorial on 5 Powerful R Packages used for imputing missing values

# First Package: MICE --------------
install.packages('mice')
library(mice)
install.packages('missForest')
library(missForest)

data <- iris
summary(data)

# Generate 10% of missing values
iris_mis <- prodNA(data, noNA = 0.1)
summary(iris_mis)
md.pattern(iris_mis)

imputed_iris <- mice(iris_mis, m = 5, maxit = 50, method = 'pmm',
                     seed = 500)
summary(imputed_iris)
imputed_iris$imp$Sepal.Length

complte_data <- complete(imputed_iris, 2)

fit <- with(data = iris_mis, 
            exp = lm(Sepal.Width ~ Sepal.Length + Petal.Width))
combine <- pool(fit)


# Package 2: Amelia --------------------
install.packages('Amelia')
library(Amelia)

amelia_fit <- amelia(iris_mis, m = 5, parallel = 'multicore',
                     noms = 'Species')
amelia_fit$imputations[[1]]
amelia_fit$imputations[[2]]
amelia_fit$imputations[[3]]
amelia_fit$imputations[[4]]
amelia_fit$imputations[[5]]

amelia_fit$imputations[[5]]$Sepal.Length

write.amelia(amelia_fit, file.stem = 'imputed_data_iris')


# Package 3: missForest
iris_imp <- missForest(iris_mis)
# check imputed values
iris_imp$ximp
# check imputed error
iris_imp$OOBerror

# NRMSE is normalized mean squared error. It is used to represent error derived from imputing continuous values. 
# PFC (proportion of falsely classified) is used to represent error derived from imputing categorical values.

# comparing actual data accuracy
iris_error <- mixError(iris_imp$ximp, iris_mis, iris)
iris_error


# Package 3: Hmisc
install.packages('Hmisc')
library(Hmisc)
iris_mis$imputed_age <- with(iris_mis, impute(Sepal.Width, mean))
iris_mis$imputed_age_2 <- with(iris_mis, impute(Sepal.Width, 'random'))

impute_arg <- aregImpute(~ Sepal.Length + Sepal.Width + Petal.Length
                         + Petal.Width + Species, data = iris_mis,
                         n.impute = 5)
impute_arg

# check imputed values
impute_arg$imputed$Sepal.Length


# Package 5: mi --------------------

install.packages('mi')
library(mi)
iris_mi <- mi(iris_mis, seed = 235)
summary(iris_mi)







