<<<<<<< HEAD
# Data Processing with dplyr & tidyr
# avaliable at: http://rpubs.com/bradleyboehmke/data_wrangling

# Well structured data serves two purposes:
# 1, Makes data suitable for software processing whether that 
#    be mathematical functions, visualization, etc.
# 2, Reveals information and insights

require(plyr)
require(dplyr)
require(tidyr)

# %>%
# forward a value, or the result of an expression, into the next 
# function call/expression.

# tidyr operator
# gather function
# Reshaping wide format to long format

# Function:       gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)
# Same as:        data %>% gather(key, value, ..., na.rm = FALSE, convert = FALSE)

# Arguments:
#         data:           data frame
# key:            column name representing new variable
# value:          column name representing variable values
# ...:            names of columns to gather (or not gather)
# na.rm:          option to remove observations with missing values (represented by NAs)
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
# factor as appropriate

Group <- c(1:12)
Year <- rep(2006:2009, 3)
Qtr.1 <- rnorm(12, mean = 15, sd = 9)
Qtr.2 <- rnorm(12, mean = 20, sd = 5)
Qtr.3 <- rnorm(12, mean = 25, sd = 6)
Qtr.4 <- rnorm(12, mean = 20, sd = 10)

DF <- data.frame(Group, Year, Qtr.1, Qtr.2, Qtr.3, Qtr.4)

# How to use the gather function
# create a new variale called Quarter, converted value of Qtr.1
# to Qtr.2 as a new variable
long_DF <- DF %>% gather(Quarter, Avernue, Qtr.1:Qtr.4)

long_DF

# These all produce the same results.
long_DF_2 <- DF %>% gather(Quarter, Avernue, -Group, -Year)
long_DF_3 <- DF %>% gather(Quarter, Avernue, 3:6)
long_DF_4 <- DF %>% gather(Quarter, Avernue, 
                           Qtr.1, Qtr.2, Qtr.3, Qtr.4)

identical(long_DF, long_DF_2)
identical(long_DF, long_DF_3)
identical(long_DF, long_DF_4)

# Separate function
# Objective: Splitting a single variable into two

# Function:       separate(data, col, into, sep = " ", remove = TRUE, convert = FALSE)
# Same as:        data %>% separate(col, into, sep = " ", remove = TRUE, convert = FALSE)

# Arguments:
#         data:           data frame
# col:            column name representing current variable
# into:           names of variables representing new variables
# sep:            how to separate current variable (char, num, or symbol)
# remove:         if TRUE, remove input column from output data frame
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
#                 factor as appropriate


# use separate function to long_DF
# split the Quarter column
# Qtr.1 will be splited into Qtr and 1

separate_DF <- long_DF %>% 
        separate(Quarter, c('Time_Interval', 'Interval_ID'))
head(separate_DF, 10)

# This produce the same result
separate_DF_2 <- long_DF %>% 
        separate(Quarter, c('Time_Interval', 'Interval_ID'),
                 sep = '\\.')
separate_DF_2

# unite( ) function:
# Objective: Merging two variables into one

# Function:       unite(data, col, ..., sep = " ", remove = TRUE)
# Same as:        data %>% unite(col, ..., sep = " ", remove = TRUE)

# Arguments:
# data:           data frame
# col:            column name of new "merged" column
# ...:            names of columns to merge
# sep:            separator to use between merged values
# remove:         if TRUE, remove input column from output data frame

# apply unite function to separate_DF
# Merge Time_Interval and Interval_ID into Quarter
unite_DF <- separate_DF %>%
        unite(Quarter, Time_Interval, Interval_ID, sep = '.')
head(unite_DF, 10)

# These produce the same results:
# If no spearator is identified, "_" will automatically be used
unite_DF_2 <- separate_DF %>% 
        unite(Quarter, Time_Interval, Interval_ID, sep = "_")
