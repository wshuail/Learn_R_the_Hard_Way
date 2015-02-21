# Chapter 2 Getting started with qplot


2.2 Datasets

library(ggplot2)
set.seed(1124)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

# 2.3 Basic use

qplot(carat, price, data = diamonds)

qplot(log(carat), log(price), data = diamonds)

qplot(carat, x * y * z, data = diamonds)

# 2.4 Color, size, shape and other aesthetic attributes

qplot(carat, price, data = dsmall, color = color)

qplot(carat, price, data = dsmall, shape = cut)

qplot(carat, price, data = dsmall, alpha = I(1/100))

qplot(carat, price, data = dsmall, alpha = I(1/10))

qplot(carat, price, data = dsmall, alpha = I(1/3))

# Plot geoms

# geom = point
# geom = smooth
# geom = boxplot
# geom = path
# geom = line

# geom = histogram
# geom = freqplot
# geom = density
# geom = bar

# 2.5.1 Adding a smoother to a plot

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'))

qplot(carat, price, data = diamonds, geom = c('point', 'smooth'))

# method = 'loess'

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      span = 0.2)

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      span = 1)

library(mgcv)
qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      method = 'gam', formula = y ~ s(x))

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      method = 'gam', formula = y ~ s(x, bs = 'cs'))

# method = 'lm'

library(splines)

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      method = 'lm')

qplot(carat, price, data = dsmall, geom = c('point', 'smooth'),
      method = 'lm', formula = y ~ ns(x, 5))

# method = 'rlm'

# 2.5.2 Boxplots and jittered points

qplot(color, price / carat, data = diamonds, geom = 'jitter',
      alpha = I(1/5))

qplot(color, price / carat, data = diamonds, geom = 'jitter',
      alpha = I(1/50))

qplot(color, price / carat, data = diamonds, geom = 'jitter',
      alpha = I(1/10))

qplot(color, price / carat, data = diamonds, geom = 'boxplot')

# Histogram and densitty plots

qplot(carat, data = diamonds, geom = 'histogram')

qplot(carat, data = diamonds, geom = 'histogram', binwidth = 1,
      xlim = c(0, 3))

qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.1,
      xlim = c(0, 3))

qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.01,
      xlim = c(0, 3))

qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.1,
      xlim = c(0, 3), color = color)

qplot(carat, data = diamonds, geom = 'histogram', binwidth = 0.1,
      xlim = c(0, 3), fill = color)

qplot(carat, data = diamonds, geom = 'density', color = color)

qplot(carat, data = diamonds, geom = 'density', fill = color)

# 2.5.4 Bar charts

# geom = 'bar'

qplot(color, data = diamonds, geom = 'bar')

qplot(color, data = diamonds, geom = 'bar', weight = carat) +
         scale_y_continuous('carat')


# 2.5.5 Time series with line and path plot

# geom = 'line'

qplot(date, unemploy / pop, data = economics, geom = 'line')

qplot(date, uempmed, data = economics, geom = 'line')

year <- function(x) as.POSIXlt(x)$year + 1900

qplot(unemploy / pop, uempmed, data = economics,
      geom = c('point', 'path'))

qplot(unemploy / pop, uempmed, data = economics,
      geom = 'path', color = year(date)) + scale_size_area()

# Faceting

# row_var ~ col_var
# row_var ~ .

qplot(carat, data = diamonds, facets = color ~ .,
      geom = 'histogram', binwidth = 0.1, xlim = c(0, 3))

qplot(carat, ..density.., data = diamonds, facets = color ~ .,
      geom = 'histogram', binwidth = 0.1, xlim = c(0, 3))

# 2.7 Other options

# xlim, ylim
# log
# main
# xlab, ylab

qplot(carat, price, data = dsmall,
      xlab = 'Price($)',
      ylab = 'Weight(carat)',
      main = 'Price-weight relationship')


qplot(carat, price/carat, data = dsmall,
      xlab = 'Weight(carats)',
      ylab = expression(frac(price, carat)),
      main = 'Small diamonds',
      xlim = c(0.2, 1))

qplot(carat, price, data = dsmall, log = 'xy')


# 2.8 Differences from Plot
















