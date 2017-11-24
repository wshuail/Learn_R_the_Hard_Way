# Chapter 4 Build a plot layer by layer

# 4.1 Introduction

# 4.2 Creating a plot

# aes()

P <- ggplot(diamonds, aes(carat, price, color = cut))
p <- p + layer(geom = 'point')
p

# layer(geom, geom_params, stat, stat_params, data,
#       mapping, position)


p <- ggplot(diamonds, aes(carat))
p <- p + layer(
        geom = 'bar',
        geom_params = list(fill = 'steelblue'),
        stat = 'bin',
        stat_params = list(binwidth = 2)
)
p


p <- ggplot(diamonds, aes(carat))
p <- p + layer(
        geom = 'bar',
        geom_params = list(fill = 'steelblue'),
        stat = 'bin',
        stat_params = list(binwidth = 2)
)
p

geom_histogram(binwidth = 2, fill = 'steelblue')

# geom_XXX(mapping, data, geom, position)
# stat_XXX(mapping, data, geom, position)

ggplot(msleep, aes(sleep_rem / sleep_total, awake)) +
        geom_point()


qplot(sleep_rem / sleep_total, awake, data = msleep)


ggplot(msleep, aes(sleep_rem / sleep_total, awake)) +
        geom_point() + geom_smooth()


qplot(sleep_rem / sleep_total, awake, data = msleep) +
        geom_smooth()
qplot(sleep_rem / sleep_total, awake, data = msleep) +
        geom = c('point', 'smooth')

p <-  ggplot(msleep, aes(sleep_rem / sleep_total, awake))
summary(p)

p <- p + geom_point()
summary(p)

bestfit <- geom_smooth(method = 'lm', 
                       se = F,
                       colour = alpha('steelblue', 0.5),
                       size = 2)

qplot(sleep_rem, sleep_total, data = msleep) + bestfit
qplot(awake, brainwt, data = msleep, log = 'y') + bestfit
qplot(bodywt, brainwt, data, msleep, log = 'xy') + bestfit

#  4.4 Data

# must be data frame

# %+%

p <- ggplot(mtcars, aes(mpg, wt, color = cyl)) + geom_point()
p
mtcars <- transform(mtcars, mpg = mpg^2)
p %+% mtcars

# 4.5 Aesthetic mapping

# aes(x = weight, y = height, color = age)

# 4.5.1 Plots and layers

p <- ggplot(mtcars)
summary(p)
p <- p + aes(wt, ph)
summary(p)

p <- ggplot(mtcars, aes(x = mpg, y = wt))
p + geom_point()

p + geom_point(aes(color = factor(cyl)))
p + geom_point(aes(y = disp))


# 4.5.2 Setting and mapping

p <- ggplot(mtcars, aes(mpg, wt))
p + geom_point(color = 'darkblue')

p <- ggplot(mtcars, aes(mpg, wt))
p + geom_point(aes(color = 'darkblue'))

# 4.5.3 Grouping data

p <- ggplot(Oxboys, aes(age, height, group = Subject)) +
        geom_line()
p

p <- ggplot(Oxboys, aes(age, height)) +
        geom_line()
p

p + geom_smooth(aes(group = Subject), method = 'lm', se = F)

p + geom_smooth(aes(group = 1), method = 'lm', size = 2, se = F)

boysbox <- ggplot(Oxboys, aes(Occasion, height)) + geom_boxplot()
boysbox
boysbox + geom_line(aes(group = Subject), color = '#3366FF')

# 4.5.4 Matching aesthetics to graphic objects

xgrid <- with(df, seq(min(x), max(x), length = 50))
interp <- data.frame(
        x = xgrid,
        y = approx(df$x, df$y, xout = xgrid)$y,
        color = approx(df$x, df$color, xout = xgrid)$y
        )

qplot(x, y, data = df, color = color, size = I(5)) +
        geom_line(data = interp, size = 2)

# 4.6 Geoms

# 4.7 stat

ggplot(diamonds, aes(carat)) +
        geom_histogram(aes(y = ..density..), binwidth = 0.1)

ggplot(diamonds, aes(carat)) +
        geom_histogram(binwidth = 0.1)

qplot(carat, ..density.., data = diamonds, geom = 'histogram',
      binwidth = 0.1)

# 4.8 Position adjustments

# 4.9 Pulling it all together

# 4.9.1 Combining geoms and stats

d <- ggplot(diamonds, aes(carat), xlim(0, 3))
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = 'area')

d + stat_bin(
        aes(size = ..density..),
        binwidth = 0.1,
        geom = 'point',
        position = 'identity')

d + stat_bin(
        aes(y = 1, fill = ..count..),
        binwidth = 0.1,
        geom = 'tile',
        position = 'identity')


# 4.9.2 Displaying precomputed statistics

# stat_indentity()

# 4.9.3 Varying aesthetic and data

require(nlme, quiet = TRUE, warn.conflicts = FALSE)
model <- lme(height ~ age, data = Oxboys,
             random = ~ 1 + age | Subject)
oplot <- ggplot(Oxboys, aes(age, height, group = Subject)) +
        geom_line()

age_grid <- seq(-1, 1, length = 10)
subjects <- unique(Oxboys$Subject)
preds  <- expand.grid(age = age_grid, Subjects = subjects)
preds$height <- predict(model, preds)
oplot + geom_line(data = preds, color = '#3366FF', size = 0.4)

#p 63




