unite_DF_3 <- separate_DF %>% 
        unite(Quarter, Time_Interval, Interval_ID)
identical(unite_DF_2, unite_DF_3)


# spread( ) function:
# Objective: Reshaping long format to wide format

# Function:       spread(data, key, value, fill = NA, convert = FALSE)
# Same as:        data %>% spread(key, value, fill = NA, convert = FALSE)

# Arguments:
#         data:           data frame
# key:            column values to convert to multiple columns
# value:          single column values to convert to multiple columns' values 
#         fill:           If there isn't a value for every combination of the other variables and the key 
# column, this value will be substituted
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
#                 factor as appropriate

# use spread function to unite_DF
# convert Quarter into different columns, and the Avernue to be 
# the value

spread_DF <- unite_DF %>% spread(Quarter, Avernue)
spread_DF        

# dplyr Operations

# create the example data sets

Division <- sample(1:10, 50, replace = TRUE)
State <- paste0(sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE))
options(digits = 0)
X1980 <- rnorm(50, mean = 10000000, sd = 600000)
X1981 <- rnorm(50, mean = 10000000, sd = 600000)
X1982 <- rnorm(50, mean = 10000000, sd = 600000)
X1983 <- rnorm(50, mean = 10000000, sd = 600000)
X1984 <- rnorm(50, mean = 10000000, sd = 600000)
X1985 <- rnorm(50, mean = 10000000, sd = 600000)
X1986 <- rnorm(50, mean = 10000000, sd = 600000)
X1987 <- rnorm(50, mean = 10000000, sd = 600000)
X1988 <- rnorm(50, mean = 10000000, sd = 600000)
X1989 <- rnorm(50, mean = 10000000, sd = 600000)
X1990 <- rnorm(50, mean = 10000000, sd = 600000)
X1991 <- rnorm(50, mean = 10000000, sd = 600000)
X1992 <- rnorm(50, mean = 10000000, sd = 600000)
X1993 <- rnorm(50, mean = 10000000, sd = 600000)
X1994 <- rnorm(50, mean = 10000000, sd = 600000)
X1995 <- rnorm(50, mean = 10000000, sd = 600000)
X1996 <- rnorm(50, mean = 10000000, sd = 600000)
X1997 <- rnorm(50, mean = 10000000, sd = 600000)
X1998 <- rnorm(50, mean = 10000000, sd = 600000)
X1999 <- rnorm(50, mean = 10000000, sd = 600000)
X2000 <- rnorm(50, mean = 10000000, sd = 600000)
X2001 <- rnorm(50, mean = 10000000, sd = 600000)
X2002 <- rnorm(50, mean = 10000000, sd = 600000)
X2003 <- rnorm(50, mean = 10000000, sd = 600000)
X2004 <- rnorm(50, mean = 10000000, sd = 600000)
X2005 <- rnorm(50, mean = 10000000, sd = 600000)
X2006 <- rnorm(50, mean = 10000000, sd = 600000)
X2007 <- rnorm(50, mean = 10000000, sd = 600000)
X2008 <- rnorm(50, mean = 10000000, sd = 600000)
X2009 <- rnorm(50, mean = 10000000, sd = 600000)
X2010 <- rnorm(50, mean = 10000000, sd = 600000)
X2011 <- rnorm(50, mean = 10000000, sd = 600000)

expenditures <- data.frame(Division, State, X1980, X1981, X1982,
                           X1983, X1984, X1985, X1986, X1987,
                           X1988, X1989, X1990, X1991, X1992,
                           X1992, X1993, X1994, X1995, X1996,
                           X1997, X1998, X1999, X2000, X2001,
                           X2002, X2003, X2004, X2005, X2006,
                           X2007, X2008, X2009, X2010, X2011)
head(expenditures)
unique(expenditures$Division)

# select( ) function:
# Objective: Reduce dataframe size to only desired variables 
# for current task

