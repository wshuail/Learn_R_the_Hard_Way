# Chapter 5 Toolbox

# 5.2 Overall layering strategy

# 5.3 Basic Plot Types

df <- data.frame(
    x = c(3, 1, 5),
    y = c(2, 4, 6),
    label = c("a","b","c")
)

p <- ggplot(df, aes(x, y, label = label)) +
    xlab(NULL) + ylab(NULL)

p + geom_point()
p + geom_bar(stat="identity")
p + geom_line()
p + geom_area()
p + geom_path()
p + geom_text()
p + geom_tile()
p + geom_polygon()


# 5.4 Displaying distributions

depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist +
    geom_histogram(aes(y = ..density..), binwidth = 0.1) +
    facet_grid(cut ~ .)
depth_dist + geom_histogram(aes(fill = cut), binwidth = 0.1,
                            position = "fill")
depth_dist + geom_freqpoly(aes(y = ..density.., colour = cut),
                           binwidth = 0.1)

qplot(cut, depth, data=diamonds, geom="boxplot")
qplot(carat, depth, data=diamonds, geom="boxplot",
      group = round_any(carat, 0.1, floor), xlim = c(0, 3))

ggplot(data = diamonds, aes(x = cut, y = depth)) +
    geom_boxplot()

ggplot(data = diamonds, aes(x = cut, y = depth)) +
    geom_boxplot()


qplot(class, cty, data=mpg, geom="jitter")
qplot(class, drv, data=mpg, geom="jitter")

ggplot(data = mpg, aes(x = class, y = cty)) + geom_jitter()
ggplot(data = mpg, aes(x = class, y = cty)) + geom_point()

ggplot(data = mpg, aes(x = class, y = drv)) + geom_jitter()


qplot(depth, data=diamonds, geom="density", xlim = c(54, 70))
qplot(depth, data=diamonds, geom="density", xlim = c(54, 70),
      fill = cut, alpha = I(0.2))

ggplot(data = diamonds, aes(x = depth)) + geom_density()
ggplot(data = diamonds, aes(x = depth)) + stat_density()

# 5.5 Dealing with Overlappig

df <- data.frame(x = rnorm(2000), y = rnorm(2000))
norm <- ggplot(df, aes(x, y))
norm + geom_point()
norm + geom_point(shape = 1)
norm + geom_point(shape = ".") # Pixel sized

norm + geom_point(colour = alpha("black", 1/3))
norm + geom_point(colour = alpha("black", 1/5))
norm + geom_point(colour = alpha("black", 1/10))


td <- ggplot(diamonds, aes(table, depth)) +
    xlim(50, 70) + ylim(50, 70)
td + geom_point()
td + geom_jitter()
jit <- position_jitter(width = 0.5)
td + geom_jitter(position = jit)
td + geom_jitter(position = jit, colour = alpha("black", 1/10))
td + geom_jitter(position = jit, colour = alpha("black", 1/50))
td + geom_jitter(position = jit, colour = alpha("black", 1/200))

d <- ggplot(diamonds, aes(carat, price)) + xlim(1,3) +
    theme(legend.position = "none")
d + stat_bin2d()
d + stat_bin2d(bins = 10)
d + stat_bin2d(binwidth=c(0.02, 200))
d + stat_binhex()
d + stat_binhex(bins = 10)
d + stat_binhex(binwidth=c(0.02, 200))

d <- ggplot(diamonds, aes(carat, price)) + xlim(1,3) +
    theme(legend.position = "none")
d + geom_point() + geom_density2d()
d + stat_density2d(geom = "point", aes(size = ..density..),
                   contour = F) + scale_area(to = c(0.2, 1.5))
d + stat_density2d(geom = "tile", aes(fill = ..density..),
                   contour = F)
last_plot() + scale_fill_gradient(limits = c(1e-5,8e-4))

# 5.6 Surface plots

# 5.7 Drawing maps

library(maps)
data(us.cities)
big_cities <- subset(us.cities, pop > 500000)
qplot(long, lat, data = big_cities) + borders("state", size = 0.5)
tx_cities <- subset(us.cities, country.etc == "TX")
str(tx_cities)
ggplot(tx_cities, aes(long, lat)) +
    borders("county", "texas", colour = "grey70") +
    geom_point(colour = alpha("black", 0.5))



library(maps)
states <- map_data("state")
arrests <- USArrests
names(arrests) <- tolower(names(arrests))
arrests$region <- tolower(rownames(USArrests))
choro <- merge(states, arrests, by = "region")
# Reorder the rows because order matters when drawing polygons
# and merge destroys the original ordering
choro <- choro[order(choro$order), ]
str(choro)
qplot(long, lat, data = choro, group = group,fill = assault, geom = "polygon")
qplot(long, lat, data = choro, group = group,
      fill = assault / murder, geom = "polygon")


ia <- map_data("county", "iowa")
mid_range <- function(x) mean(range(x, na.rm = TRUE))
centres <- ddply(ia, .(subregion),
                 colwise(mid_range, .(lat, long)))
ggplot(ia, aes(long, lat)) +
    geom_polygon(aes(group = group),
                 fill = NA, colour = "grey60") +
    geom_text(aes(label = subregion), data = centres,
              size = 2, angle = 45)


# 5.8 Revealing uncertainty


# 5.9 Statistical summaries

# 5.9.1 Individual summary functions
# 5.9.2 Single summary function

# 5.10 Annotating a plot

unemp <- qplot(date, unemploy, data=economics, geom="line",
                xlab = "", ylab = "No. unemployed (1000s)")
unemp
presidential <- presidential[-(1:3), ]
yrng <- range(economics$unemploy)
xrng <- range(economics$date)
unemp + geom_vline(aes(xintercept = start), data = presidential)

unemp + geom_rect(aes(NULL, NULL, xmin = start, xmax = end,
                      fill = party), 
                  ymin = yrng[1], ymax = yrng[2],
                  data = presidential) + 
    scale_fill_manual(values = alpha(c("blue", "red"), 0.2))

last_plot() + geom_text(aes(x = start, y = yrng[1], label = name), data = presidential, size = 3, hjust = 0, vjust = 0)


# 5.11 Weighted data

qplot(percwhite, percbelowpoverty, data = midwest)
qplot(percwhite, percbelowpoverty, data = midwest,
      size = poptotal / 1e6) + scale_area("Population\n(millions)",
                                          breaks = c(0.5, 1, 2, 4))
qplot(percwhite, percbelowpoverty, data = midwest, size = area) +
    scale_area()


lm_smooth <- geom_smooth(method = lm, size = 1)
qplot(percwhite, percbelowpoverty, data = midwest) + lm_smooth
qplot(percwhite, percbelowpoverty, data = midwest,
      weight = popdensity, size = popdensity) + lm_smooth

qplot(percbelowpoverty, data = midwest, binwidth = 1)
qplot(percbelowpoverty, data = midwest, weight = poptotal,
      binwidth = 1) + ylab("population")




