---
title: "Unit5HW_mmastrangeli"
author: "Mark Mastrangeli"
date: "9/17/2018"
output: 
  html_document:
    keep_md: true
---


This is the Unit5 HW TidyData
Our client is expecting a baby soon but is not sure what to name the child. In order to help them, we are going to import a seried of popular childrens names. After cleaning up the data, munging and merging; we will provide a summary of the 2015 and 2016 data showing the 10 most popular girls names and write them to a new CSV file, omiting the other data. 

#1.	Data Munging (30 points): Utilize yob2016.txt for this question. This file is a series of popular children’s names born in the year 2016 in the United States.  It consists of three columns with a first name, a gender, and the amount of children given that name.  However, the data is raw and will need cleaning to make it tidy and usable.
*a.	First, import the .txt file into R so you can process it.  Keep in mind this is not a CSV file.  You might have to open the file to see what you’re dealing with.  Assign the resulting data frame to an object, df, that consists of three columns with human-readable column names for each.
*b.	Display the summary and structure of df
*c.	Your client tells you that there is a problem with the raw file.  One name was entered twice and misspelled.  The client cannot remember which name it is; there are thousands he saw! But he did mention he accidentally put three y’s at the end of the name.  Write an R command to figure out which name it is and display it.
*d.	Upon finding the misspelled name, please remove this particular observation, as the client says it’s redundant.  Save the remaining dataset as an object: y2016 

```r
#a.	First, import the .txt file into R so you can process it.  Keep in mind this is not a CSV file.  You might have to open the file to see what you’re dealing with.  Assign the resulting data frame to an object, df, that consists of three columns with human-readable column names for each.


data_path1 <- "yob2015.txt"
data_path2 <- "yob2016.txt"

#read in data from 2015 and 2016 Birth name data

names2015 <- read.table(file = data_path1, header = FALSE, sep = ",", strip.white = TRUE, col.names =  c("Name", "Gender", "Frequency"))
names2016 <- read.table(file = data_path2, header = FALSE, sep = ";", strip.white = TRUE, col.names =  c("Name", "Gender", "Frequency"))

# *b. Display Summary and Structure of data frames
summary(names2016)
```

```
##       Name       Gender      Frequency      
##  Aalijah:    2   F:18758   Min.   :    5.0  
##  Aaliyan:    2   M:14111   1st Qu.:    7.0  
##  Aamari :    2             Median :   12.0  
##  Aarian :    2             Mean   :  110.7  
##  Aarin  :    2             3rd Qu.:   30.0  
##  Aaris  :    2             Max.   :19414.0  
##  (Other):32857
```

```r
str(names2016)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ Name     : Factor w/ 30295 levels "Aaban","Aabha",..: 9317 22546 3770 26409 12019 20596 6185 339 9298 11222 ...
##  $ Gender   : Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Frequency: int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```

```r
summary(names2015)
```

```
##       Name       Gender      Frequency      
##  Aalijah:    2   F:19054   Min.   :    5.0  
##  Aaliyah:    2   M:14009   1st Qu.:    7.0  
##  Aamari :    2             Median :   11.0  
##  Aarian :    2             Mean   :  111.4  
##  Aarion :    2             3rd Qu.:   30.0  
##  Aaron  :    2             Max.   :20415.0  
##  (Other):33051
```

```r
str(names2016)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ Name     : Factor w/ 30295 levels "Aaban","Aabha",..: 9317 22546 3770 26409 12019 20596 6185 339 9298 11222 ...
##  $ Gender   : Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Frequency: int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```

```r
#Find Duplicate name that has three y's and remove it. 
NameToRemove <- grep("yyy$", names2016$Name, value = TRUE)
NameToRemove
```

```
## [1] "Fionayyy"
```

```r
names2016_2 <- as.data.frame(names2016[!names2016$Name == NameToRemove, ])
names2015_2 <- as.data.frame(names2015[!names2015$Name == NameToRemove, ])


rm(NameToRemove)
rm(names2015)
rm(names2016)
rm(data_path1)
rm(data_path2)

#Save as new data frames. 
#names2016_2
#names2015_2
```


#2.	Data Merging (30 points): Utilize yob2015.txt for this question.  This file is similar to yob2016, but contains names, gender, and total children given that name for the year 2015.
*a.	Like 1a, please import the .txt file into R.  Look at the file before you do.  You might have to change some options to import it properly.  Again, please give the dataframe human-readable column names.  Assign the dataframe to y2015.  
*b.	Display the last ten rows in the dataframe.  Describe something you find interesting about these 10 rows.
*c.	Merge y2016 and y2015 by your Name column; assign it to final.  The client only cares about names that have data for both 2016 and 2015; there should be no NA values in either of your amount of children rows after merging.

```r
#a. 

tail(names2015_2, 10)
```

```
##         Name Gender Frequency
## 33054   Ziyu      M         5
## 33055   Zoel      M         5
## 33056  Zohar      M         5
## 33057 Zolton      M         5
## 33058   Zyah      M         5
## 33059 Zykell      M         5
## 33060 Zyking      M         5
## 33061  Zykir      M         5
## 33062  Zyrus      M         5
## 33063   Zyus      M         5
```

```r
tail(names2016_2, 10)
```