# Function:       select(data, ...)
# Same as:        data %>% select(...)

# Arguments:
#         data:           data frame
# ...:            call variables by name or by function

# Special functions:
# starts_with(x, ignore.case = TRUE): names starts with x
# ends_with(x, ignore.case = TRUE):   names ends in x
# contains(x, ignore.case = TRUE):    selects all variables whose 
#                                     name contains x
# matches(x, ignore.case = TRUE):     selects all variables whose 
#                                     name matches the regular expression x

# apply select function to data sets
sub.exp <- expenditures %>% select(X2007:X2011)
head(sub.exp)

sub.exp.2 <- expenditures %>% select(starts_with('X'))
sub.exp.2

# de-select variables by using "-" prior to name or function.  
sub.exp.3 <- expenditures %>% select(-X1980:-X2006)
sub.exp.4 <- expenditures %>% select(-starts_with("X"))
head(sub.exp.3)
head(sub.exp.4)

# filter( ) function:
# Objective: Reduce rows/observations with matching conditions

# Function:       filter(data, ...)
# Same as:        data %>% filter(...)

# Arguments:
#         data:           data frame
# ...:            conditions to be met

sub.exp.5 <- expenditures %>% filter(Division == 3)
head(sub.exp.5)

# use these in filter functions
# <   Less than                    
# !=      Not equal to
# >   Greater than                 
# %in%    Group membership
# ==  Equal to                     
# is.na   is NA
# <=  Less than or equal to        
# !is.na  is not NA
# >=  Greater than or equal to     
# &,|,!   Boolean operators

sub.exp.6 <- expenditures %>% filter(Division == 3, X2011 > 10000000 )
head(sub.exp.6)

# group_by( ) function:
# Objective: Group data by categorical variables

# Function:       group_by(data, ...)
# Same as:        data %>% group_by(...)

# Arguments:
#         data:           data frame
# ...:            variables to group_by

# Use ungroup(x) to remove groups

group.exp <- expenditures %>% group_by(Division)
head(group.exp)
group.exp

# summarise( ) function:
# Objective: Perform summary statistics on variables

# Function:       summarise(data, ...)
# Same as:        data %>% summarise(...)

# Arguments:
# data:           data frame
# ...:  Name-value pairs of summary functions like min(), mean(),
#       max() etc.

# Developer is from New Zealand...can use "summarise(x)" or 
# "summarize(x)"

sub.exp.7 <- expenditures %>% 
        summarize(mead_2011 = mean(X2011))
sub.exp.7

sub.exp.8 <- sub.exp %>% 
        summarise(Min = min(X2011, na.rm=TRUE),
                  Median = median(X2011, na.rm=TRUE),
                  Mean = mean(X2011, na.rm=TRUE),
                  Var = var(X2011, na.rm=TRUE),
                  SD = sd(X2011, na.rm=TRUE),
                  Max = max(X2011, na.rm=TRUE),
                  N = n())

sub.exp.8

# jointly used with the group_by function

sub.exp.9 <- expenditures %>%
        group_by(Division) %>%
        summarize(mean_2011 = mean(X2011, na.rm = T),
                  mean_2010 = mean(X2010, na.rm = T))
sub.exp.9

# apply multiple functions
sub.exp.10 <- expenditures %>%
        gather(Year, Expenditures, X2007:X2011) %>%
        filter(Division == 3) %>%
        group_by(State) %>%
        summarize(Mean = mean(Expenditures),
                 SD = sd(Expenditures))

head(sub.exp.10)

# arrange( ) function:
# Objective: Order variable values

# Function:       arrange(data, ...)
# Same as:        data %>% arrange(...)

# Arguments:
#         data:           data frame
# ...:            Variable(s) to order

# use desc(x) to sort variable in descending order

sub.exp.11 <- expenditures %>% 
        group_by(Division) %>%
        summarise(Mean_2011 = mean(X2011, na.rm = T),
                  Mean_2010 = mean(X2010, na.rm = T)) %>%
        arrange(Mean_2011)
