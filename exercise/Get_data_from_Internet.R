r_home = url('http://www.r-project.org/')
r_home
isOpen(r_home)

baidu = url('http://www.baidu.com')
baidu
isOpen(baidu)

moby_url = url('http://www.gutenberg.org/ebooks/2701.txt.utf-8')
moby_dick = readLines(moby_url, n=500)
moby_dick[1:5]

download.file('http://www.gutenberg.org/ebooks/2701.txt.utf-8', 'mobydick.txt')

cbdata = url('http://api.chesapeakebay.net/rest/DataHubRESTSrv/dhHelper.svc/getExtentData/FIPS/FIPS/CBP_PLANKDB')
cbdata

cbdata_url = 'http://api.chesapeakebay.net/rest/DataHubRESTSrv/getWQStationInformationOld.svc/HUCS8/ALL'
cbdata = getURL(cbdata_url)
cbdataset = read.table(textConnection(cbdata), header = TRUE)

alpha_xls = "http://www.lsi.upc.edu/ ̃belanche/Docencia/mineria/Practiques/alpha.xls"
sheetCount(alpha_xls)