```
##         Name Gender Frequency
## 32860   Zinn      M         5
## 32861  Zirui      M         5
## 32862   Ziya      M         5
## 32863 Ziyang      M         5
## 32864   Zoel      M         5
## 32865 Zolton      M         5
## 32866 Zurich      M         5
## 32867 Zyahir      M         5
## 32868   Zyel      M         5
## 32869  Zylyn      M         5
```

```r
MergedNameData <- merge(names2015_2, names2016_2, by=c("Name", "Gender"), all = FALSE)

MergedNameData$Frequency <- MergedNameData$Frequency.x
MergedNameData$Frequency = (MergedNameData$Frequency + MergedNameData$Frequency.y)
MergedNameData_2 <- MergedNameData[c(1,2,5)]

MergedNameData_2 <- MergedNameData_2[order(-MergedNameData_2$Frequency), ]

head(MergedNameData, 10)
```

```
##         Name Gender Frequency.x Frequency.y Frequency
## 1      Aaban      M          15           9        24
## 2      Aabha      F           7           7        14
## 3  Aabriella      F           5          11        16
## 4      Aadam      M          22          18        40
## 5    Aadarsh      M          15          11        26
## 6      Aaden      M         297         194       491
## 7     Aadhav      M          31          28        59
## 8   Aadhavan      M           5           6        11
## 9      Aadhi      M          11           5        16
## 10   Aadhira      F           8          14        22
```

```r
head(MergedNameData_2, 10)
```

```
##           Name Gender Frequency
## 8290      Emma      F     39829
## 19886   Olivia      F     38884
## 19594     Noah      M     38609
## 16114     Liam      M     36468
## 23273   Sophia      F     33451
## 3252       Ava      F     32577
## 17715    Mason      M     31783
## 25241  William      M     31531
## 10993    Jacob      M     30330
## 10682 Isabella      F     30296
```

```r
#Pull Out Female and Male Names into seperate dataframes
MaleNameData <- MergedNameData_2[MergedNameData_2$Gender == 'M',]
FemaleNameData <- MergedNameData_2[MergedNameData_2$Gender == 'F',]

head(MaleNameData, 10)
```

```
##            Name Gender Frequency
## 19594      Noah      M     38609
## 16114      Liam      M     36468
## 17715     Mason      M     31783
## 25241   William      M     31531
## 10993     Jacob      M     30330
## 11436     James      M     29549
## 8613      Ethan      M     28807
## 18280   Michael      M     28394
## 3924   Benjamin      M     28239
## 1264  Alexander      M     27828
```

```r
head(FemaleNameData, 10)
```

```
##            Name Gender Frequency
## 8290       Emma      F     39829
## 19886    Olivia      F     38884
## 23273    Sophia      F     33451
## 3252        Ava      F     32577
## 10682  Isabella      F     30296
## 18247       Mia      F     29237
## 5493  Charlotte      F     24411
## 277     Abigail      F     24070
## 8273      Emily      F     22692
## 9980     Harper      F     21016
```

```r
print("Top 10 Female Baby Names for 2015 and 2016")                              
```

```
## [1] "Top 10 Female Baby Names for 2015 and 2016"
```

```r
head(FemaleNameData, 10)
```

```
##            Name Gender Frequency
## 8290       Emma      F     39829
## 19886    Olivia      F     38884
## 23273    Sophia      F     33451
## 3252        Ava      F     32577
## 10682  Isabella      F     30296
## 18247       Mia      F     29237
## 5493  Charlotte      F     24411
## 277     Abigail      F     24070
## 8273      Emily      F     22692
## 9980     Harper      F     21016
```

```r
rm(MergedNameData)
rm(names2016_2)
rm(names2015_2)
```



#3.	Data Summary (30 points): Utilize your data frame object final for this part.
*a.	Create a new column called “Total” in final that adds the amount of children in 2015 and 2016 together.  In those two years combined, how many people were given popular names?
*b.	Sort the data by Total.  What are the top 10 most popular names?
*c.	The client is expecting a girl!  Omit boys and give the top 10 most popular girl’s names.
*d.	Write these top 10 girl names and their Totals to a CSV file.  Leave out the other columns entirely.

```r
colnames(FemaleNameData) <- c("Name", "Gender", "Total")

head(FemaleNameData, 10)
```

```
##            Name Gender Total
## 8290       Emma      F 39829
## 19886    Olivia      F 38884
## 23273    Sophia      F 33451
## 3252        Ava      F 32577
## 10682  Isabella      F 30296
## 18247       Mia      F 29237
## 5493  Charlotte      F 24411
## 277     Abigail      F 24070
## 8273      Emily      F 22692
## 9980     Harper      F 21016
```

```r
write.csv(head(FemaleNameData, 100), file="TopFemaleNameData.csv", row.names = FALSE)
```
#4.	Upload to GitHub (10 points): Push at minimum your RMarkdown for this homework assignment and a Codebook to one of your GitHub repositories (you might place this in a Homework repo like last week).  The Codebook should contain a short definition of each object you create, and if creating multiple files, which file it is contained in.  You are welcome and encouraged to add other files—just make sure you have a description and directions that are helpful for the grader.

```r
#My RStudio is linked to my github. 
```