sub.exp.11

# descending argument
sub.exp.12 <- expenditures %>% 
        group_by(Division) %>%
        summarise(Mean_2011 = mean(X2011, na.rm = T),
                  Mean_2010 = mean(X2010, na.rm = T)) %>%
        arrange(desc(Mean_2011))
sub.exp.12

# join( ) functions:
# Objective: Join two datasets together

# Description:    Join two datasets

# Function: inner_join(x, y, by = NULL)
# left_join(x, y, by = NULL)
# semi_join(x, y, by = NULL)
# anti_join(x, y, by = NULL)

# Arguments:
# x,y:  data frames to join
# by: a character vector of variables to join by. 
#    If NULL, the default, join will do a natural join, using all 
#    variables with common names across the two tables.

options(digits = 2)
# create a new data set
Year <- c(2006:2011)
Annual <- rnorm(6, mean = 215, sd = 10)
Inflation <- c(0.91, 0.93, 0.94, 0.96, 0.98, 1)

inflation <- data.frame(Year, Annual, Inflation)
inflation

# transform expenditures
sub.exp.13 <- expenditures %>% 
        select(Division, State, X2006:X2011) %>%
        gather(Year, Avernue, X2006:X2011) %>%
        separate(Year, into = c('X', 'Year'), sep = 'X') %>%
        select(-X)

sub.exp.13$Year <- as.numeric(sub.exp.13$Year)
head(sub.exp.13, 10)

# join the sub.exp.13 and inflation
join.exp <- sub.exp.13 %>%
        left_join(inflation)

head(join.exp, 20)
tail(join.exp, 20)

# To illustrate the other join funcition, use dataset below

name <- c('John', 'Paul', 'George', 'Ringo', 'Stuart', 'Pete')
instrument <- c('guita', 'bass', 'guita', 'drums', 'bass', 'drums')
join.1 <- data.frame(name, instrument)
join.1

name <- c('John', 'Paul', 'George', 'Ringo', 'Stuart')
band <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
join.2 <- data.frame(name, band)
join.2

# inner_join(): Include only rows in both x and y that have 
#               a matching value

inner_join <- join.1 %>%
        inner_join(join.2)
inner_join(join.1, join.2)
inner_join

# left_join(): Include all of x, and matching rows of y
left_join <- join.1 %>%
        left_join(join.2)

left_join(join.1, join.2)

# semi_join(): Include rows of x that match y but only 
#              keep the columns from x

semi_join <- semi_join(join.1, join.2)
semi_join

# anti_join(): Opposite of semi_join

anti_join <- anti_join(join.1, join.2)
anti_join

# mutate( ) function:
# Objective: Creates new variables

# Function:       
#         mutate(data, ...)
# Same as:        data %>% mutate(...)                

# Arguments:
#         data:           data frame
# ...:            Expression(s)

head(join.exp)

inflation_adj <- join.exp %>%
        mutate(Adj_exp = Avernue/Inflation)
head(inflation_adj)

rank_exp <- inflation_adj %>%
        filter(Year == 2010) %>%
        arrange(desc(Adj_exp)) %>%
        mutate(Rank = 1:length(Adj_exp))
head(rank_exp)

# log function
inflation_adj_2 <- inflation_adj %>%
        filter(State == 'VTAPF') %>%
        mutate(perc_chg = (Adj_exp-lag(Adj_exp))/lag(Adj_exp))
head(inflation_adj_2)

perc_of_whole <- inflation_adj %>%
        filter(Year == 2011) %>%
        arrange(desc(Adj_exp)) %>%
        mutate(perc_of_whole = Adj_exp/sum(Adj_exp),
               cum_perc = cumsum(perc_of_whole))
head(perc_of_whole)

# The End

