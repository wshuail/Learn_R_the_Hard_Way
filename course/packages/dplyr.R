# dplyr

library(dplyr)
getwd()
ls()
list.files()

# select

mydata <- read.table(file = '2003.txt', header = TRUE, sep = '\t',
                     stringsAsFactors = FALSE)
dim(mydata)
head(select(mydata, 1:5))
names(mydata)[1:8]
head(select(mydata, EVENT_ID: PROJECT))
head(select(mydata, -(EVENT_ID: PROJECT)))

# filter

no3data <- filter(mydata, PARAMETER == 'NO23F')
head(no3data)

nodata <- filter(mydata, PARAMETER == 'NO23F' |
                         PARAMETER == 'NO2F')
head(nodata)

head(select(nodata, EVENT_ID: PARAMETER), n=10)

head(select(nodata, 1:4, PARAMETER, PROJECT), n=8)

# arrange

data_layer <- arrange(mydata, LAYER)
head(select(data_layer, 1:4, LAYER), n=10)
tail(select(data_layer, 1:5, LAYER), n=10)

# rename

data_rename <- rename(mydata, project = PROJECT, date = SAMPLE_DATE)
head(data_rename)

# mutate

data_mutate <- mutate(mydata,
                      depth = DEPTH - mean(DEPTH, na.rm = TRUE))
head(select(data_mutate, depth, DEPTH))

# group-by and summarize
?group_by

by_cyl <- group_by(mtcars, cyl)
summarise(by_cyl, mean(disp), mean(hp))
filter(by_cyl, disp == max(disp))

by_vs_am <- group_by(mtcars, vs, am,
                     labels = c('1', '2', '3', '4'))
by_vs <- summarise(by_vs_am, n = n())  # n counts for the total num
by_vs
summarise(by_vs, n = sum(n))
summarise(ungroup(by_vs), n = sum(n))

groups(group_by(by_cyl, vs, am))
groups(group_by(by_cyl, vs, am, add = TRUE))

# %>%

head(mtcars)

mtcars %>% mutate(wt = wt - mean(wt)
                  %>%
        group_by(carb) %>%
        summary(disp = mean(disp), hp = max(hp))


flights %>%
        group_by(year, month, day) %>%
        select(arr_delay, dep_delay) %>%
        summarise(
                arr = mean(arr_delay, na.rm = TRUE),
                dep = mean(dep_delay, na.rm = TRUE)
        ) %>%
        filter(arr > 30 | dep > 30)
}











