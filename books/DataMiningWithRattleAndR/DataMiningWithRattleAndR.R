
# chapter 1
# load a couple of packages
require(rattle)
require(ggplot2)

# plot the data by qplot
ds <- weather
head(weather)
qplot(MinTemp, MaxTemp, data = ds)

# basic R
str(weather)
summary(weather)

qplot(Humidity3pm, Pressure9am, color = RainTomorrow, data = ds)
qplot(WindGustDir, Pressure3pm, data = ds)
qplot(WindGustDir, Pressure3pm, data = ds, geom = 'jitter')
qplot(WindGustDir, Pressure3pm, data = ds, color = WindGustDir,
      geom = 'jitter')


# chapter 2
# 1&2 install and start rattle

library(rattle)
rattle()

# 3 get familiar with rattle

# 4-6 load the data
# 7 explore the data
# 8 Test
# ....
# 13 Model 