=======
# Data Processing with dplyr & tidyr
# avaliable at: http://rpubs.com/bradleyboehmke/data_wrangling

# Well structured data serves two purposes:
# 1, Makes data suitable for software processing whether that 
#    be mathematical functions, visualization, etc.
# 2, Reveals information and insights

require(plyr)
require(dplyr)
require(tidyr)

# %>%
# forward a value, or the result of an expression, into the next 
# function call/expression.

# tidyr operator
# gather function
# Reshaping wide format to long format

# Function:       gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)
# Same as:        data %>% gather(key, value, ..., na.rm = FALSE, convert = FALSE)

# Arguments:
#         data:           data frame
# key:            column name representing new variable
# value:          column name representing variable values
# ...:            names of columns to gather (or not gather)
# na.rm:          option to remove observations with missing values (represented by NAs)
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
# factor as appropriate

Group <- c(1:12)
Year <- rep(2006:2009, 3)
Qtr.1 <- rnorm(12, mean = 15, sd = 9)
Qtr.2 <- rnorm(12, mean = 20, sd = 5)
Qtr.3 <- rnorm(12, mean = 25, sd = 6)
Qtr.4 <- rnorm(12, mean = 20, sd = 10)

DF <- data.frame(Group, Year, Qtr.1, Qtr.2, Qtr.3, Qtr.4)

# How to use the gather function
# create a new variale called Quarter, converted value of Qtr.1
# to Qtr.2 as a new variable
long_DF <- DF %>% gather(Quarter, Avernue, Qtr.1:Qtr.4)

long_DF

# These all produce the same results.
long_DF_2 <- DF %>% gather(Quarter, Avernue, -Group, -Year)
long_DF_3 <- DF %>% gather(Quarter, Avernue, 3:6)
long_DF_4 <- DF %>% gather(Quarter, Avernue, 
                           Qtr.1, Qtr.2, Qtr.3, Qtr.4)

identical(long_DF, long_DF_2)
identical(long_DF, long_DF_3)
identical(long_DF, long_DF_4)

# Separate function
# Objective: Splitting a single variable into two

# Function:       separate(data, col, into, sep = " ", remove = TRUE, convert = FALSE)
# Same as:        data %>% separate(col, into, sep = " ", remove = TRUE, convert = FALSE)

# Arguments:
#         data:           data frame
# col:            column name representing current variable
# into:           names of variables representing new variables
# sep:            how to separate current variable (char, num, or symbol)
# remove:         if TRUE, remove input column from output data frame
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
#                 factor as appropriate


# use separate function to long_DF
# split the Quarter column
# Qtr.1 will be splited into Qtr and 1

separate_DF <- long_DF %>% 
        separate(Quarter, c('Time_Interval', 'Interval_ID'))
head(separate_DF, 10)

# This produce the same result
separate_DF_2 <- long_DF %>% 
        separate(Quarter, c('Time_Interval', 'Interval_ID'),
                 sep = '\\.')
separate_DF_2

# unite( ) function:
# Objective: Merging two variables into one

# Function:       unite(data, col, ..., sep = " ", remove = TRUE)
# Same as:        data %>% unite(col, ..., sep = " ", remove = TRUE)

# Arguments:
# data:           data frame
# col:            column name of new "merged" column
# ...:            names of columns to merge
# sep:            separator to use between merged values
# remove:         if TRUE, remove input column from output data frame

# apply unite function to separate_DF
# Merge Time_Interval and Interval_ID into Quarter
unite_DF <- separate_DF %>%
        unite(Quarter, Time_Interval, Interval_ID, sep = '.')
head(unite_DF, 10)

# These produce the same results:
# If no spearator is identified, "_" will automatically be used
unite_DF_2 <- separate_DF %>% 
        unite(Quarter, Time_Interval, Interval_ID, sep = "_")
unite_DF_3 <- separate_DF %>% 
        unite(Quarter, Time_Interval, Interval_ID)
