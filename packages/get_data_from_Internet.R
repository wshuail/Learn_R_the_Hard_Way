r_home = url('http://www.r-project.org/')
r_home
isOpen(r_home)

baidu = url('http://www.baidu.com')
baidu
isOpen(baidu)




# P4
library(XML)

doc1 = xmlParse("http://www.xmlfiles.com/examples/plant_catalog.xml")

class(doc1)

doc2 = xmlParse("http://www.xmlfiles.com/examples/plant_catalog.xml",
                useInternalNodes = FALSE)
class(doc2)
is.list(doc2)

doc3 = xmlTreeParse(
     "http://www.xmlfiles.com/examples/plant_catalog.xml")
class(doc3)
is.list(doc3)

identical(doc2, doc3)


doc4 = xmlParse("http://www.r-project.org/mail.html", isHTML = TRUE)
class(doc4)

doc5 = htmlParse("http://www.r-project.org/mail.html")
class(doc5)

identical(doc4, doc5)

doc6 = htmlTreeParse("http://www.r-project.org/mail.html")
class(doc6)


# working with parsed ducuments
xml_string = c(
     '<?xml version="1.0" encoding="UTF-8"?>',
     '<movies>',
     '<movie mins="126" lang="eng">',
     '<title>Good Will Hunting</title>',
     '<director>',
     '<first_name>Gus</first_name>',
     '<last_name>Van Sant</last_name>',
     '</director>',
     '<year>1998</year>',
     '<genre>drama</genre>',
     '</movie>',
     '<movie mins="106" lang="spa">',
     '<title>Y tu mama tambien</title>',
     '<director>',
     '<first_name>Alfonso</first_name>',
     '<last_name>Cuaron</last_name>',
     '</director>',
     '<year>2001</year>',
     '<genre>drama</genre>',
     '</movie>',
     '</movies>')

movies_xml <- xmlParse(xml_string, asText = T)

class(movies_xml)

root <- xmlRoot(movies_xml)

root

class(root)

movies_children <- xmlChildren(root)

movies_children

class(movies_children)

goodwill <- movies_children[[1]]
goodwill

xmlName(goodwill)

xmlSize(goodwill)

xmlAttrs(goodwill)

xmlGetAttr(goodwill, name = 'lang')
xmlGetAttr(goodwill, name = 'mins')

xmlValue(goodwill)

xmlChildren(goodwill)

gusvan <- xmlChildren(goodwill)[[2]]
gusvan

xmlParent(gusvan)

xmlChildren(gusvan)


tumama <- movies_children[[2]]
tumama

xmlName(tumama)

xmlSize(tumama)

xmlAttrs(tumama)

xmlGetAttr(tumama, name = 'mins')
xmlGetAttr(tumama, name = 'lang')

tuma <- xmlChildren(tumama)[[2]]
tuma

xmlParent(tuma)
xmlChildren(tuma)

# Looping over node

sapply(movies_children, length)

sapply(movies_children, names)

sapply(movies_children, xmlSize)

sapply(movies_children, xmlAttrs)

sapply(movies_children, xmlValue)

xmlSApply(root, names)

xmlSApply(root, xmlSize)

xmlSApply(root, xmlAttrs)

xmlSApply(root, xmlValue)

root[[1]]

xmlSApply(root[[1]], length)

xmlSApply(root[[1]], xmlSize)

xmlSApply(root[[1]], xmlAttrs)

xmlSApply(root[[1]], xmlValue)

xmlSApply(root[[2]], length)

xmlSApply(root[[2]], xmlSize)

xmlSApply(root[[2]], xmlAttrs)

xmlSApply(root[[2]], xmlValue)

# XPath

# getNodeSet(doc, path)
# doc is an object of class "XMLInternalDocument" and path
# is a string giving the XPath expression to be evaluated

xml_string = c(
     '<?xml version="1.0" encoding="UTF-8"?>',
     '<movies>',
     '<movie mins="126" lang="eng">',
     '<title>Good Will Hunting</title>',
     '<director>',
     '<first_name>Gus</first_name>',
     '<last_name>Van Sant</last_name>',
     '</director>',
     '<year>1998</year>',
     '<genre>drama</genre>',
     '</movie>',
     '<movie mins="106" lang="spa">',
     '<title>Y tu mama tambien</title>',
     '<director>',
     '<first_name>Alfonso</first_name>',
     '<last_name>Cuaron</last_name>',
     '</director>',
     '<year>2001</year>',
     '<genre>drama</genre>',
     '</movie>',
     '</movies>')
movies_xml = xmlParse(xml_string, asText = TRUE)
movies_xml

getNodeSet(movies_xml, '/movies/movie')

getNodeSet(movies_xml, '//movie')

getNodeSet(movies_xml, '//title')

getNodeSet(movies_xml, '//year')

getNodeSet(movies_xml, '//director')

getNodeSet(movies_xml, '//movie[@lang = \'eng\']')

getNodeSet(movies_xml, '//movie[@lang = \'spa\']')

# case study

# R mailing lists url
mailing_url = "http://www.r-project.org/mail.html"
# parse html content
mailing_doc = htmlParse(mailing_url)
# check class 'HTMLInternalDocument'
class(mailing_doc)
# get root node
mailing_root = xmlRoot(mailing_doc)

xmlSize(mailing_root)

xmlSApply(mailing_root, xmlName)

xmlSApply(mailing_root, xmlSize)

xmlChildren(mailing_root)

mail_body <- xmlChildren(mailing_root)$body

xpathSApply(mail_body, 'h1')

xpathSApply(mail_body, 'h2')

?readHTMLTable

# get the html table 'Special Interest Groups'
sig_content = readHTMLTable(mailing_doc, which = 1)


