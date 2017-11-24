## chapeter 9 Analysis of variance

install.packages('gplots')
install.packages('HH')
install.packages('rrcov')
install.packages('mvoutlier')
install.packages('multcomp')

# 9.1 A crash course on terminology

# 9.2 Fitting AVOVA models

# 9.2.1 the aov() function

# some symbols
# ~/+/:/*/^/.

# Designs
# One-way ANOVA y ~ A 
# One-way ANCOVA with one covariate y ~ x + A
# Two-way factorial ANOVA y ~ A*B
# Two-way factorial ANCOVA with two covariates y ~ x1 + x2 + A*B
# Randomized Block y ~ B + A (B is a blocking factor)
# One-way within groups ANOVA y ~ A + error(Subject A)
# Repeated measures ANOVA with one within-groups factor (W) and one
# between-groups factor(B) 
# y ~ B * W + error(subject/W)

# 9.2.2 the order of fomular terms

# 9.3 One-way ANOVA


library(multcomp)
data(cholesterol)
attach(cholesterol)
head(cholesterol)

table(trt)
aggregate(response, by = list(trt), FUN = mean)

library(magrittr)
library(dplyr)
cholesterol %>%
     group_by(trt) %>%
     summarise(mean(response))

aggregate(response, by = list(trt), FUN = sd)

fit <- aov(response ~ trt)
     
summary(fit)

library(gplots)
plotmeans(response ~ trt, xlab = 'Treatment', ylab = 'Response',
          main = 'Mean plot\nwith 95% CI')

# 9.3.1 Multiple comparisons

# TukeyHSD function
TukeyHSD(fit)

par(las = 2)
par(mar = c(5, 8, 4, 2))
plot(TukeyHSD(fit))

# glht function
library(multcomp)
par(mar = c(5, 6, 4, 2))
tuk = glht(fit, linfct = mcp(trt = 'Tukey'))
tuk
plot(cld(tuk, level = 0.05), col = 'lightgrey')

# 9.3.2 Assessing test assumptions

# normality distribution test
library(car)
qqPlot(lm(response ~ trt, data = cholesterol),
       simulate = TRUE, main = 'QQ Plot', labels = FALSE)

# Bartlett test
bartlett.test(response ~ trt, data = cholesterol)

# outlier Test
library(car)
outlierTest(fit)


# 9.4 One-way ANCOVA
rm(dose)
library(multcomp)
attach(litter)
table(dose)
aggregate(weight, by = list(dose), FUN = mean)
fit = aov(weight ~ gesttime + dose)
summary(fit)

library(effects)
effect('dose', fit)

library(multcomp)
contrast <- rbind('no drug vs drugs' = c(3, -1, -1, -1))
summary(glht(fit, linfct = mcp(dose = contrast)))

# The test for the homogenity of regression

library(multcomp)
fit2 <- aov(weight ~ gesttime*dose, data = litter)
summary(fit2)

# 9.4.2 Visualizing the result
# the ancova function in HH packages
library(HH)
ancova(weight ~ gesttime + dose, data = litter)

# 9.5 Two-way factorial ANOVA
rm(dose)
attach(ToothGrowth)
table(supp, dose)
head(ToothGrowth, n = 10)
aggregate(len, by = list(supp, dose), FUN = mean)
aggregate(len, by = list(supp, dose), FUN = sd)
fit <- aov(len ~ supp*dose)
summary(fit)

interaction.plot(dose, supp, len, type = 'b',
                 col = c('red', 'blue'), pch = c(16, 18),
                 main = 'Interaction between Dose and Supplement Type')

library(gplots)
plotmeans(len ~  interaction(supp, dose, sep = ' '),
          connect = list(c(1, 3, 5), c(2, 4, 6)),
          col = c('red', 'darkgreen'),
          main = 'Interaction plot with 95% CIs',
          xlab = 'Treatment and Dose Combination')

library(HH)
interaction2wt(len ~ supp*dose)

# 9.6 Repeated measure ANOVA

head(CO2)
wlb1 <- subset(CO2, Treatment == 'chilled')
head(wlb1)

fit1 <- aov(uptake ~ conc*Type + Error(Plant/(conc)), wlb1)
summary(fit1)

par(las = 2)
par(mar = c(6, 4, 4, 2))
with(wlb1, 
     interaction.plot(conc, Type, uptake, type = 'b',
                      col = c('red', 'blue'), pch = c(16, 18),
                      main = 'Interaction Plot for Plant Type and Concentration'))

boxplot(uptake ~ Type*conc, data = wlb1, col = c('gold', 'green'),
        main = 'Chilled Quebec and Mississipi Plants',
        ylab = 'Carbon dioxide uptake rate (umol/m^2 sec)')

# 9.7 Multivariate analysis of variance (MANOVA)
library(MASS)
head(UScereal)
attach(UScereal)
y <- cbind(calories, fat, sugars)
head(y)
aggregate(y, by=list(shelf), mean)
cov(y)
fit <- manova(y ~ shelf)
summary(fit)
summary.aov(fit)

# 9.7.1 Assessing test assumptions

# Assessing multivariate normality
center <- colMeans(y)
n <- nrow(y)
p <- ncol(y)
cov <- cov(y)
d <- mahalanobis(y, center, cov)
coord <- qqplot(qchisq(ppoints(n), df=p),
                d, main = 'Q-Q Plot Assessing Multivariate Normality',
                ylab = 'Mahalanobis D2')
abline(a=0, b = 1)
identify(coord$x, coord$y, labels = row.names(UScereal))

library(mvoutlier)
outliers <- aq.plot(y)
outliers

# 9.7.2 Robust MNAOVA

library(rrcov)
Wilks.test(y, shelf, method = 'mcd')

# 9.8 ANOVA regression

library(multcomp)
levels(cholesterol$trt)

fit.aov <- aov(response ~ trt, data = cholesterol)
summary(fit.aov)

# by lm()
fit.lm <- lm(response ~ trt, data = cholesterol)
summary(fit.lm)

contrasts(cholesterol$trt)

fit.lm2 <- lm(response ~ trt, data = cholesterol,
              contrasts = 'contr.helmert')

# 9.9 Summary

