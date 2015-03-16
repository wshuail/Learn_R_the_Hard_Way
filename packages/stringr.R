require(stringr)
?str_detect
# fixed(string)
# This function specifies that a pattern is a fixed string, rather 
# than a regular expression.
# str_detect(string, pattern)
pattern <- "a.b"
strings <- c("abb", "a.b")
str_detect(strings, pattern)
str_detect(strings, fixed(pattern))

fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")
str_detect(fruit, "^a")
str_detect(fruit, "a$")
str_detect(fruit, "b")
str_detect(fruit, "[aeiou]")

# Also vectorised over pattern
str_detect("aecfg", letters)

# ignore.case(string)
# This function specifies that a pattern should ignore the case 
# of matches

pattern <- "a.b"
strings <- c("ABB", "aaB", "aab")
str_detect(strings, pattern)
str_detect(strings, ignore.case(pattern))

# str_locate(string, pattern)
fruit <- c("apple", "banana", "pear", "pinapple")
str_locate(fruit, "a")
str_locate(fruit, "e")
str_locate(fruit, c("a", "b", "p", "p"))

?str_locate_all
# str_locate_all(string, pattern)
fruit <- c("apple", "banana", "pear", "pineapple")
str_locate_all(fruit, "a")
str_locate_all(fruit, "e")
str_locate_all(fruit, c("a", "b", "p", "p"))

?str_sub
# str_sub(string, start = 1L, end = -1L)
# str_sub will recycle all arguments to be the same length as 
# the longest argument.
hw <- "Hadley Wickham"

str_sub(hw, 1, 6)
str_sub(hw, 1, 7)
str_sub(hw, end = 14)
str_sub(hw, end = 3)
str_sub(hw, 1)
str_sub(hw, 8, 14)
str_sub(hw, 7, 14)
str_sub(hw, 8)
str_sub(hw, c(1, 8), c(6, 14))

str_sub(hw, -1)
str_sub(hw, -7) #default as start
str_sub(hw, end = -7)
str_sub(hw, end = -1)

str_length(hw)
seq_len(str_length(hw))
str_sub(hw, seq_len(str_length(hw)))
str_sub(hw, end = seq_len(str_length(hw)))
str_sub(hw, end = - seq_len(str_length(hw)))

# invert_match(loc)
# Invert a matrix of match locations to match the opposite 
# of what was previously matched.

numbers <- "1 and 2 and 4 and 456"
num_loc <- str_locate_all(numbers, "[0-9]+")
num_loc
num_loc <- str_locate_all(numbers, "[0-9]+")[[1]]
num_loc
str_sub(numbers, num_loc[, "start"], num_loc[, "end"])
text_loc <- invert_match(num_loc)
text_loc
str_sub(numbers, text_loc[, "start"], text_loc[, "end"])

# perl(string)

pattern <- "(?x)a.b"
strings <- c("abb", "a.b")
## Not run: str_detect(strings, pattern)
perl(pattern)
str_detect(strings, perl(pattern))

# str_c(..., sep = "", collapse = NULL)
str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ")
str_c(letters, " is for", "...")
str_c(letters[-26], " comes before ", letters[-1])
str_c(letters, collapse = "")
str_c(letters, collapse = ", ")

# str_count(string, pattern)
fruit <- c("apple", "banana", "pear", "pineapple")
str_count(fruit, "a")
str_count(fruit, "p")
str_count(fruit, "e")
str_count(fruit, c("a", "b", "p", "p"))

# str_dup(string, times)
fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
str_dup(fruit, 1:3)
str_dup(fruit, 1:2) # error
str_c("ba", str_dup("na", 0:5))

# str_extract(string, pattern)
shopping_list <- c("apples x4", "flour", "sugar", "milk x2")
str_extract(shopping_list, "\\d") # number
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
#less than four letters between letter and non-letter
str_extract(shopping_list, "\\b[a-z]{1,4}\\b") 

# str_extract_all(string, pattern)
shopping_list <- c("apples x4", "bag of flour", 
                   "bag of sugar", "milk x2")
str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")

# str_length(string)
str_length(letters)
str_length(c("i", "like", "programming", NA))