identical(unite_DF_2, unite_DF_3)


# spread( ) function:
# Objective: Reshaping long format to wide format

# Function:       spread(data, key, value, fill = NA, convert = FALSE)
# Same as:        data %>% spread(key, value, fill = NA, convert = FALSE)

# Arguments:
#         data:           data frame
# key:            column values to convert to multiple columns
# value:          single column values to convert to multiple columns' values 
#         fill:           If there isn't a value for every combination of the other variables and the key 
# column, this value will be substituted
# convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
#                 factor as appropriate

# use spread function to unite_DF
# convert Quarter into different columns, and the Avernue to be 
# the value

spread_DF <- unite_DF %>% spread(Quarter, Avernue)
spread_DF        

# dplyr Operations

# create the example data sets

Division <- sample(1:10, 50, replace = TRUE)
State <- paste0(sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE),
                sample(LETTERS, 50, replace = TRUE))
options(digits = 0)
X1980 <- rnorm(50, mean = 10000000, sd = 600000)
X1981 <- rnorm(50, mean = 10000000, sd = 600000)
X1982 <- rnorm(50, mean = 10000000, sd = 600000)
X1983 <- rnorm(50, mean = 10000000, sd = 600000)
X1984 <- rnorm(50, mean = 10000000, sd = 600000)
X1985 <- rnorm(50, mean = 10000000, sd = 600000)
X1986 <- rnorm(50, mean = 10000000, sd = 600000)
X1987 <- rnorm(50, mean = 10000000, sd = 600000)
X1988 <- rnorm(50, mean = 10000000, sd = 600000)
X1989 <- rnorm(50, mean = 10000000, sd = 600000)
X1990 <- rnorm(50, mean = 10000000, sd = 600000)
X1991 <- rnorm(50, mean = 10000000, sd = 600000)
X1992 <- rnorm(50, mean = 10000000, sd = 600000)
X1993 <- rnorm(50, mean = 10000000, sd = 600000)
X1994 <- rnorm(50, mean = 10000000, sd = 600000)
X1995 <- rnorm(50, mean = 10000000, sd = 600000)
X1996 <- rnorm(50, mean = 10000000, sd = 600000)
X1997 <- rnorm(50, mean = 10000000, sd = 600000)
X1998 <- rnorm(50, mean = 10000000, sd = 600000)
X1999 <- rnorm(50, mean = 10000000, sd = 600000)
X2000 <- rnorm(50, mean = 10000000, sd = 600000)
X2001 <- rnorm(50, mean = 10000000, sd = 600000)
X2002 <- rnorm(50, mean = 10000000, sd = 600000)
X2003 <- rnorm(50, mean = 10000000, sd = 600000)
X2004 <- rnorm(50, mean = 10000000, sd = 600000)
X2005 <- rnorm(50, mean = 10000000, sd = 600000)
X2006 <- rnorm(50, mean = 10000000, sd = 600000)
X2007 <- rnorm(50, mean = 10000000, sd = 600000)
X2008 <- rnorm(50, mean = 10000000, sd = 600000)
X2009 <- rnorm(50, mean = 10000000, sd = 600000)
X2010 <- rnorm(50, mean = 10000000, sd = 600000)
X2011 <- rnorm(50, mean = 10000000, sd = 600000)

expenditures <- data.frame(Division, State, X1980, X1981, X1982,
                           X1983, X1984, X1985, X1986, X1987,
                           X1988, X1989, X1990, X1991, X1992,
                           X1992, X1993, X1994, X1995, X1996,
                           X1997, X1998, X1999, X2000, X2001,
                           X2002, X2003, X2004, X2005, X2006,
                           X2007, X2008, X2009, X2010, X2011)
head(expenditures)
unique(expenditures$Division)

# select( ) function:
# Objective: Reduce dataframe size to only desired variables 
# for current task

# Function:       select(data, ...)
# Same as:        data %>% select(...)

