
# This tutorial is from ZevRoss's blog
# http://dwz.cn/H6zda

# load the data
list.files()
shakespeare <- read.csv('shakespeare.csv', header = T, sep = ',',
                        stringsAsFactors = F)
head(shakespeare, n = 20)
str(shakespeare)

# dplyr
library(dplyr)
head(filter(shakespeare, tolower(word) == 'henry'))
shakespeare <- mutate(shakespeare, word = tolower(word))
grp <- group_by(shakespeare, word, corpus, corpus_date)
shakespeare <- summarise(grp, word_count = sum(word_count))
head(filter(shakespeare, word == 'henry'))

x1 <- c(rep(5, 8), rep(10, 8), rep(20, 8))
x1
x2 <- c(rep(c('A', 'B', 'C', 'D'), 6))
x2
x3 <- c(rep(c('For', 'Bar'), 12))
df <- data.frame(x1, x2, x3)
df
df_gb <- group_by(df, x2, x1)
df_gb
summarise(df_gb, count = n())
summarise(df_gb, x1 = sum(x1))
summarise(df_gb, count = n(), total = sum(x3))
summarise(df_gb, x3 = sum(x3))

grp <- group_by(shakespeare, word)
cnts <- summarise(grp, count = n(), total = sum(word_count))
word_counts <- arrange(cnts, desc(total))
word_counts

# magrittr
library(magrittr)
word_count <- group_by(shakespeare, word) %>%
     summarise(count = n(), total = sum(word_count)) %>%
     arrange(desc(total))
head(word_count)

word_count_2 <- filter(word_count, nchar(word) > 4, count < 42)
word_count_2

word_count_3 <- word_count %>%
     filter(nchar(word) > 4, count < 42)
word_count_3
class(word_count_3)

# Tidyr

top8 <- word_count_3$word[1: 8]
top8
class(top8)

top8_2 <- filter(shakespeare, word %in% top8) %>%
     select(-corpus_date)
top8_2
class(top8_2)

library(tidyr)
top8_wider <- spread(top8_2, word, word_count)
top8_wider

top8_wider_2 <- spread(top8_2, word, word_count, fill = 0)
top8_wider_2

# ggplot2

word_count <- word_count_3
word_count
library(ggplot2)
ggplot(word_count, aes(count, total)) +
     geom_point(color = 'firebrick') +
     labs(x = 'Number of works a word appear in',
         y = 'Total number of times of a word appears in') + 
     scale_y_log10() +
     stat_smooth()

word_stats_1 <- group_by(word_count, count, total) %>%
     summarise(cotton = n())
word_stats_1

word_count_2 <- inner_join(word_count, word_stats_1,
                           by = c('count', 'total'))
word_count_2

ggplot(word_count_2, aes(count, total, size = cotton)) + 
     geom_point(color = 'firebrick') +
     labs(x = 'Number of works a word appear in',
          y = 'Total number of times of a word appears in') +
     scale_y_log10() +
     scale_size_area(max_size = 20) +
     theme(legend.position = 'none')

ggplot(word_count_2, aes(count, total)) +
     geom_jitter(alpha = 0.1,
                 position = position_jitter(width = .2), 
                 color = "firebrick") +
     labs(x = "Number of works a word appears in", 
          y = "Total number of time word appears") +
     scale_y_log10() + 
     stat_smooth()

word_states_2 <- group_by(word_count, count) %>%
     summarise(max = max(total), min = min(total))

word_count_5 <- inner_join(word_count, word_states_2,
                           by = c('count'))

ggplot(word_count_2, aes(count, total)) +
     geom_jitter(alpha = 0.1,
                 position = position_jitter(width = .2), 
                 color = "firebrick") +
     labs(x = "Number of works a word appears in", 
          y = "Total number of time word appears") +
     scale_y_log10() + 
     geom_text(data = filter(word_count_5, total == max),
               aes(count, total, label = word),
               size = 3) +
     geom_text(data = filter(word_count_5, 
                             total == 37 & min == 37),
               aes(count, total, label = word),
               position = position_jitter(height = 0.2),
               size = 3)











