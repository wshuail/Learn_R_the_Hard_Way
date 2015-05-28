# chapter 7
# 7.8 Lab: Non-Linear Modeling
library(ISLR)
wage <- Wage
head(wage)

# 7.8.1 Polynomial regression and step function
lm_1 <- lm(wage ~ poly(age, 4), data = wage)
coef(summary(lm_1))
plot(wage$age, wage$wage)
plot(wage$age, wage$wage, cex = 0.3)

lm_2 <- lm(wage ~ poly(age, 4, raw = T), data = Wage)
coef(summary(lm_2))

lm_3 <- lm(wage ~ cbind(age, age^2, age^3, age^4), data = Wage)
coef(summary(lm_3))

# to predict
age_range <- range(wage$age)
age_range
age_range[1]
age_range[2]
age_grid <- seq(from = age_range[1], to = age_range[2])
age_grid

predict <- predict(lm_1, newdata = list(age = age_grid), 
                   se = T)
predict

names(predict)

se_bands <- cbind(predict$fit + 2*predict$se.fit,
                  predict$fit - 2*predict$se.fit)
se_bands

par(mar = c(4.5, 4.5, 1, 1), oma = c(0, 0, 4, 0))
plot(wage$age, wage$wage, xlim = age_range, cex = 0.5,
     col = 'darkgrey')
title('Degree-4 polynomial', outer = T)
lines(age_grid, predict$fit, lwd = 2, col = 'blue')
matlines(age_grid, se_bands, lwd = 1, col = 'blue', 
         lty = 3)

# Whether or not an orthogonal set of basis function will 
# not affect the model
predict_2 <- predict(lm_2, newdata = list(age = age_grid), se = T)
max(abs(predict_2$fit - predict$fit))

# aov function to test the NULL hypothesis

fit_1 <- lm(wage ~ age, data = Wage)
fit_2 <- lm(wage ~ poly(age, 2), data = Wage)
fit_3 <- lm(wage ~ poly(age, 3), data = Wage)
fit_4 <- lm(wage ~ poly(age, 4), data = Wage)
fit_5 <- lm(wage ~ poly(age, 5), data = Wage)
anova(fit_1, fit_2, fit_3, fit_4, fit_5)

coef(summary(fit_5))

# anova function to compare other terms
fit_6 <- lm(wage ~ education + age, data = wage)
fit_7 <- lm(wage ~ education + poly(age, 2), data = wage)
fit_8 <- lm(wage ~ education + poly(age, 3), data = wage)
anova(fit_6, fit_7, fit_8)

# cross-validation on ploynomial logistic regression
glm <- glm(I(wage > 250) ~ poly(age, 4), data = wage,
           family = 'binomial')
glm_predication <- predict(glm, newdata = list(age = age_grid),
                           se = T)

# The confidance intervals
p_glm <- exp(glm_predication$fit)/(1 + exp(glm_predication$fit))
p_glm
gp <- glm_predication$fit
ps <- glm_predication$se.fit
se_bands_logits <- cbind(gp + 2*ps, gp - 2*ps)
se_bands_logits
se_bands <- exp(se_bands_logits)/(1 + exp(se_bands_logits))
se_bands

preds <- predict(glm, newdata = list(age = age_grid),
                 type = 'response', se = T)
preds

plot(wage$age, wage$wage > 250)
plot(wage$age, I(wage$wage > 250), xlim = age_range,
     type = 'n', ylim = c(0, 0.2))
points(jitter(wage$age), I((wage$wage > 250)/5),
       cex = 0.5, pch = '|', col = 'darkgrey')
lines(age_grid, p_glm, lwd = 2, col = 'blue')
matlines(age_grid, se_bands, lwd = 1, col = 'blue', 
         lty = 3)

length(wage$age)
length(cut(wage$age, 4))
table(cut(wage$age, 4))

fit_9 <- lm(wage$wage ~ cut(wage$age, 4))
predict <- predict(fit_9, newdata = list(age = age_grid),
                   se = T)
list(age = age_grid)
length(predict)
coef(summary(fit_1))
names(fit_9)

plot(wage$age, wage$wage, col = 'gray')
lines(age_grid, predict$fit)

