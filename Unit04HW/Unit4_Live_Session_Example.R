library(bitops)
library(RCurl)
library(XML)
library(stringi)
library(repmis)
library(rvest)
library(tidyr)
library(stringr)
library(ggplot2)



fileURL <- "https://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1"
doc <- readHTMLList(fileURL)

doc


data <- readHTMLTable(fileURL)
data

grepl()

#table.simpleTable.simpleCreditsTable
#table.cast_list