# Arguments:
#         data:           data frame
# ...:            call variables by name or by function

# Special functions:
# starts_with(x, ignore.case = TRUE): names starts with x
# ends_with(x, ignore.case = TRUE):   names ends in x
# contains(x, ignore.case = TRUE):    selects all variables whose 
#                                     name contains x
# matches(x, ignore.case = TRUE):     selects all variables whose 
#                                     name matches the regular expression x

# apply select function to data sets
sub.exp <- expenditures %>% select(X2007:X2011)
head(sub.exp)

sub.exp.2 <- expenditures %>% select(starts_with('X'))
sub.exp.2

# de-select variables by using "-" prior to name or function.  
sub.exp.3 <- expenditures %>% select(-X1980:-X2006)
sub.exp.4 <- expenditures %>% select(-starts_with("X"))
head(sub.exp.3)
head(sub.exp.4)

# filter( ) function:
# Objective: Reduce rows/observations with matching conditions

# Function:       filter(data, ...)
# Same as:        data %>% filter(...)

# Arguments:
#         data:           data frame
# ...:            conditions to be met

sub.exp.5 <- expenditures %>% filter(Division == 3)
head(sub.exp.5)

# use these in filter functions
# <   Less than                    
# !=      Not equal to
# >   Greater than                 
# %in%    Group membership
# ==  Equal to                     
# is.na   is NA
# <=  Less than or equal to        
# !is.na  is not NA
# >=  Greater than or equal to     
# &,|,!   Boolean operators

sub.exp.6 <- expenditures %>% filter(Division == 3, X2011 > 10000000 )
head(sub.exp.6)

# group_by( ) function:
# Objective: Group data by categorical variables

# Function:       group_by(data, ...)
# Same as:        data %>% group_by(...)

# Arguments:
#         data:           data frame
# ...:            variables to group_by

# Use ungroup(x) to remove groups

group.exp <- expenditures %>% group_by(Division)
head(group.exp)
group.exp

# summarise( ) function:
# Objective: Perform summary statistics on variables

# Function:       summarise(data, ...)
# Same as:        data %>% summarise(...)

# Arguments:
# data:           data frame
# ...:  Name-value pairs of summary functions like min(), mean(),
#       max() etc.

# Developer is from New Zealand...can use "summarise(x)" or 
# "summarize(x)"

sub.exp.7 <- expenditures %>% 
        summarize(mead_2011 = mean(X2011))
sub.exp.7

sub.exp.8 <- sub.exp %>% 
        summarise(Min = min(X2011, na.rm=TRUE),
                  Median = median(X2011, na.rm=TRUE),
                  Mean = mean(X2011, na.rm=TRUE),
                  Var = var(X2011, na.rm=TRUE),
                  SD = sd(X2011, na.rm=TRUE),
                  Max = max(X2011, na.rm=TRUE),
                  N = n())

sub.exp.8

# jointly used with the group_by function

sub.exp.9 <- expenditures %>%
        group_by(Division) %>%
        summarize(mean_2011 = mean(X2011, na.rm = T),
                  mean_2010 = mean(X2010, na.rm = T))
sub.exp.9

# apply multiple functions
sub.exp.10 <- expenditures %>%
        gather(Year, Expenditures, X2007:X2011) %>%
        filter(Division == 3) %>%
        group_by(State) %>%
        summarize(Mean = mean(Expenditures),
                 SD = sd(Expenditures))

head(sub.exp.10)

# arrange( ) function:
# Objective: Order variable values

# Function:       arrange(data, ...)
# Same as:        data %>% arrange(...)

# Arguments:
#         data:           data frame
# ...:            Variable(s) to order

# use desc(x) to sort variable in descending order

sub.exp.11 <- expenditures %>% 
        group_by(Division) %>%
        summarise(Mean_2011 = mean(X2011, na.rm = T),
                  Mean_2010 = mean(X2010, na.rm = T)) %>%
        arrange(Mean_2011)