# Spline

library(splines)
# bs() function specify the knots directly using the 
spline <- lm(wage ~ bs(age, knots = c(25, 40, 60)), 
             data = wage)

predict <- predict(spline, newdata = list(age = age_grid),
                   se = T)
plot(wage$age, wage$wage, col = 'gray')
lines(age_grid, predict$fit, lwd = 2)
lines(age_grid, predict$fit + 2*predict$se.fit, 
      lty = 'dashed')
lines(age_grid, predict$fit - 2*predict$se.fit, 
      lty = 'dashed')

# df(degrees of freedom) function
dim(bs(wage$age, knots = c(25, 40, 60)))
dim(bs(wage$age, df = 6))
attr(bs(wage$age, df = 6), 'knots')

# ns() function for a natural spline
spline_2 <- lm(wage ~ ns(age, df = 4), data = wage)
predict_2 <- predict(spline_2, newdata = list(age = age_grid),
                     se = T)
plot(wage$age, wage$wage, col = 'gray')
lines(age_grid, predict_2$fit, col = 'red', lwd = 2)
lines(age_grid, predict_2$fit + 2*predict_2$se.fit,
      lty = 'dashed')
lines(age_grid, predict_2$fit - 2*predict_2$se.fit, 
      lty = 'dashed')

# smoothing spline function
# df = 16 leads lambda to 16 degree of freedom
plot(wage$age, wage$wage, xlim = age_range,
     cex = 0.5, col = 'darkgrey')
title('Smoothing Spline')
fit <- smooth.spline(wage$age, wage$wage, df = 16)
fit2 <- smooth.spline(wage$age, wage$wage, cv = T)
fit2$df
lines(fit, col = 'red', lwd = 2)
lines(fit2, col = 'blue', lwd = 2)
legend('topright', legend = c('16 DF', '6.8 DF'),
       col = c('red', 'blue'), 
       lty = 1, lwd = 2, cex = 0.8)

# local regression
plot(wage$age, wage$wage, xlim = age_range, 
     cex = 0.5, col = 'darkgrey')
title('Local Regression')

local <- loess(wage ~ age, span = 0.2, data = wage)
local_2 <- loess(wage ~ age, span = 0.5, data = wage)

lines(age_grid, predict(local, data.frame(age = age_grid)),
      col = 'red', lwd = 2)
lines(age_grid, predict(local_2, data.frame(age = age_grid)),
      col = 'blue', lwd = 2)
legend('topright', legend = c('Span = 0.2', 'Span = 0.5'),
       col = c('red', 'blue'), lty = 1, lwd = 2, cex = 0.8)

# 7.8.3 GAMs

lm_1 <- lm(wage ~ ns(year, 4) + ns(age, 5) + education, 
           data = wage)
lm_1

library(gam)
gam <- gam(wage ~ s(year, 4) + s(age, 5) + education, 
           data = wage)
par(mfrow = c(1, 3))
plot(gam, se = T, col = 'blue')
plot.gam(gam, se = T, col = 'red')

# anova analyzes different modes
gam_1 <- gam(wage ~ s(age, 5) + education, data = wage)
gam_2 <- gam(wage ~ year + s(age, 5) + education, 
             data = wage)
anova(gam, gam_1, gam_2, test = 'F')

summary(gam)

# predict function for gam
gam_predict <- predict(gam_2, newdata = wage)

# use local regression as building blocks in a GAM by lo function
gam_local <- gam(wage ~ s(year, df = 4) + 
                      lo(age, span = 0.7)
                 + education, data = wage)
plot.gam(gam_local, se = T, col = 'green')

# lo function to create interactions
gam_local_inter <- gam(wage ~ lo(year, age, span = 0.5) +
                            education, data = wage)
plot(gam_local_inter)

# plot the result by akima
library(akima)
plot(gam_local_inter)

# logistic regression by I()
gam_lr <- gam(I(wage > 250) ~ year + s(age, df = 5) + education,
              family = binomial, data = wage)
par(mfrow = c(1, 3))
plot(gam_lr, se = T, col = 'green')

table(wage$education, I(wage$wage > 250))

4


