# chapter 8

# 8.2.1 fittinng regression models with lm()

# myfit <- lm(foumula, data)
# formula: y ~ x1 + x2 + x3 + ... + xk

# 8.2.2 simle linear regression

fit <- lm(weight ~ height, data = women)
summary(fit)
women$weight
fitted(fit)
residuals(fit)

attach(women)
plot(women$height, women$weight,
     xlab = 'Height (in inches)',
     ylab = 'Weight(in pounds)')
detach(women)
abline(fit)

# polynominal regression

fit2 <- lm(weight ~ height + I(height^2), data = women)
summary(fit2)

plot(women$height, women$weight,
     xlab = 'Height (in inches)',
     ylab = 'Weight(in pounds)')
lines(women$height, fitted(fit2))
?lines

fit3 <- lm(weight ~ height + I(height^2) + I(height^3), 
           data = women)

summary(fit3)
plot(women$height, women$weight,
     xlab = 'Height (in inches)',
     ylab = 'Weight(in pounds)')
lines(women$height, fitted(fit3))


?install.packages
install.packages('car', dependencies = T)
library(car)

scatterplot(weight ~ height,
            data = women,
            spread = F,
            lty = 2,
            pch = 19,
            main = 'Women Age 30-39',
            xlab = 'Height (in inches)',
            ylab = 'Weight (in pounds)')


# 8.2.4 multiple linear regression


states <- as.data.frame(state.x77[, c('Murder', 'Population',
                                      'Illiteracy', 'Income',
                                      'Frost')])

head(states)

cor(states)

library(car)
scatterplotMatrix(states, spread = F,
                  lty = 2,
                  main = 'Scatter plot matrix')

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost,
          data = states)

summary(fit)

# 8.2.5 multiple linear regression with interaction

fit5 <- lm(mpg ~ hp + wt + hp:wt,
           data = mtcars)
summary(fit5)

install.packages('effects')

library(effects)

# plot(effect(term, mod, xlevels), multiline = TRUE)

effect_1 <- effect('hp:wt', fit5)
plot(effect_1)

effect_2 <- effect('hp:wt', fit5, xlevels = list(wt = c(2.2, 3.2, 4.2)))
plot(effect_2, multiline = T)

plot(effect('hp:wt', 
            fit5, 
            xlevels = list(wt = c(2.2, 3.2, 4.2))), 
     multiline = TRUE)

?effect


# 8.3 Regression diagnostics

fit6 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
           data = states)

summary(fit6)
confint(fit6)

# 8.3.1 A typical approach

fit7 <- lm(weight ~ height, data = women)
par(mfrow= c(2, 2))
plot(fit7)
crPlots(fit7)

fit8 <- lm(weight ~ height + I(height^2), data = women)
par(mfrow = c(2,2))
plot(fit8)
crPlots(fit8)


# delete point 13 and 15
fit9 <- lm(weight ~ height + I(height^2), 
           data = women[-c(13, 15), ])
par(mfrow = c(2,2))
plot(fit9)

# apply to the states dataset

fit10 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
            data = states)
par(mfrow = c(2,2))
plot(fit10)

# 8.3.2 An enhanced approach

library(car)
fit11 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
            data = states)
qqPlot(fit11, id.method = 'identify')

qqPlot(fit11, labels = row.names(states), 
       id.method = 'identify',
       simulate = TRUE,
       main = 'QQ plot')

states['Nevada', ]
fitted(fit11)['Nevada']
residuals(fit11)['Nevada']
rstudent(fit11)['Nevada']

# residplot function

r_fit11 <- rstudent(fit11)
r_fit11
hist(r_fit11)

residplot <- function(fit, nbreaks = 10){
     z <- rstudent(fit)
     par(mai = c(2, 2, 2, 2))
     hist(z, 
          breaks = nbreaks, 
          freq = F,
          xlab = 'Studentized Residual',
          main = 'Distribution of Errors')
     rug(jitter(z), col = 'brown')
     curve(dnorm(x, mean = mean(z),
                 sd = sd(z)),
           add = TRUE, col = 'blue',
           lwd = 2)
     lines(density(z)$x, 
           density(z)$y,
           col = 'red',
           lwd = 2,
           lty = 2)
     legend('topright', 
            legend = c('Normal Curve',
                       'Kernal DEsity Curve'),
            lty = 1:2,
            col = c('blue', 'red'),
            cex = 0.7)
     
}
residplot(fit11)

# Inderpendence of error

durbinWatsonTest(fit11)

# Linearity
crPlots(fit11)

# Homoscedasticity
ncvTest(fit11)

ncvTest(fit8)

spreadLevelPlot(fit11)

# Global validation of linear model assumption

install.packages('gvlma')

library(gvlma)
gvmodel <- gvlma(fit11)
summary(gvmodel)

# 8.3.4 Multicollinearity

vif(fit11)
sqrt(vif(fit11)) > 2

# 8.4 Unusual observation

# 8.4.1 outliers

outlierTest(fit11)

# 8.4.2 High leverage points

plot(hatvalues(fit11))

