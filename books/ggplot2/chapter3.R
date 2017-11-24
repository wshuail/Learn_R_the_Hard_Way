# Chapter 3 Mastering the grammers

# 3.1 Introduction

# 3.2 Fuel economy data

# 3.3 Building a scatterplot

qplot(displ, hwy, data = mpg, color = factor(cyl))

qplot(displ, hwy, data = mpg, geom = 'line', color = factor(cyl))

qplot(displ, hwy, data = mpg, geom ='bar', color = factor(cyl))

# 3.4 A more complex example

qplot(displ, hwy, data = mpg, facets = . ~ year) + geom_smooth()

# 3.5 Components of the layered grammer

# 3.5.1 layers

# 3.5.2 scale

# 3.5.3 Coordinate system

# 3.5.4 Faceting

# 3.6 Data structure

# print()
# ggsave()
# summary()
# save()
# load()

p <- qplot(displ, hwy, data = mpg, color = factor(cyl))
summary(p)
# save plot object to disk
save(p, file = 'plot.rdata')
# load from disk
load('plot.rdata')
# save png to disk
ggsave('plot.png', width = 5, height = 5)

