sub.exp.11

# descending argument
sub.exp.12 <- expenditures %>% 
        group_by(Division) %>%
        summarise(Mean_2011 = mean(X2011, na.rm = T),
                  Mean_2010 = mean(X2010, na.rm = T)) %>%
        arrange(desc(Mean_2011))
sub.exp.12

# join( ) functions:
# Objective: Join two datasets together

# Description:    Join two datasets

# Function: inner_join(x, y, by = NULL)
# left_join(x, y, by = NULL)
# semi_join(x, y, by = NULL)
# anti_join(x, y, by = NULL)

# Arguments:
# x,y:  data frames to join
# by: a character vector of variables to join by. 
#    If NULL, the default, join will do a natural join, using all 
#    variables with common names across the two tables.

options(digits = 2)
# create a new data set
Year <- c(2006:2011)
Annual <- rnorm(6, mean = 215, sd = 10)
Inflation <- c(0.91, 0.93, 0.94, 0.96, 0.98, 1)

inflation <- data.frame(Year, Annual, Inflation)
inflation

# transform expenditures
sub.exp.13 <- expenditures %>% 
        select(Division, State, X2006:X2011) %>%
        gather(Year, Avernue, X2006:X2011) %>%
        separate(Year, into = c('X', 'Year'), sep = 'X') %>%
        select(-X)

sub.exp.13$Year <- as.numeric(sub.exp.13$Year)
head(sub.exp.13, 10)

# join the sub.exp.13 and inflation
join.exp <- sub.exp.13 %>%
        left_join(inflation)

head(join.exp, 20)
tail(join.exp, 20)

# To illustrate the other join funcition, use dataset below

name <- c('John', 'Paul', 'George', 'Ringo', 'Stuart', 'Pete')
instrument <- c('guita', 'bass', 'guita', 'drums', 'bass', 'drums')
join.1 <- data.frame(name, instrument)
join.1

name <- c('John', 'Paul', 'George', 'Ringo', 'Stuart')
band <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
join.2 <- data.frame(name, band)
join.2

# inner_join(): Include only rows in both x and y that have 
#               a matching value

inner_join <- join.1 %>%
        inner_join(join.2)
inner_join(join.1, join.2)
inner_join

# left_join(): Include all of x, and matching rows of y
left_join <- join.1 %>%
        left_join(join.2)

left_join(join.1, join.2)

# semi_join(): Include rows of x that match y but only 
#              keep the columns from x

semi_join <- semi_join(join.1, join.2)
semi_join

# anti_join(): Opposite of semi_join

anti_join <- anti_join(join.1, join.2)
anti_join

# mutate( ) function:
# Objective: Creates new variables

# Function:       
#         mutate(data, ...)
# Same as:        data %>% mutate(...)                

# Arguments:
#         data:           data frame
# ...:            Expression(s)

head(join.exp)

inflation_adj <- join.exp %>%
        mutate(Adj_exp = Avernue/Inflation)
head(inflation_adj)

rank_exp <- inflation_adj %>%
        filter(Year == 2010) %>%
        arrange(desc(Adj_exp)) %>%
        mutate(Rank = 1:length(Adj_exp))
head(rank_exp)

# log function
inflation_adj_2 <- inflation_adj %>%
        filter(State == 'VTAPF') %>%
        mutate(perc_chg = (Adj_exp-lag(Adj_exp))/lag(Adj_exp))
head(inflation_adj_2)

perc_of_whole <- inflation_adj %>%
        filter(Year == 2011) %>%
        arrange(desc(Adj_exp)) %>%
        mutate(perc_of_whole = Adj_exp/sum(Adj_exp),
               cum_perc = cumsum(perc_of_whole))
head(perc_of_whole)

# The End

>>>>>>> 46446bca39505f609348fbccab8a2c7c8490a761