hat.plot <- function(x){
     p <- length(coefficients(x))
     n <- length(fitted(x))
     plot(hatvalues(x),
          main = 'Index Plot of Hat Value')
     abline(h = c(2, 3)*p/n,
            col = 'red',
            lty = 2)
     identify(1: n, hatvalues(x), names(hatvalues(x)))
}
hat.plot(fit)

# 8.4.3 influential observation

fit11$coefficients

cutoff <- 4/(nrow(states) - length(fit11$coefficients) - 2)
plot(fit11, which = 4, cook.values = cutoff)
abline(h = cutoff, lty = 2, col = 'red')

# added variable plot
avPlots(fit11, ask = F, onepage = T, id.method = 'identify')

influencePlot(fit11, id.method = 'identify',
              main = 'Influence Plot',
              sub = 'Circle size is proportional to Cook\'s distance')


# 8.5 correcttive measures

# 8.5.1 Deleting observations

# 8.5.2 transformaing variables

summary(powerTransform(states$Murder))

boxTidwell(Murder ~ Population + Illiteracy, data = states)

# 8.5.3 Adding or deleting variables

# 8.5.4 Trying a different approach



# 8.6 Selecting the 'Best' regression model

# 8.6.1 comparing medels

fit12 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
            data = states)
fit13 <- lm(Murder ~ Population + Illiteracy + Income,
            data = states)
anova(fit12, fit13)


fit14 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
            data = states)
fit15 <- lm(Murder ~ Population + Illiteracy,
            data = states)
AIC(fit14, fit15)

# 8.6.2 Variable selection 

# stepwise regression

library(MASS)
fit16 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
            data = states)
stepAIC(fit16)
stepAIC(fit16, direction = 'backward')
# all subset regression

install.packages('leaps')
library(leaps)

leaps <- regsubsets(Murder ~ Population + Illiteracy + Income
                    + Frost, data  = states, nbest = 4) 
plot(leaps, scale = 'adjr2')

library(car)
subsets(leaps, statistic = 'cp',
        main = 'Cp plot for all subsets regression')
abline(1, 1, lty = 2, col = 'red')

# Taking the analysis further

# 8.7.1 cross-validation

install.packages('bootstrap')
shrinkage <- function(fit, k = 10){
     require(bootstrap)
     
     theta.fit <- function(x, y){lsfit(x, y)}
     thera.fit <- function(fit, x){cbind(1, x)%*%fit$coefficients}
     
     x <- fit$model[ , 2:ncol(fit$model)]
     y <- fit$model[ ,1]
     
     results <- crossval(x, y, thera.fit, 
                         thera.predict, ngroup = k)
     r2 <- cor(y, fit$fitred.values)^2
     r2cv <- cor(y, results$cv.fit)^2
}

fit17 <- lm(Murder ~ Population + Income + Illiteracy + Frost,
            data = states)
fit17
shrinkage(fit17)

fit18 <- lm(Murder ~ Population + Income + Illiteracy,
            data = states)
shrinkage(fit18)

# Relative importance

zstates <- as.data.frame(scale(states))
fit19 <- lm(Murder ~ Population + Income + Illiteracy + Frost,
            data = zstates)
coef(fit19)

relweights <- function(fit,...){
     R <- cor(fit$model)
     nvar <- ncol(R)
     rxx <- R[2:nvar, 2:nvar]
     rxy <- R[2:nvar, 1]
     svd <- eigen(rxx)
     evec <- svd$vectors
     ev <- svd$values
     delta <- diag(sqrt(ev))
     lambda <- evec %*% delta %*% t(evec)
     lambdasq <- lambda ^ 2
     beta <- solve(lambda) %*% rxy
     rsquare <- colSums(beta ^ 2)
     rawwgt <- lambdasq %*% beta ^ 2
     import <- (rawwgt / rsquare) * 100
     lbls <- names(fit$model[2:nvar])
     rownames(import) <- lbls
     colnames(import) <- "Weights"
     barplot(t(import),names.arg=lbls,
             ylab="% of R-Square",
             xlab="Predictor Variables",
             main="Relative Importance of Predictor Variables",
             sub=paste("R-Square=", round(rsquare, digits=3)),
             ...)
     return(import)
}

fit20 <- lm(Murder ~ Population + Income + Illiteracy + Frost,
            data = zstates)
fit20
fit20$model
cor(fit$model)

R <- cor(fit$model)
nvar <- ncol(R)
nvar
rxx <- R[2:nvar, 2:nvar]
rxy <- R[2:nvar, 1]
svd <- eigen(rxx)
svd
evec <- svd$vectors
ev <- svd$values
delta <- diag(sqrt(ev))
delta
lambda <- evec %*% delta %*% t(evec)
lambdasq <- lambda ^ 2
beta <- solve(lambda) %*% rxy
rsquare <- colSums(beta ^ 2)
rawwgt <- lambdasq %*% beta ^ 2
import <- (rawwgt / rsquare) * 100
lbls <- names(fit$model[2:nvar])
rownames(import) <- lbls


relweights(fit20, col = 'lightgrey')

# 8.8 summary

