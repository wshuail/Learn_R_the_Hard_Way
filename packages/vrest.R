

# guess_encoding(x)

# repair_encoding(x, from = NULL)

# This page claims to be in iso-8859-1:
url <- 'http://www.elections.ca/content.aspx?section=res&dir=cir/list&document=index&lang=e#list'
elections <- html(url)
x <- elections %>% html_nodes("table") %>% .[[2]] %>% html_table() %>% .$TO
# But something looks wrong:
x
# It's acutally UTF-8!
guess_encoding(x)
# We can repair this vector:
repair_encoding(x)
# But it's better to start from scratch with correctly encoded file
elections <- html(url, encoding = "UTF-8")

elections %>% html_nodes("table") %>% .[[2]] %>% html_table() %>% .$TO


# google_form Make link to google form given id

google_form("1M9B8DsYNFyDjpwSK6ur_bZf8Rv_04ma3rmaaBiveoUI")

# html(x, ..., encoding = NULL)

# From a url:
google <- html("http://google.com")
google %>% xml_structure()
google %>% html_nodes("p")
# From a string: (minimal html 5 document)
# http://www.brucelawson.co.uk/2010/a-minimal-html5-document/
minimal <- html("<!doctype html>
<meta charset=utf-8>
<title>blah</title>
<p>I'm the content")
minimal
# From an httr request
google2 <- html(httr::GET("http://google.com"))

# html_form(x)

html_form(html("https://hadley.wufoo.com/forms/libraryrequire-quiz/"))
html_form(html("https://hadley.wufoo.com/forms/r-journal-submission/"))
box_office <- html("http://www.boxofficemojo.com/movies/?id=ateam.htm")
box_office %>% html_node("form") %>% html_form()

# html_nodes(x, css, xpath)
# html_node(x, css, xpath)

# CSS selectors ----------------------------------------------
ateam <- html("http://www.boxofficemojo.com/movies/?id=ateam.htm")
html_nodes(ateam, "center")
html_nodes(ateam, "center font")
html_nodes(ateam, "center font b")

# But html_node is best used in conjunction with %>% from magrittr
# You can chain subsetting:
ateam %>% html_nodes("center") %>% html_nodes("td")
ateam %>% html_nodes("center") %>% html_nodes("font")
# When applied to a list of nodes, html_nodes() collapses output
# html_node() selects a single element from each
td <- ateam %>% html_nodes("center") %>% html_nodes("td")
td %>% html_nodes("font")
td %>% html_node("font")
# To pick out an element at specified position, use magrittr::extract2
# which is an alias for [[
library(magrittr)
ateam %>% html_nodes("table") %>% extract2(1) %>% html_nodes("img")
ateam %>% html_nodes("table") %>% `[[`(1) %>% html_nodes("img")
# Find all images contained in the first two tables
ateam %>% html_nodes("table") %>% `[`(1:2) %>% html_nodes("img")
ateam %>% html_nodes("table") %>% extract(1:2) %>% html_nodes("img")
# XPath selectors ---------------------------------------------
# chaining with XPath is a little trickier - you may need to vary
# the prefix you're using - // always selects from the root noot
# regardless of where you currently are in the doc
ateam %>%
        html_nodes(xpath = "//center//font//b") %>%
        html_nodes(xpath = "//b")

# html_session(url, ...)
# is.session(x)

# http://stackoverflow.com/questions/15853204
s <- html_session("http://had.co.nz")
s

thesis <- jump_to(s, "thesis")
thesis

m <- jump_to(thesis, '/')
m

n <- session_history(m)
n


s %>% jump_to("thesis") %>% jump_to("/") %>% session_history()
s %>% jump_to("thesis") %>% back() %>% session_history()
s %>% follow_link(css = "p a")

?follow_link

jump_to(x, url, ...)

follow_link(x, i, css, xpath, ...)

s <- html_session("http://had.co.nz")
s %>% jump_to("thesis/")
s %>% follow_link("vita")
s %>% follow_link(3)
s %>% follow_link("vita")

# html_table(x, header = NA, trim = TRUE, fill = FALSE, dec = ".")

tdist <- html("http://en.wikipedia.org/wiki/Student%27s_t-distribution")
tdist %>%
        html_node("table.infobox") %>%
        html_table(header = FALSE)

births <- html("http://www.ssa.gov/oact/babynames/numberUSbirths.html")
html_table(html_nodes(births, "table")[[2]])
# If the table is badly formed, and has different number of rows 
# in each column use fill = TRUE. Here's it's due to incorrect 
# colspan specification.
skiing <- html("http://data.fis-ski.com/dynamic/results.html?sector=CC&raceid=22395")
skiing %>%
        html_table(fill = TRUE)

# html_text(x, ...)
# html_tag(x)
# html_children(x)
# html_attrs(x)
# html_attr(x, name, default = NA_character_)

movie <- html("http://www.imdb.com/title/tt1490017/")
cast <- html_nodes(movie, "#titleCast span.itemprop")
html_text(cast)
html_tag(cast)
html_attrs(cast)
html_attr(cast, "class")
html_attr(cast, "itemprop")
basic <- html("<p class='a'><b>Bold text</b></p>")
p <- html_node(basic, "p")
p
# Can subset with numbers to extract children
p[[1]]
# Use html_attr to get attributes
html_attr(p, "class")

# pluck(x, i, type)

# set_values(form, ...)
search <- html_form(html("https://www.google.com"))[[1]]
set_values(search, q = "My little pony")
set_values(search, hl = "fr")
## Not run: set_values(search, btnI = "blah")

# submit_form(session, form, submit = NULL, ...)

test <- google_form("1M9B8DsYNFyDjpwSK6ur_bZf8Rv_04ma3rmaaBiveoUI")
f0 <- html_form(test)[[1]]
f1 <- set_values(f0, entry.564397473 = "abc")
f1

# xml(x, ..., encoding = NULL)
# xml_tag(x)
# xml_attr(x, name, default = NA_character_)
# xml_attrs(x)
# xml_node(x, css, xpath)
# xml_nodes(x, css, xpath)
# xml_text(x, ...)
# xml_children(x)

search <- xml("http://stackoverflow.com/feeds")
entries <- search %>% xml_nodes("entry")
entries[[1]] %>% xml_structure()
entries %>% xml_node("author name") %>% xml_text()
entries %>% lapply(. %>% xml_nodes("category") %>% xml_attr("term"))

# xml_structure(x, indent = 0)


wiki <- 'http://en.wikipedia.org/wiki/Student%27s_t-distribution'
h1 <- html(wiki)

library(XML)
h2 <- htmlParse(wiki)

identical(h1, h2)
















