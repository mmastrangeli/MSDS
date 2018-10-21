---
title: "Unit 7"
author: "Solange GarciadeAlford"
date: "October 10, 2018"
output: 
  html_document:
    keep_md: true 
---



## Introduction

```r
### Executive Summary

### The data analisys is based on data provided by our data sourcing contracting company. The data provide a number of independent breweries located in the United States accompanied by a list of the beer products these breweries sell.  The analisys provides the answers to the questions of interest submitted with the analysis request, such as how many breweries are there in each state, highest acohol contents, highest bitternes, etc.

### We assgined some of our finest data scientists to this project to explore and report on these data which, we know, will be pivotal in your future business and marketing decisions.
```
## Questions of Interest

```r
## Q1 - How many brewries are present in each state?


#### We first loaded the data into the software tool, then our code finds the number of brewries by state. 
#### In order to find the number of brewries by state, we used the "tidyverse" package in conjunction with the plyr library.
#### Interestingly, we found that the maximum number of breweries in one particular state was 47, in the state of Colorado.

## The Beers dataset contains a list of 2410 US craft beers 
bedata <- read.csv("C:/Users/solan/documents/beers.csv")

## the Breweries dataset contains 558 US breweries. 
brdata <- read.csv("C:/Users/solan/documents/breweries.csv")


### Tables 1.1 and 1.2 display the structure of the imported data files
str(brdata)
```

```
## 'data.frame':	558 obs. of  4 variables:
##  $ Brew_ID: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Name   : Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 12 266 319 201 136 227 477 59 491 ...
##  $ City   : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 200 122 299 300 62 91 48 152 136 ...
##  $ State  : Factor w/ 51 levels " AK"," AL"," AR",..: 24 18 20 5 5 41 6 23 23 23 ...
```

```r
str(bedata)
```

```
## 'data.frame':	2410 obs. of  7 variables:
##  $ Name      : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 1638 577 1705 1842 1819 268 1160 758 1093 486 ...
##  $ Beer_ID   : int  1436 2265 2264 2263 2262 2261 2260 2259 2258 2131 ...
##  $ ABV       : num  0.05 0.066 0.071 0.09 0.075 0.077 0.045 0.065 0.055 0.086 ...
##  $ IBU       : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Brewery_id: int  409 178 178 178 178 178 178 178 178 178 ...
##  $ Style     : Factor w/ 100 levels "","Abbey Single Ale",..: 19 18 16 12 16 80 18 22 18 12 ...
##  $ Ounces    : num  12 12 12 12 12 12 12 12 12 12 ...
```

```r
options(repos="https://cran.rstudio.com" )

install.packages("tidyverse")
```

```
## Installing package into 'C:/Users/solan/Documents/R/win-library/3.5'
## (as 'lib' is unspecified)
```

```
## package 'tidyverse' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\solan\AppData\Local\Temp\Rtmpgz1vsP\downloaded_packages
```

```r
library(plyr)

countbreweries <- data.frame(count(brdata, c("State")))


### Table 1.3 displays the structure of the file with the count of brewries by state
str(countbreweries)
```

```
## 'data.frame':	51 obs. of  2 variables:
##  $ State: Factor w/ 51 levels " AK"," AL"," AR",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ freq : int  7 3 2 11 39 47 8 1 2 15 ...
```

```r
install.packages("ggplot2")
```

```
## Installing package into 'C:/Users/solan/Documents/R/win-library/3.5'
## (as 'lib' is unspecified)
```

```
## package 'ggplot2' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\solan\AppData\Local\Temp\Rtmpgz1vsP\downloaded_packages
```

```r
library(ggplot2)



##### Q1A - Display 1 shows how many breweries there are in each state

ggplot(data=countbreweries, aes(x=State, y=freq)) +   
geom_bar(aes(fill = freq), position = "dodge", stat="identity") +
theme(axis.text.x = element_text(face="bold" ,color="#393355", 
                           size=7, angle=90),
        axis.text.y = element_text(face="bold", color="#393355", 
                           size=10, angle=90)) +
geom_text(aes(label = freq), vjust = -0.3) +
ylab("Number of Breweries") +
xlab("State") +
labs(title = "                     Number of Breweries in each State") +
labs(caption = "(Display 1 - Based on data provided)")
```

