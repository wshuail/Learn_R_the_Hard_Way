#lab1
library(XML);
url1<-"http://data.caixin.com/macro/macro_indicator_more.html?id=F0001&cpage=2&pageSize=30&url=macro_indicator_more.html#top";
url1<-htmlParse(url1,encoding="UTF-8")#把html文件读入r语言中并解析



url2<-"http://data.caixin.com/macro/macro_indicator_more.html?
id=F0001&cpage=2&pageSize=30&url=macro_indicator_more.html#top";
url2<-htmlParse(url1,encoding="UTF-8")
url2
identical(url1, url2)

#找结点
test <- getNodeSet(url,'//meta[@name]')#xpath语法找到html部件#显示的中文正常
#读取结点的内容：xmlValue内部参数只能是一个字符串
test_text_list<-sapply(test, xmlValue)#提取内容，多个的化以向量形式存储
test_text<-xmlValue(test[[2]])#把test的第2个中的内容提取出来=test_text_list[2].注意，即时test只有一组数据也要使用test[[1]],不可以直接使用test（不是字符串）
#读取结点的属性：xmlGetAttr内部参数只能是一个字符串
content1<-xmlGetAttr(test[[1]], "content")#读取test[[1]]中的content内容。注意直接用test不可以。#显示的中文不正常
content1<-iconv(content1,"UTF-8","gbk")#解决中文正常显示问题
content1

#lab2使用R语言爬取淘宝网站的笔记本商品价格和名称
library(XML);
url1<-"http://3c.taobao.com/detail.htm?spm=872.217037.254698.6.deIiSJ&spuid=205341228&cat=1101"
url2<-"http://3c.taobao.com/detail.htm?spm=872.217037.254698.11.deIiSJ&spuid=203228104&cat=1101"
read_taobao<-function(url){
        name_text<-""
        price_text<-""
        i<-1
        for(i_url in url){
                i_url2<-htmlParse(i_url,encoding="UTF-8")#读取html数据
                name<- getNodeSet(i_url2,"//div[@id='idetail']//div[@class='info-area']//div[@class='tlt clearfix']//h1")#通过xpath找到网页中的name
                #xpath://任意位置的  @是属性
                name_text_tmp<-xmlValue(name[[1]])#提取name的内容
                price<-getNodeSet(i_url2,"//div[@id='idetail']//div[@class='info-area']//div[@class='key-info']//span[@class='price']")#通过xpath找到网页中的price
                price_text_tmp<-xmlValue(price[[1]])#提取price的内容
                name_text[i]<-name_text_tmp
                price_text[i]<-price_text_tmp
                i<-i+1
        }
        data.frame(name=name_text,price=price_text)
}
url<-c(url1,url2)
read_taobao(url)