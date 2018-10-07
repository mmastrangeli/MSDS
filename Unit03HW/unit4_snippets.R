#
#ggplot2::

#read_html


names = xpathSApply(doc, "//name", xmlValue)
names
price = xpathSApply(doc, "//price",xmlValue)
desc = xpathSApply(doc, "//description",xmlValue)
bfdf = data.frame(name = names, price = price, description = desc)

grepl(zipcode, )

#slice function for hw