![](UNIT7CASESTUDY_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
## Q2 - Merge beer data with the breweries data. Print the first 6 observations and the last s, ix observations to check the merged file.


#### The files were merged so that we could look at the data in one single file and allow us to provide answers to the additional questions of interest.


#### We changed the name of the column in the satesize data frame in preparation for merging the files, and used the merge function to join the files.  To provide a visual of the resulting file we printed the firt six rows and the last six rows.

names(brdata)[1] <- "Brewery_id"
str(brdata)
```

```
## 'data.frame':	558 obs. of  4 variables:
##  $ Brewery_id: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Name      : Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 12 266 319 201 136 227 477 59 491 ...
##  $ City      : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 200 122 299 300 62 91 48 152 136 ...
##  $ State     : Factor w/ 51 levels " AK"," AL"," AR",..: 24 18 20 5 5 41 6 23 23 23 ...
```

```r
##### Q2A Tables 2.1-2.3 show the structure, and the first and last 6 records of the new merged data.
mdata <- merge(brdata, bedata , by = "Brewery_id")

### Table 2.1
str(mdata)
```

```
## 'data.frame':	2410 obs. of  10 variables:
##  $ Brewery_id: int  1 1 1 1 1 1 2 2 2 2 ...
##  $ Name.x    : Factor w/ 551 levels "10 Barrel Brewing Company",..: 355 355 355 355 355 355 12 12 12 12 ...
##  $ City      : Factor w/ 384 levels "Abingdon","Abita Springs",..: 228 228 228 228 228 228 200 200 200 200 ...
##  $ State     : Factor w/ 51 levels " AK"," AL"," AR",..: 24 24 24 24 24 24 18 18 18 18 ...
##  $ Name.y    : Factor w/ 2305 levels "#001 Golden Amber Lager",..: 1640 1926 1525 802 1258 2185 71 458 1218 43 ...
##  $ Beer_ID   : int  2689 2688 2687 2692 2691 2690 2683 2686 2685 2684 ...
##  $ ABV       : num  0.06 0.06 0.056 0.045 0.049 0.048 0.042 0.08 0.125 0.077 ...
##  $ IBU       : int  38 25 47 50 26 19 42 68 80 25 ...
##  $ Style     : Factor w/ 100 levels "","Abbey Single Ale",..: 83 22 57 16 77 48 18 12 46 77 ...
##  $ Ounces    : num  16 16 16 16 16 16 16 16 16 16 ...
```

```r
### Table 2.2
head(mdata)
```

```
##   Brewery_id             Name.x        City State        Name.y Beer_ID
## 1          1 NorthGate Brewing  Minneapolis    MN       Pumpion    2689
## 2          1 NorthGate Brewing  Minneapolis    MN    Stronghold    2688
## 3          1 NorthGate Brewing  Minneapolis    MN   Parapet ESB    2687
## 4          1 NorthGate Brewing  Minneapolis    MN  Get Together    2692
## 5          1 NorthGate Brewing  Minneapolis    MN Maggie's Leap    2691
## 6          1 NorthGate Brewing  Minneapolis    MN    Wall's End    2690
##     ABV IBU                               Style Ounces
## 1 0.060  38                         Pumpkin Ale     16
## 2 0.060  25                     American Porter     16
## 3 0.056  47 Extra Special / Strong Bitter (ESB)     16
## 4 0.045  50                        American IPA     16
## 5 0.049  26                  Milk / Sweet Stout     16
## 6 0.048  19                   English Brown Ale     16
```

```r
### Table 2.3
tail(mdata)
```

```
##      Brewery_id                        Name.x          City State
## 2405        556         Ukiah Brewing Company         Ukiah    CA
## 2406        557       Butternuts Beer and Ale Garrattsville    NY
## 2407        557       Butternuts Beer and Ale Garrattsville    NY
## 2408        557       Butternuts Beer and Ale Garrattsville    NY
## 2409        557       Butternuts Beer and Ale Garrattsville    NY
## 2410        558 Sleeping Lady Brewing Company     Anchorage    AK
##                         Name.y Beer_ID   ABV IBU                   Style
## 2405             Pilsner Ukiah      98 0.055  NA         German Pilsener
## 2406         Porkslap Pale Ale      49 0.043  NA American Pale Ale (APA)
## 2407           Snapperhead IPA      51 0.068  NA            American IPA
## 2408         Moo Thunder Stout      50 0.049  NA      Milk / Sweet Stout
## 2409  Heinnieweisse Weissebier      52 0.049  NA              Hefeweizen
## 2410 Urban Wilderness Pale Ale      30 0.049  NA        English Pale Ale
##      Ounces
## 2405     12
## 2406     12
## 2407     12
## 2408     12
## 2409     12
## 2410     12
```

```r
##Q3 - Report the number of NA's in each column.

####  We also looked into each one of the fields to find the fields with missing data, this code also got us, not only a count of missing values, but a count of the fields with data. 

BreweryIDNA <- data.frame(count(mdata$Brewery_id == "NA"))
BreweryNameNA <- data.frame(count(mdata$Name.x == "NA"))
BreweryCiTyNA <- data.frame(count(mdata$City == "NA"))
BreweryStateNA <- data.frame(count(mdata$State == "NA"))
BeerNameNA <- data.frame(count(mdata$Name.y == "NA"))
BeerIDNA <- data.frame(count(mdata$Beer_ID == "NA"))
BeerABVNA <- data.frame(count(mdata$ABV == "NA"))
BeerIBUNA <- data.frame(count(mdata$IBU == "NA"))
BeerStyleNA <- data.frame(count(mdata$Style == "NA"))
BeerOZNA <- data.frame(count(mdata$Ounces == "NA"))


##### Q3A - Tables 3.1 - 3.10 show the values missing in our data by variable

### Table 3.1 - Number of rows where Brewery IDs are missing 
BreweryIDNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.2 - Number of rows where Brewery names are missing
BreweryNameNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.3 - Number of rows where the breweries' city is missing
BreweryCiTyNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.4 - Number of rows where the breweries' state is missing
BreweryStateNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.5 - Number of rows where beer names are missing
BeerNameNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.6 - Number of rows where beer ids are missing
BeerIDNA 
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.7 - Number of rows where ABV values are missing
BeerABVNA 
```

```
##       x freq
## 1 FALSE 2348
## 2    NA   62
```

```r
### Table 3.8 - Number of rows where IBU values are missing
BeerIBUNA 
```

```
##       x freq
## 1 FALSE 1405
## 2    NA 1005
```

```r
### Table 3.9 - Number of rows where the beer style is missing
BeerStyleNA
```

```
##       x freq
## 1 FALSE 2410
```

```r
### Table 3.10 - Number of rows where the beer oz measurement is missing
BeerOZNA
```

```
##       x freq
## 1 FALSE 2410
```

```r
##Q4 - Compute the median alcohol content and international bitterness unit for each state. 

#### The next question of interest was to find the median Alcohol by Volume of Beer and the median International bitternes unit for each one of the states and provide bar charts of the results.  

#### We first calculated the median with the aggregate function available in the stats package, we looked at the first and last rows of the data frames to verify the reults, and then we plotted these data using ggplot2.

install.packages("stats")
```

```
## Installing package into 'C:/Users/solan/Documents/R/win-library/3.5'
## (as 'lib' is unspecified)
```

```
## Warning: package 'stats' is not available (for R version 3.5.1)
```

```
## Warning: package 'stats' is a base package, and should not be updated
```

```r
library(stats)

median.ABV <- data.frame(aggregate(ABV ~ State, data = mdata, median))
median.IBU <- data.frame(aggregate(IBU ~ State, data = mdata, median))



####Q4Aa -  Tables 4.1-4.4 display the first and last 6 records of the ABV and IBU median data frames.

head(median.ABV)
```

```
##   State    ABV
## 1    AK 0.0560
## 2    AL 0.0600
## 3    AR 0.0520
## 4    AZ 0.0550
## 5    CA 0.0580
## 6    CO 0.0605
```

```r
tail(median.ABV)
```

```
##    State    ABV
## 46    VA 0.0565
## 47    VT 0.0550
## 48    WA 0.0555
## 49    WI 0.0520
## 50    WV 0.0620
## 51    WY 0.0500
```

```r
head(median.IBU)
```

```
##   State  IBU
## 1    AK 46.0
## 2    AL 43.0
## 3    AR 39.0
## 4    AZ 20.5
## 5    CA 42.0
## 6    CO 40.0
```

```r
tail(median.IBU)
```

```
##    State  IBU
## 45    VA 42.0
## 46    VT 30.0
## 47    WA 38.0
## 48    WI 19.0
## 49    WV 57.5
## 50    WY 21.0
```

```r
#### I built a new data frame by combining the median aggregate resulting data frames by state. This may not have been necessary since I plotted the data on separate charts.

medians.st <- merge(median.ABV, median.IBU , by = "State")
str(medians.st)
```

```
## 'data.frame':	50 obs. of  3 variables:
##  $ State: Factor w/ 51 levels " AK"," AL"," AR",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ ABV  : num  0.056 0.06 0.052 0.055 0.058 0.0605 0.06 0.0625 0.055 0.057 ...
##  $ IBU  : num  46 43 39 20.5 42 40 29 47.5 52 55 ...
```

```r
#####Q4Aa Display 2 shows the medians of International bitterness Unit by state.

ggplot(data=medians.st, aes(x=State, y=IBU )) +   
geom_bar(aes(fill = IBU), position = "dodge", stat="identity") +
labs(title = "                Median International Bitterness Unit in each State") +
labs(caption = "(Display 2 - Based on data provided)") +
theme(axis.text.x = element_text(face="bold" ,color="#993333", 
                           size=7, angle=90),
        axis.text.y = element_text(face="bold", color="#993333", 
                           size=10, angle=90)) +
geom_text(aes(label = IBU), vjust = 0.5, size=3, angle=90, face="bold")
```

```
## Warning: Ignoring unknown parameters: face
```

![](UNIT7CASESTUDY_files/figure-html/unnamed-chunk-2-2.png)<!-- -->

```r
#####Q4Ab -  Display 3 shows the median Alcohol by volumen of beat in each state

ggplot(data=medians.st, aes(x=State, y=ABV )) +   
geom_bar(aes(fill = ABV), position = "dodge", stat="identity") +
labs(title = "                Median Alcohol by Volume of Beer in each State") +
labs(caption = "(Display 3 - Based on data provided)") +
theme(axis.text.x = element_text(face="bold", color="#993333", 
                           size=7, angle=90),
        axis.text.y = element_text(face="bold", color="#993333", 
                           size=10, angle=90)) +
geom_text(aes(label = ABV), vjust = 0.5, size=3, angle=90, color="#993333", face="bold")
```

```
## Warning: Ignoring unknown parameters: face
```

![](UNIT7CASESTUDY_files/figure-html/unnamed-chunk-2-3.png)<!-- -->

```r
## Q5 -- Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?

#### To find out which state(s) have the maximum alcohol by volume and which states have the most bitter beer I used the max function and applied it to the respective variable in the medians.st table.  

#### Since the max function for ABV resulted in more than 1 value, i.e., there are 2 states that hold the max alcohol by volume value, I created a data frame to find the names of the states.  I utlized a similar technique to find the state with the max IBU value.


a <- max(medians.st$ABV)
b <- max(medians.st$IBU)
a
```

```
## [1] 0.0625
```

```r
b
```

```
## [1] 61
```

```r
c.df <- data.frame(which(medians.st$ABV == a))
c.df
```

```
##   which.medians.st.ABV....a.
## 1                          8
## 2                         18
```

```r
c.df1 <- c.df[1,1]
c.df2 <- c.df[2,1]
c.df1
```

```
## [1] 8
```

```r
c.df2
```

```
## [1] 18
```

```r
st.medABV1 <- medians.st[8,]
st.medABV2 <- medians.st[18,]
st.medABV1
```

```
##   State    ABV  IBU
## 8    DC 0.0625 47.5
```

```r
st.medABV2
```

```
##    State    ABV  IBU
## 18    KY 0.0625 31.5
```

```r
##### Q5Aa  Kentucky and Washington, D.C, have the highest median alcoholic content (ABV) beers. Refer to Display 3.

ci.df <- data.frame(which(medians.st$IBU == b))
ci.df
```

```
##   which.medians.st.IBU....b.
## 1                         22
```

```r
ci.df1 <- c.df[1,1]
ci.df1
```

```
## [1] 8
```

```r
st.medIBU <- medians.st[22,]
st.medIBU
```

```
##    State   ABV IBU
## 22    ME 0.051  61
```

```r
##### Q5Ab  Maine is the state with the highest median IBU beer. Refer to Display 2.





## Q6  - Summary statistics for the ABV variable.

#### to find out the summary statistices on the ABV variable I used the summary function to get the median, mean and minimum and max values. 

#### The ABV variable also has 62 rows out of 2410 rows where its value is null or N/A.  This may impact the results of the summary statistics and may not represent 100% accuracy.



##### Q6A  Table 6.1 displays the summary statistics of alcohol by volumen of the beers in our data.

### Table 6.1
summary(mdata$ABV)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00100 0.05000 0.05600 0.05977 0.06700 0.12800      62
```

```r
## Q7 - There is an apparent relationship between the bitterness of the beer and its alcoholic content? 
## Draw a scatter plot.

#### As requested, a scatter plot was generated to represent the relationship between the alcoholic content and the bitterness of the beers.  This time we used the originally created mdata data frame to draw the conclution on the relationship by brandname. 

#### I also found great scatterplot graphing tools on the Web, which I sued to build the plot.  We can find these tools at this link:

#### http://www.sthda.com/english/wiki/ggplot2-scatterplot-easy-scatter-plot-using-ggplot2-and-r-statistical-software

install.packages("devtools")
```

```
## Installing package into 'C:/Users/solan/Documents/R/win-library/3.5'
## (as 'lib' is unspecified)
```

```
## package 'devtools' successfully unpacked and MD5 sums checked
## 
## The downloaded binary packages are in
## 	C:\Users\solan\AppData\Local\Temp\Rtmpgz1vsP\downloaded_packages
```

```r
library(devtools)
install_github("easyGgplot2", "kassambara")
```

```
## Warning: Username parameter is deprecated. Please use kassambara/
## easyGgplot2
```

```
## Skipping install of 'easyGgplot2' from a github remote, the SHA1 (cb017c1c) has not changed since last install.
##   Use `force = TRUE` to force installation
```

```r
library(easyGgplot2)




##### Q7A Display 4 is a scatter plot to show the relationship between the Alcohol content by volume of beer versus the International Bitternes units.

ggplot2.scatterplot(data=mdata, xName='ABV', yName='IBU', mapping=aes(size = qsec), addRegLine=TRUE, regLineColor="red", mainTitle='                                        AVB versus IBU', xtitle="Alcohol by Volume of Beer", ytitle="International Bitterness Units", shape=23, size=2, fill="navy")
```

```
## Warning: Removed 1005 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 1005 rows containing missing values (geom_point).
```

![](UNIT7CASESTUDY_files/figure-html/unnamed-chunk-2-4.png)<!-- -->

## I





Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