# str_match(string, pattern)
strings <- c(" 219 733 8965", "329-293-8753 ", "banana", 
             "595 794 7569", "387 287 6718", "apple", 
             "233.398.9187 ", "482 952 3315",
             "239 923 8115", "842 566 4692", 
             "Work: 579-499-7527", "$1000",
             "Home: 543.355.3679")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_extract(strings, phone)
str_match(strings, phone)

# str_match_all(string, pattern)
strings <- c("Home: 219 733 8965. Work: 229-293-8753 ",
             "banana pear apple", "595 794 7569 / 387 287 6718")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_extract_all(strings, phone)
str_match(strings, phone)
str_match_all(strings, phone)

# str_pad(string, width, side = "left", pad = " ")
str_pad("hadley", 30, "left")
rbind(
        str_pad("hadley", 30, "left"),
        str_pad("hadley", 30, "right"),
        str_pad("hadley", 30, "both")
)
# Longer strings are returned unchanged
str_pad("hadley", 3)

str_pad('wblm', 20, side = "both", pad = " ")
str_pad('wblm', 20, side = "left", pad = " ")
str_pad('wblm', 20, side = "right", pad = " ")
str_pad('wblm', 20, side = "both", pad = ",")

# str_replace(string, pattern, replacement)
# str_replace_all(string, pattern, replacement)
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
str_replace_all(fruits, "[aeiou]", "-")
str_replace(fruits, "([aeiou])", "")
str_replace_all(fruits, "([aeiou])", "")
str_replace(fruits, "([aeiou])", "\\1\\1")
str_replace_all(fruits, "([aeiou])", "\\1\\1")
str_replace(fruits, "[aeiou]", c("1", "2", "3"))
str_replace_all(fruits, "[aeiou]", c("1", "2", "3"))
str_replace(fruits, c("a", "e", "i"), "-")
str_replace_all(fruits, c("a", "e", "i"), "-")

# str_split(string, pattern, n = Inf)
fruits <- c(
        "apples and oranges and pears and bananas",
        "pineapples and mangos and guavas"
)
str_split(fruits, " and ")
# Specify n to restrict the number of possible matches
str_split(fruits, " and ", n = 3)
str_split(fruits, " and ", n = 2)
# If n greater than number of pieces, no padding occurs
str_split(fruits, " and ", n = 5)

# str_split_fixed(string, pattern, n)
fruits <- c(
        "apples and oranges and pears and bananas",
        "pineapples and mangos and guavas"
)
str_split_fixed(fruits, " and ", 3)
str_split_fixed(fruits, " and ", 4)

# str_sub(string, start = 1L, end = -1L) <- value
x <- "BBCDEF"
str_sub(x, 1, 1) <- "A"; x
str_sub(x, -1, -1) <- "K"; x
str_sub(x, -2, -2) <- "GHIJ"; x
str_sub(x, 2, -2) <- ""; x

# str_trim(string, side = "both")
str_trim(" String with trailing and leading white space\t")
str_trim("\n\nString with trailing and leading white space\n\n")

# word(string, start = 1L, end = start, sep = fixed(" "))
sentences <- c("Jane saw a cat", "Jane sat down")
word(sentences, 1)
word(sentences, 2)
word(sentences, -1)
word(sentences, 2, -1)
# Also vectorised over start and end
word(sentences[1], 1:3, -1)
word(sentences[1], 1, 1:4)
# Can define words by other separators
str <- 'abc.def..123.4568.999..763.23'
word(str, 1, sep = fixed('..'))
word(str, 2, sep = fixed('..'))
word(str, 3, sep = fixed('..'))

# str_wrap(string, width = 80, indent = 0, exdent = 0)
thanks_path <- file.path(R.home("doc"), "THANKS")
thanks <- str_c(readLines(thanks_path), collapse = "\n")
thanks
thanks <- word(thanks, 1, 3, fixed("\n\n"))
thanks
cat(str_wrap(thanks), "\n")
cat(str_wrap(thanks, width = 40), "\n")
cat(str_wrap(thanks, width = 60, indent = 2), "\n")
cat(str_wrap(thanks, width = 60, exdent = 2), "\n")











