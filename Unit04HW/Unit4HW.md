---
title: "Unit4HW"
author: "Mark Mastrangeli"
date: "9/20/2018"
output: 
  html_document:
      keep_md: TRUE
---



```r
#Loading required libraries
library(XML)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(bitops)
library(stringi)
library(repmis)
library(rvest)
```

```
## Loading required package: xml2
```

```
## 
## Attaching package: 'rvest'
```

```
## The following object is masked from 'package:XML':
## 
##     xml
```

```r
library(tidyr)
library(stringr)
library(ggplot2)
library(tibble)
```


Unit 4 Homework

##Question 1: Harry Potter Cast (50%) 
*	a. In the IMDB, there are listings of full cast members for movies. Navigate to http://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1. Feel free to View Source to get a good idea of what the page looks like in code. 
*	b. Scrape the page with any R package that makes things easy for you. Of particular interest is the table of the Cast in order of crediting. Please scrape this table (you might have to fish it out of several of the tables from the page) and make it a data.frame() of the Cast in your R environment 
*	c. Clean up the table 
• It should not have blank observations or rows, a row that should be column names, or just ‘…’ 
• It should have intuitive column names (ideally 2 to start – Actor and Character) 
• In the film, Mr. Warwick plays two characters, which makes his row look a little weird. Please replace his character column with just “Griphook / Professor Filius Flitwick” to make it look better. 
**	• One row might result in “Rest of cast listed alphabetically” – remove this observation. 
	
*	d. Split the Actor’s name into two columns: FirstName and Surname. Keep in mind that some actors/actresses have middle names as well. Please make sure that the middle names are in the FirstName column, in addition to the first name (example: given the Actor Frank Jeffrey Stevenson, the FirstName column would say “Frank Jeffrey.”) 
	
*	e. Present the first 10 rows of the data.frame() – It should have only FirstName, Surname, and Character columns. 



#Question 1a
*In the IMDB, there are listings of full cast members for movies. Navigate to http://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1. Feel free to View Source to get a good idea of what the page looks like in code.

```r
#Store URL into variable to be used in function
HarryPotterURL <- "http://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1"
#Scrape URL into object
HarryPotterURL_Data <- read_html(HarryPotterURL, NOBLANKS=TRUE, NSCLEAN=TRUE)
HarryPotterURL_Data
```

```
## {xml_document}
## <html xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml">
## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset= ...
## [2] <body id="styleguide-v2" class="fixed">\n\n            <img height=" ...
```

#Question 1b Scrape the page and put it in a dataframe
*Scrape the page with any R package that makes things easy for you. Of particular interest is the table of the Cast in order of crediting. Please scrape this table (you might have to fish it out of several of the tables from the page) and make it a data.frame() of the Cast in your R environment 

```r
#Parse HarryPotterURL_Data into data table
HarryPotterCastData <- html_text(html_nodes(HarryPotterURL_Data, ".odd, .even, tr.itemprop"))
names(HarryPotterCastData) <- c("Actor")
HarryPotterCharacters <- html_text(html_nodes(HarryPotterURL_Data, ".character, tr.itemprop"))

HarryPotterCharacters <- gsub("\n ", "", HarryPotterCharacters)
HarryPotterCharacters <- gsub("        ", "", HarryPotterCharacters)
HarryPotterCharacters <- gsub("    ", "", HarryPotterCharacters)
HarryPotterCharacters <- gsub("  ", "", HarryPotterCharacters)
HarryPotterCharacters <- as.data.frame(HarryPotterCharacters)


HarryPotterCastData <- gsub("\n ", "", HarryPotterCastData)
HarryPotterCastData <- gsub("  ", "", HarryPotterCastData)
HarryPotterCastData <- gsub("<NA>", "", HarryPotterCastData)
HarryPotterCastData <- as.data.frame(str_extract(HarryPotterCastData, "(.*) ([^ ]+)$"))
HarryPotterCastData <- slice(HarryPotterCastData, -155:-159)
HarryPotterCastData
```

```
##                          str_extract(HarryPotterCastData, "(.*) ([^ ]+)$")
## 1                                         Ralph Fiennes ... Lord Voldemort
## 2                            Michael Gambon ... Professor Albus Dumbledore
## 3                                 Alan Rickman ... Professor Severus Snape
## 4                                        Daniel Radcliffe ... Harry Potter
## 5                                             Rupert Grint ... Ron Weasley
## 6                                         Emma Watson ... Hermione Granger
## 7                                           Evanna Lynch ... Luna Lovegood
## 8                                        Domhnall Gleeson ... Bill Weasley
## 9                                        Clémence Poésy ... Fleur Delacour
## 10                  Warwick Davis ... Griphook / Professor Filius Flitwick
## 11                                                John Hurt ... Ollivander
## 12                            Helena Bonham Carter ... Bellatrix Lestrange
## 13                                             Graham Duff ... Death Eater
## 14                                    Anthony Allgood ... Gringotts' Guard
## 15                                  Rusty Goffe ... Aged Gringotts' Goblin
## 16                                                      Jon Key ... Bogrod
## 17                                    Kelly Macdonald ... Helena Ravenclaw
## 18                                          Jason Isaacs ... Lucius Malfoy
## 19                                       Helen McCrory ... Narcissa Malfoy
## 20                                             Tom Felton ... Draco Malfoy
## 21                                      Ian Peck ... Hogsmeade Death Eater
## 22         Benn Northover ... Hogsmeade Death Eater(as Benjamin Northover)
## 23                                   Ciarán Hinds ... Aberforth Dumbledore
## 24                                    Hebe Beardsall ... Ariana Dumbledore
## 25                                    Matthew Lewis ... Neville Longbottom
## 26                                        Devon Murray ... Seamus Finnigan
## 27                                          Jessie Cave ... Lavender Brown
## 28                                             Afshan Azad ... Padma Patil
## 29                                           Isabella Laughland ... Leanne
## 30                                           Anna Shaffer ... Romilda Vane
## 31                                        Georgina Leonidas ... Katie Bell
## 32                                      Freddie Stroma ... Cormac McLaggen
## 33                            Alfred Enoch ... Dean Thomas(as Alfie Enoch)
## 34                                               Katie Leung ... Cho Chang
## 35                                               William Melling ... Nigel
## 36                                  Sian Grace Phillips ... Screaming Girl
## 37                                         Bonnie Wright ... Ginny Weasley
## 38                                          Ralph Ineson ... Amycus Carrow
## 39                                         Suzanne Toase ... Alecto Carrow
## 40                           Maggie Smith ... Professor Minerva McGonagall
## 41                             Jim Broadbent ... Professor Horace Slughorn
## 42                                      Scarlett Byrne ... Pansy Parkinson
## 43                                          Josh Herdman ... Gregory Goyle
## 44                                         Louis Cordice ... Blaise Zabini
## 45                                             Amber Evans ... Twin Girl 1
## 46                                              Ruby Evans ... Twin Girl 2
## 47                            Miriam Margolyes ... Professor Pomona Sprout
## 48                                           Gemma Jones ... Madam Pomfrey
## 49                                  George Harris ... Kingsley Shacklebolt
## 50                                           David Thewlis ... Remus Lupin
## 51                                         Julie Walters ... Molly Weasley
## 52                                        Mark Williams ... Arthur Weasley
## 53                                           James Phelps ... Fred Weasley
## 54                                        Oliver Phelps ... George Weasley
## 55                                          Chris Rankin ... Percy Weasley
## 56                                           David Bradley ... Argus Filch
## 57                                           Guy Henry ... Pius Thicknesse
## 58                                                  Nick Moran ... Scabior
## 59                                       Natalia Tena ... Nymphadora Tonks
## 60                                                   Phil Wright ... Giant
## 61                                                   Garry Sayer ... Giant
## 62                                                   Tony Adkins ... Giant
## 63                                         Dave Legeno ... Fenrir Greyback
## 64                                         Penelope McGhie ... Death Eater
## 65                             Emma Thompson ... Professor Sybil Trelawney
## 66                                Ellie Darcey-Alden ... Young Lily Potter
## 67                              Ariella Paradise ... Young Petunia Dursley
## 68                                 Benedict Clarke ... Young Severus Snape
## 69                              Leslie Phillips ... The Sorting Hat(voice)
## 70                                   Alfie McIlwain ... Young James Potter
## 71                                    Rohan Gotobed ... Young Sirius Black
## 72                                    Geraldine Somerville ... Lily Potter
## 73                                         Adrian Rawlins ... James Potter
## 74                                     Toby Papworth ... Baby Harry Potter
## 75                                              Timothy Spall ... Wormtail
## 76                                       Robbie Coltrane ... Rubeus Hagrid
## 77                                            Gary Oldman ... Sirius Black
## 78                                           Peter G. Reed ... Death Eater
## 79                                            Judith Sharp ... Death Eater
## 80                                            Emil Hostina ... Death Eater
## 81                           Bob Yves Van Hellenberg Hubar ... Death Eater
## 82                                        Granville Saxton ... Death Eater
## 83                                            Tony Kirwood ... Death Eater
## 84                                          Ashley McGuire ... Death Eater
## 85                  Arthur Bowen ... Albus Severus Potter - 19 Years Later
## 86                    Daphne de Beistegui ... Lily Potter - 19 Years Later
## 87            Will Dunn ... James Potter - 19 Years Later(as William Dunn)
## 88                         Jade Gordon ... Astoria Malfoy - 19 Years Later
## 89                     Bertie Gilbert ... Scorpius Malfoy - 19 Years Later
## 90                         Helena Barlow ... Rose Weasley - 19 Years Later
## 91                           Ryan Turner ... Hugo Weasley - 19 Years Later
## 92               Jon Campling ... Death Eater in Gringotts(scenes deleted)
## 93                         Karen Anderson ... Gringotts Goblin(uncredited)
## 94                             Michael Aston ... Wizard Parent(uncredited)
## 95                 Michael Henbury Ballan ... Gringotts Goblin(uncredited)
## 96                         Lauren Barrand ... Gringotts Goblin(uncredited)
## 97                David Barron ... Wizard with Dog in Painting(uncredited)
## 98                           Josh Bennett ... Gringotts Goblin(uncredited)
## 99                                 Johann Benét ... Deatheater(uncredited)
## 100                           Sean Biggerstaff ... Oliver Wood(uncredited)
## 101                          Jada Brevett ... Hogwarts Student(uncredited)
## 102                                   Ben Champniss ... Parent(uncredited)
## 103                                Collet Collins ... Snatcher(uncredited)
## 104                          Dean Conder ... Slytherin Student(uncredited)
## 105                             Christoph Cordell ... Snatcher(uncredited)
## 106 Christian Coulson ... Tom Marvolo Riddle(archive footage) (uncredited)
## 107                   Gioacchino Jim Cuffaro ... Wizard Parent(uncredited)
## 108                             Valerie Dane ... Wizard Parent(uncredited)
## 109                                 Paul Davies ... Deatheater(uncredited)
## 110                                 Sharon Day ... Death Eater(uncredited)
## 111                  Sarah-Jane De Crespigny ... Wizard Parent(uncredited)
## 112                             David Decio ... Chief Snatcher(uncredited)
## 113                            Sheri Desbaux ... Wizard parent(uncredited)
## 114                       Ninette Finch ... Augusta Longbottom(uncredited)
## 115               Grace Meurisse Francis ... Senior Gryffindor(uncredited)
## 116                      Sean Francis George ... Wizard Parent(uncredited)
## 117                         Diane Gibbins ... Gringotts Goblin(uncredited)
## 118                       Rosalie Gilmore ... Ravenclaw Senior(uncredited)
## 119                                 Rich Goble ... Death Eater(uncredited)
## 120                  Hattie Gotobed ... Young Girl in Epilogue(uncredited)
## 121          Melissa Gotobed ... Hogwart's First Year Epilogue(uncredited)
## 122                    Natalie Harrison ... Gryffindor Student(uncredited)
## 123 Ian Hart ... Professor Quirinus Quirrell(archive footage) (uncredited)
## 124            Stephen Hawke ... Wedding Guest (The Weasley's)(uncredited)
## 125                 David Heyman ... Dining Wizard in Painting(uncredited)
## 126 Harper Heyman ... Baby of Dining Wizard Family in Portrait(uncredited)
## 127                       Matthew Hodgkin ... Hogwarts Student(uncredited)
## 128                       Steven Hopwood ... One-Legged Wizard(uncredited)
## 129                                 Joe Kallis ... Death Eater(uncredited)
## 130                           Gemma Kayla ... Ravenclaw Senior(uncredited)
## 131                               Hrvoje Klecz ... Death Eater(uncredited)
## 132                         Maxwell Laird ... Gringotts Goblin(uncredited)
## 133                      Debra Leigh-Taylor ... Wizard Teacher(uncredited)
## 134                        Christina Low ... Ravenclaw Student(uncredited)
## 135                             Sarah Lowe ... Ministry Wizard(uncredited)
## 136                      Jonathan Massahi ... Hogwarts Student(uncredited)
## 137                              Tony Montalbano ... Passenger(uncredited)
## 138                          Sha'ori Morris ... Slytherin Girl(uncredited)
## 139                              Luke Newberry ... Teddy Lupin(uncredited)
## 140                           Lisa Osmond ... Gringotts Goblin(uncredited)
## 141                          Elisabeth Roberts ... Death Eater(uncredited)
## 142                         Keijo Salmela ... Gringotts Goblin(uncredited)
## 143                        Joshua Savary ... Ravenclaw Student(uncredited)
## 144                           Mark Sealey ... Gringotts Goblin(uncredited)
## 145                             Arti Shah ... Gringotts Goblin(uncredited)
## 146                               Glen Stanway ... Death Eater(uncredited)
## 147                           Albert Tang ... Hogwarts Teacher(uncredited)
## 148                      Richard Trinder ... Augustus Rookwood(uncredited)
## 149                                Nick Turner ... Death Eater(uncredited)
## 150                         Aaron Virdee ... Gryffindor Senior(uncredited)
## 151                     John Warman ... Railway Station Porter(uncredited)
## 152                     Spencer Wilding ... Knight of Hogwarts(uncredited)
## 153                            Amy Wiles ... Slytherin Student(uncredited)
## 154                     Thomas Williamson ... Hogwarts Student(uncredited)
```

```r
HarryPotterCastData <- cbind.data.frame(HarryPotterCastData, HarryPotterCharacters)

names(HarryPotterCastData) <- c("Actors", "Characters")
HarryPotterCastData
```

```
##                                                                     Actors
## 1                                         Ralph Fiennes ... Lord Voldemort
## 2                            Michael Gambon ... Professor Albus Dumbledore
## 3                                 Alan Rickman ... Professor Severus Snape
## 4                                        Daniel Radcliffe ... Harry Potter
## 5                                             Rupert Grint ... Ron Weasley
## 6                                         Emma Watson ... Hermione Granger
## 7                                           Evanna Lynch ... Luna Lovegood
## 8                                        Domhnall Gleeson ... Bill Weasley
## 9                                        Clémence Poésy ... Fleur Delacour
## 10                  Warwick Davis ... Griphook / Professor Filius Flitwick
## 11                                                John Hurt ... Ollivander
## 12                            Helena Bonham Carter ... Bellatrix Lestrange
## 13                                             Graham Duff ... Death Eater
## 14                                    Anthony Allgood ... Gringotts' Guard
## 15                                  Rusty Goffe ... Aged Gringotts' Goblin
## 16                                                      Jon Key ... Bogrod
## 17                                    Kelly Macdonald ... Helena Ravenclaw
## 18                                          Jason Isaacs ... Lucius Malfoy
## 19                                       Helen McCrory ... Narcissa Malfoy
## 20                                             Tom Felton ... Draco Malfoy
## 21                                      Ian Peck ... Hogsmeade Death Eater
## 22         Benn Northover ... Hogsmeade Death Eater(as Benjamin Northover)
## 23                                   Ciarán Hinds ... Aberforth Dumbledore
## 24                                    Hebe Beardsall ... Ariana Dumbledore
## 25                                    Matthew Lewis ... Neville Longbottom
## 26                                        Devon Murray ... Seamus Finnigan
## 27                                          Jessie Cave ... Lavender Brown
## 28                                             Afshan Azad ... Padma Patil
## 29                                           Isabella Laughland ... Leanne
## 30                                           Anna Shaffer ... Romilda Vane
## 31                                        Georgina Leonidas ... Katie Bell
## 32                                      Freddie Stroma ... Cormac McLaggen
## 33                            Alfred Enoch ... Dean Thomas(as Alfie Enoch)
## 34                                               Katie Leung ... Cho Chang
## 35                                               William Melling ... Nigel
## 36                                  Sian Grace Phillips ... Screaming Girl
## 37                                         Bonnie Wright ... Ginny Weasley
## 38                                          Ralph Ineson ... Amycus Carrow
## 39                                         Suzanne Toase ... Alecto Carrow
## 40                           Maggie Smith ... Professor Minerva McGonagall
## 41                             Jim Broadbent ... Professor Horace Slughorn
## 42                                      Scarlett Byrne ... Pansy Parkinson
## 43                                          Josh Herdman ... Gregory Goyle
## 44                                         Louis Cordice ... Blaise Zabini
## 45                                             Amber Evans ... Twin Girl 1
## 46                                              Ruby Evans ... Twin Girl 2
## 47                            Miriam Margolyes ... Professor Pomona Sprout
## 48                                           Gemma Jones ... Madam Pomfrey
## 49                                  George Harris ... Kingsley Shacklebolt
## 50                                           David Thewlis ... Remus Lupin
## 51                                         Julie Walters ... Molly Weasley
## 52                                        Mark Williams ... Arthur Weasley
## 53                                           James Phelps ... Fred Weasley
## 54                                        Oliver Phelps ... George Weasley
## 55                                          Chris Rankin ... Percy Weasley
## 56                                           David Bradley ... Argus Filch
## 57                                           Guy Henry ... Pius Thicknesse
## 58                                                  Nick Moran ... Scabior
## 59                                       Natalia Tena ... Nymphadora Tonks
## 60                                                   Phil Wright ... Giant
## 61                                                   Garry Sayer ... Giant
## 62                                                   Tony Adkins ... Giant
## 63                                         Dave Legeno ... Fenrir Greyback
## 64                                         Penelope McGhie ... Death Eater
## 65                             Emma Thompson ... Professor Sybil Trelawney
## 66                                Ellie Darcey-Alden ... Young Lily Potter
## 67                              Ariella Paradise ... Young Petunia Dursley
## 68                                 Benedict Clarke ... Young Severus Snape
## 69                              Leslie Phillips ... The Sorting Hat(voice)
## 70                                   Alfie McIlwain ... Young James Potter
## 71                                    Rohan Gotobed ... Young Sirius Black
## 72                                    Geraldine Somerville ... Lily Potter
## 73                                         Adrian Rawlins ... James Potter
## 74                                     Toby Papworth ... Baby Harry Potter
## 75                                              Timothy Spall ... Wormtail
## 76                                       Robbie Coltrane ... Rubeus Hagrid
## 77                                            Gary Oldman ... Sirius Black
## 78                                           Peter G. Reed ... Death Eater
## 79                                            Judith Sharp ... Death Eater
## 80                                            Emil Hostina ... Death Eater
## 81                           Bob Yves Van Hellenberg Hubar ... Death Eater
## 82                                        Granville Saxton ... Death Eater
## 83                                            Tony Kirwood ... Death Eater
## 84                                          Ashley McGuire ... Death Eater
## 85                  Arthur Bowen ... Albus Severus Potter - 19 Years Later
## 86                    Daphne de Beistegui ... Lily Potter - 19 Years Later
## 87            Will Dunn ... James Potter - 19 Years Later(as William Dunn)
## 88                         Jade Gordon ... Astoria Malfoy - 19 Years Later
## 89                     Bertie Gilbert ... Scorpius Malfoy - 19 Years Later
## 90                         Helena Barlow ... Rose Weasley - 19 Years Later
## 91                           Ryan Turner ... Hugo Weasley - 19 Years Later
## 92               Jon Campling ... Death Eater in Gringotts(scenes deleted)
## 93                         Karen Anderson ... Gringotts Goblin(uncredited)
## 94                             Michael Aston ... Wizard Parent(uncredited)
## 95                 Michael Henbury Ballan ... Gringotts Goblin(uncredited)
## 96                         Lauren Barrand ... Gringotts Goblin(uncredited)
## 97                David Barron ... Wizard with Dog in Painting(uncredited)
## 98                           Josh Bennett ... Gringotts Goblin(uncredited)
## 99                                 Johann Benét ... Deatheater(uncredited)
## 100                           Sean Biggerstaff ... Oliver Wood(uncredited)
## 101                          Jada Brevett ... Hogwarts Student(uncredited)
## 102                                   Ben Champniss ... Parent(uncredited)
## 103                                Collet Collins ... Snatcher(uncredited)
## 104                          Dean Conder ... Slytherin Student(uncredited)
## 105                             Christoph Cordell ... Snatcher(uncredited)
## 106 Christian Coulson ... Tom Marvolo Riddle(archive footage) (uncredited)
## 107                   Gioacchino Jim Cuffaro ... Wizard Parent(uncredited)
## 108                             Valerie Dane ... Wizard Parent(uncredited)
## 109                                 Paul Davies ... Deatheater(uncredited)
## 110                                 Sharon Day ... Death Eater(uncredited)
## 111                  Sarah-Jane De Crespigny ... Wizard Parent(uncredited)
## 112                             David Decio ... Chief Snatcher(uncredited)
## 113                            Sheri Desbaux ... Wizard parent(uncredited)
## 114                       Ninette Finch ... Augusta Longbottom(uncredited)
## 115               Grace Meurisse Francis ... Senior Gryffindor(uncredited)
## 116                      Sean Francis George ... Wizard Parent(uncredited)
## 117                         Diane Gibbins ... Gringotts Goblin(uncredited)
## 118                       Rosalie Gilmore ... Ravenclaw Senior(uncredited)
## 119                                 Rich Goble ... Death Eater(uncredited)
## 120                  Hattie Gotobed ... Young Girl in Epilogue(uncredited)
## 121          Melissa Gotobed ... Hogwart's First Year Epilogue(uncredited)
## 122                    Natalie Harrison ... Gryffindor Student(uncredited)
## 123 Ian Hart ... Professor Quirinus Quirrell(archive footage) (uncredited)
## 124            Stephen Hawke ... Wedding Guest (The Weasley's)(uncredited)
## 125                 David Heyman ... Dining Wizard in Painting(uncredited)
## 126 Harper Heyman ... Baby of Dining Wizard Family in Portrait(uncredited)
## 127                       Matthew Hodgkin ... Hogwarts Student(uncredited)
## 128                       Steven Hopwood ... One-Legged Wizard(uncredited)
## 129                                 Joe Kallis ... Death Eater(uncredited)
## 130                           Gemma Kayla ... Ravenclaw Senior(uncredited)
## 131                               Hrvoje Klecz ... Death Eater(uncredited)
## 132                         Maxwell Laird ... Gringotts Goblin(uncredited)
## 133                      Debra Leigh-Taylor ... Wizard Teacher(uncredited)
## 134                        Christina Low ... Ravenclaw Student(uncredited)
## 135                             Sarah Lowe ... Ministry Wizard(uncredited)
## 136                      Jonathan Massahi ... Hogwarts Student(uncredited)
## 137                              Tony Montalbano ... Passenger(uncredited)
## 138                          Sha'ori Morris ... Slytherin Girl(uncredited)
## 139                              Luke Newberry ... Teddy Lupin(uncredited)
## 140                           Lisa Osmond ... Gringotts Goblin(uncredited)
## 141                          Elisabeth Roberts ... Death Eater(uncredited)
## 142                         Keijo Salmela ... Gringotts Goblin(uncredited)
## 143                        Joshua Savary ... Ravenclaw Student(uncredited)
## 144                           Mark Sealey ... Gringotts Goblin(uncredited)
## 145                             Arti Shah ... Gringotts Goblin(uncredited)
## 146                               Glen Stanway ... Death Eater(uncredited)
## 147                           Albert Tang ... Hogwarts Teacher(uncredited)
## 148                      Richard Trinder ... Augustus Rookwood(uncredited)
## 149                                Nick Turner ... Death Eater(uncredited)
## 150                         Aaron Virdee ... Gryffindor Senior(uncredited)
## 151                     John Warman ... Railway Station Porter(uncredited)
## 152                     Spencer Wilding ... Knight of Hogwarts(uncredited)
## 153                            Amy Wiles ... Slytherin Student(uncredited)
## 154                     Thomas Williamson ... Hogwarts Student(uncredited)
##                                                      Characters
## 1                                               Lord Voldemort 
## 2                                   Professor Albus Dumbledore 
## 3                                      Professor Severus Snape 
## 4                                                 Harry Potter 
## 5                                                  Ron Weasley 
## 6                                             Hermione Granger 
## 7                                                Luna Lovegood 
## 8                                                 Bill Weasley 
## 9                                               Fleur Delacour 
## 10                        Griphook / Professor Filius Flitwick 
## 11                                                  Ollivander 
## 12                                         Bellatrix Lestrange 
## 13                                                 Death Eater 
## 14                                            Gringotts' Guard 
## 15                                      Aged Gringotts' Goblin 
## 16                                                      Bogrod 
## 17                                            Helena Ravenclaw 
## 18                                               Lucius Malfoy 
## 19                                             Narcissa Malfoy 
## 20                                                Draco Malfoy 
## 21                                       Hogsmeade Death Eater 
## 22                Hogsmeade Death Eater(as Benjamin Northover) 
## 23                                        Aberforth Dumbledore 
## 24                                           Ariana Dumbledore 
## 25                                          Neville Longbottom 
## 26                                             Seamus Finnigan 
## 27                                              Lavender Brown 
## 28                                                 Padma Patil 
## 29                                                      Leanne 
## 30                                                Romilda Vane 
## 31                                                  Katie Bell 
## 32                                             Cormac McLaggen 
## 33                                 Dean Thomas(as Alfie Enoch) 
## 34                                                   Cho Chang 
## 35                                                       Nigel 
## 36                                              Screaming Girl 
## 37                                               Ginny Weasley 
## 38                                               Amycus Carrow 
## 39                                               Alecto Carrow 
## 40                                Professor Minerva McGonagall 
## 41                                   Professor Horace Slughorn 
## 42                                             Pansy Parkinson 
## 43                                               Gregory Goyle 
## 44                                               Blaise Zabini 
## 45                                                 Twin Girl 1 
## 46                                                 Twin Girl 2 
## 47                                     Professor Pomona Sprout 
## 48                                               Madam Pomfrey 
## 49                                        Kingsley Shacklebolt 
## 50                                                 Remus Lupin 
## 51                                               Molly Weasley 
## 52                                              Arthur Weasley 
## 53                                                Fred Weasley 
## 54                                              George Weasley 
## 55                                               Percy Weasley 
## 56                                                 Argus Filch 
## 57                                             Pius Thicknesse 
## 58                                                     Scabior 
## 59                                            Nymphadora Tonks 
## 60                                                       Giant 
## 61                                                       Giant 
## 62                                                       Giant 
## 63                                             Fenrir Greyback 
## 64                                                 Death Eater 
## 65                                   Professor Sybil Trelawney 
## 66                                           Young Lily Potter 
## 67                                       Young Petunia Dursley 
## 68                                         Young Severus Snape 
## 69                                      The Sorting Hat(voice) 
## 70                                          Young James Potter 
## 71                                          Young Sirius Black 
## 72                                                 Lily Potter 
## 73                                                James Potter 
## 74                                           Baby Harry Potter 
## 75                                                    Wormtail 
## 76                                               Rubeus Hagrid 
## 77                                                Sirius Black 
## 78                                                 Death Eater 
## 79                                                 Death Eater 
## 80                                                 Death Eater 
## 81                                                 Death Eater 
## 82                                                 Death Eater 
## 83                                                 Death Eater 
## 84                                                 Death Eater 
## 85                       Albus Severus Potter - 19 Years Later 
## 86                                Lily Potter - 19 Years Later 
## 87              James Potter - 19 Years Later(as William Dunn) 
## 88                             Astoria Malfoy - 19 Years Later 
## 89                            Scorpius Malfoy - 19 Years Later 
## 90                               Rose Weasley - 19 Years Later 
## 91                               Hugo Weasley - 19 Years Later 
## 92                    Death Eater in Gringotts(scenes deleted) 
## 93                                Gringotts Goblin(uncredited) 
## 94                                   Wizard Parent(uncredited) 
## 95                                Gringotts Goblin(uncredited) 
## 96                                Gringotts Goblin(uncredited) 
## 97                     Wizard with Dog in Painting(uncredited) 
## 98                                Gringotts Goblin(uncredited) 
## 99                                      Deatheater(uncredited) 
## 100                                    Oliver Wood(uncredited) 
## 101                               Hogwarts Student(uncredited) 
## 102                                         Parent(uncredited) 
## 103                                       Snatcher(uncredited) 
## 104                              Slytherin Student(uncredited) 
## 105                                       Snatcher(uncredited) 
## 106           Tom Marvolo Riddle(archive footage) (uncredited) 
## 107                                  Wizard Parent(uncredited) 
## 108                                  Wizard Parent(uncredited) 
## 109                                     Deatheater(uncredited) 
## 110                                    Death Eater(uncredited) 
## 111                                  Wizard Parent(uncredited) 
## 112                                 Chief Snatcher(uncredited) 
## 113                                  Wizard parent(uncredited) 
## 114                             Augusta Longbottom(uncredited) 
## 115                              Senior Gryffindor(uncredited) 
## 116                                  Wizard Parent(uncredited) 
## 117                               Gringotts Goblin(uncredited) 
## 118                               Ravenclaw Senior(uncredited) 
## 119                                    Death Eater(uncredited) 
## 120                         Young Girl in Epilogue(uncredited) 
## 121                  Hogwart's First Year Epilogue(uncredited) 
## 122                             Gryffindor Student(uncredited) 
## 123  Professor Quirinus Quirrell(archive footage) (uncredited) 
## 124                  Wedding Guest (The Weasley's)(uncredited) 
## 125                      Dining Wizard in Painting(uncredited) 
## 126       Baby of Dining Wizard Family in Portrait(uncredited) 
## 127                               Hogwarts Student(uncredited) 
## 128                              One-Legged Wizard(uncredited) 
## 129                                    Death Eater(uncredited) 
## 130                               Ravenclaw Senior(uncredited) 
## 131                                    Death Eater(uncredited) 
## 132                               Gringotts Goblin(uncredited) 
## 133                                 Wizard Teacher(uncredited) 
## 134                              Ravenclaw Student(uncredited) 
## 135                                Ministry Wizard(uncredited) 
## 136                               Hogwarts Student(uncredited) 
## 137                                      Passenger(uncredited) 
## 138                                 Slytherin Girl(uncredited) 
## 139                                    Teddy Lupin(uncredited) 
## 140                               Gringotts Goblin(uncredited) 
## 141                                    Death Eater(uncredited) 
## 142                               Gringotts Goblin(uncredited) 
## 143                              Ravenclaw Student(uncredited) 
## 144                               Gringotts Goblin(uncredited) 
## 145                               Gringotts Goblin(uncredited) 
## 146                                    Death Eater(uncredited) 
## 147                               Hogwarts Teacher(uncredited) 
## 148                              Augustus Rookwood(uncredited) 
## 149                                    Death Eater(uncredited) 
## 150                              Gryffindor Senior(uncredited) 
## 151                         Railway Station Porter(uncredited) 
## 152                             Knight of Hogwarts(uncredited) 
## 153                              Slytherin Student(uncredited) 
## 154                               Hogwarts Student(uncredited)
```

#Question 1c Clean up the table 
*It should not have blank observations or rows, a row that should be column names, or just ‘…’ 
*It should have intuitive column names (ideally 2 to start – Actor and Character) 
*In the film, Mr. Warwick plays two characters, which makes his row look a little weird. Please replace his character column with just “Griphook / Professor Filius Flitwick” to make it look better. 
*One row might result in “Rest of cast listed alphabetically” – remove this observation.

```r
#Add Column to the table
HarryPotterCastData$FirstName <- as.character("NA")
HarryPotterCastData$LastName <- as.character("NA")

#HarryPotterCastData$LastName <- str_extract(HarryPotterCastData$Actors, "([^ ]+)")
#Clean up data table
```

#Question 1d
*	d. Split the Actor’s name into two columns: FirstName and Surname. Keep in mind that some actors/actresses have middle names as well. Please make sure that the middle names are in the FirstName column, in addition to the first name (example: given the Actor Frank Jeffrey Stevenson, the FirstName column would say “Frank Jeffrey.”)

```r
HarryPotterCastData$FirstName <- str_extract(HarryPotterCastData$Actors, "([^ ]+)")
HarryPotterCastData$LastName <- str_extract_all(HarryPotterCastData$Actors, "(([^ ]+)([^ ]+))", simplify = TRUE)

HarryPotterCastData
```

```
##                                                                     Actors
## 1                                         Ralph Fiennes ... Lord Voldemort
## 2                            Michael Gambon ... Professor Albus Dumbledore
## 3                                 Alan Rickman ... Professor Severus Snape
## 4                                        Daniel Radcliffe ... Harry Potter
## 5                                             Rupert Grint ... Ron Weasley
## 6                                         Emma Watson ... Hermione Granger
## 7                                           Evanna Lynch ... Luna Lovegood
## 8                                        Domhnall Gleeson ... Bill Weasley
## 9                                        Clémence Poésy ... Fleur Delacour
## 10                  Warwick Davis ... Griphook / Professor Filius Flitwick
## 11                                                John Hurt ... Ollivander
## 12                            Helena Bonham Carter ... Bellatrix Lestrange
## 13                                             Graham Duff ... Death Eater
## 14                                    Anthony Allgood ... Gringotts' Guard
## 15                                  Rusty Goffe ... Aged Gringotts' Goblin
## 16                                                      Jon Key ... Bogrod
## 17                                    Kelly Macdonald ... Helena Ravenclaw
## 18                                          Jason Isaacs ... Lucius Malfoy
## 19                                       Helen McCrory ... Narcissa Malfoy
## 20                                             Tom Felton ... Draco Malfoy
## 21                                      Ian Peck ... Hogsmeade Death Eater
## 22         Benn Northover ... Hogsmeade Death Eater(as Benjamin Northover)
## 23                                   Ciarán Hinds ... Aberforth Dumbledore
## 24                                    Hebe Beardsall ... Ariana Dumbledore
## 25                                    Matthew Lewis ... Neville Longbottom
## 26                                        Devon Murray ... Seamus Finnigan
## 27                                          Jessie Cave ... Lavender Brown
## 28                                             Afshan Azad ... Padma Patil
## 29                                           Isabella Laughland ... Leanne
## 30                                           Anna Shaffer ... Romilda Vane
## 31                                        Georgina Leonidas ... Katie Bell
## 32                                      Freddie Stroma ... Cormac McLaggen
## 33                            Alfred Enoch ... Dean Thomas(as Alfie Enoch)
## 34                                               Katie Leung ... Cho Chang
## 35                                               William Melling ... Nigel
## 36                                  Sian Grace Phillips ... Screaming Girl
## 37                                         Bonnie Wright ... Ginny Weasley
## 38                                          Ralph Ineson ... Amycus Carrow
## 39                                         Suzanne Toase ... Alecto Carrow
## 40                           Maggie Smith ... Professor Minerva McGonagall
## 41                             Jim Broadbent ... Professor Horace Slughorn
## 42                                      Scarlett Byrne ... Pansy Parkinson
## 43                                          Josh Herdman ... Gregory Goyle
## 44                                         Louis Cordice ... Blaise Zabini
## 45                                             Amber Evans ... Twin Girl 1
## 46                                              Ruby Evans ... Twin Girl 2
## 47                            Miriam Margolyes ... Professor Pomona Sprout
## 48                                           Gemma Jones ... Madam Pomfrey
## 49                                  George Harris ... Kingsley Shacklebolt
## 50                                           David Thewlis ... Remus Lupin
## 51                                         Julie Walters ... Molly Weasley
## 52                                        Mark Williams ... Arthur Weasley
## 53                                           James Phelps ... Fred Weasley
## 54                                        Oliver Phelps ... George Weasley
## 55                                          Chris Rankin ... Percy Weasley
## 56                                           David Bradley ... Argus Filch
## 57                                           Guy Henry ... Pius Thicknesse
## 58                                                  Nick Moran ... Scabior
## 59                                       Natalia Tena ... Nymphadora Tonks
## 60                                                   Phil Wright ... Giant
## 61                                                   Garry Sayer ... Giant
## 62                                                   Tony Adkins ... Giant
## 63                                         Dave Legeno ... Fenrir Greyback
## 64                                         Penelope McGhie ... Death Eater
## 65                             Emma Thompson ... Professor Sybil Trelawney
## 66                                Ellie Darcey-Alden ... Young Lily Potter
## 67                              Ariella Paradise ... Young Petunia Dursley
## 68                                 Benedict Clarke ... Young Severus Snape
## 69                              Leslie Phillips ... The Sorting Hat(voice)
## 70                                   Alfie McIlwain ... Young James Potter
## 71                                    Rohan Gotobed ... Young Sirius Black
## 72                                    Geraldine Somerville ... Lily Potter
## 73                                         Adrian Rawlins ... James Potter
## 74                                     Toby Papworth ... Baby Harry Potter
## 75                                              Timothy Spall ... Wormtail
## 76                                       Robbie Coltrane ... Rubeus Hagrid
## 77                                            Gary Oldman ... Sirius Black
## 78                                           Peter G. Reed ... Death Eater
## 79                                            Judith Sharp ... Death Eater
## 80                                            Emil Hostina ... Death Eater
## 81                           Bob Yves Van Hellenberg Hubar ... Death Eater
## 82                                        Granville Saxton ... Death Eater
## 83                                            Tony Kirwood ... Death Eater
## 84                                          Ashley McGuire ... Death Eater
## 85                  Arthur Bowen ... Albus Severus Potter - 19 Years Later
## 86                    Daphne de Beistegui ... Lily Potter - 19 Years Later
## 87            Will Dunn ... James Potter - 19 Years Later(as William Dunn)
## 88                         Jade Gordon ... Astoria Malfoy - 19 Years Later
## 89                     Bertie Gilbert ... Scorpius Malfoy - 19 Years Later
## 90                         Helena Barlow ... Rose Weasley - 19 Years Later
## 91                           Ryan Turner ... Hugo Weasley - 19 Years Later
## 92               Jon Campling ... Death Eater in Gringotts(scenes deleted)
## 93                         Karen Anderson ... Gringotts Goblin(uncredited)
## 94                             Michael Aston ... Wizard Parent(uncredited)
## 95                 Michael Henbury Ballan ... Gringotts Goblin(uncredited)
## 96                         Lauren Barrand ... Gringotts Goblin(uncredited)
## 97                David Barron ... Wizard with Dog in Painting(uncredited)
## 98                           Josh Bennett ... Gringotts Goblin(uncredited)
## 99                                 Johann Benét ... Deatheater(uncredited)
## 100                           Sean Biggerstaff ... Oliver Wood(uncredited)
## 101                          Jada Brevett ... Hogwarts Student(uncredited)
## 102                                   Ben Champniss ... Parent(uncredited)
## 103                                Collet Collins ... Snatcher(uncredited)
## 104                          Dean Conder ... Slytherin Student(uncredited)
## 105                             Christoph Cordell ... Snatcher(uncredited)
## 106 Christian Coulson ... Tom Marvolo Riddle(archive footage) (uncredited)
## 107                   Gioacchino Jim Cuffaro ... Wizard Parent(uncredited)
## 108                             Valerie Dane ... Wizard Parent(uncredited)
## 109                                 Paul Davies ... Deatheater(uncredited)
## 110                                 Sharon Day ... Death Eater(uncredited)
## 111                  Sarah-Jane De Crespigny ... Wizard Parent(uncredited)
## 112                             David Decio ... Chief Snatcher(uncredited)
## 113                            Sheri Desbaux ... Wizard parent(uncredited)
## 114                       Ninette Finch ... Augusta Longbottom(uncredited)
## 115               Grace Meurisse Francis ... Senior Gryffindor(uncredited)
## 116                      Sean Francis George ... Wizard Parent(uncredited)
## 117                         Diane Gibbins ... Gringotts Goblin(uncredited)
## 118                       Rosalie Gilmore ... Ravenclaw Senior(uncredited)
## 119                                 Rich Goble ... Death Eater(uncredited)
## 120                  Hattie Gotobed ... Young Girl in Epilogue(uncredited)
## 121          Melissa Gotobed ... Hogwart's First Year Epilogue(uncredited)
## 122                    Natalie Harrison ... Gryffindor Student(uncredited)
## 123 Ian Hart ... Professor Quirinus Quirrell(archive footage) (uncredited)
## 124            Stephen Hawke ... Wedding Guest (The Weasley's)(uncredited)
## 125                 David Heyman ... Dining Wizard in Painting(uncredited)
## 126 Harper Heyman ... Baby of Dining Wizard Family in Portrait(uncredited)
## 127                       Matthew Hodgkin ... Hogwarts Student(uncredited)
## 128                       Steven Hopwood ... One-Legged Wizard(uncredited)
## 129                                 Joe Kallis ... Death Eater(uncredited)
## 130                           Gemma Kayla ... Ravenclaw Senior(uncredited)
## 131                               Hrvoje Klecz ... Death Eater(uncredited)
## 132                         Maxwell Laird ... Gringotts Goblin(uncredited)
## 133                      Debra Leigh-Taylor ... Wizard Teacher(uncredited)
## 134                        Christina Low ... Ravenclaw Student(uncredited)
## 135                             Sarah Lowe ... Ministry Wizard(uncredited)
## 136                      Jonathan Massahi ... Hogwarts Student(uncredited)
## 137                              Tony Montalbano ... Passenger(uncredited)
## 138                          Sha'ori Morris ... Slytherin Girl(uncredited)
## 139                              Luke Newberry ... Teddy Lupin(uncredited)
## 140                           Lisa Osmond ... Gringotts Goblin(uncredited)
## 141                          Elisabeth Roberts ... Death Eater(uncredited)
## 142                         Keijo Salmela ... Gringotts Goblin(uncredited)
## 143                        Joshua Savary ... Ravenclaw Student(uncredited)
## 144                           Mark Sealey ... Gringotts Goblin(uncredited)
## 145                             Arti Shah ... Gringotts Goblin(uncredited)
## 146                               Glen Stanway ... Death Eater(uncredited)
## 147                           Albert Tang ... Hogwarts Teacher(uncredited)
## 148                      Richard Trinder ... Augustus Rookwood(uncredited)
## 149                                Nick Turner ... Death Eater(uncredited)
## 150                         Aaron Virdee ... Gryffindor Senior(uncredited)
## 151                     John Warman ... Railway Station Porter(uncredited)
## 152                     Spencer Wilding ... Knight of Hogwarts(uncredited)
## 153                            Amy Wiles ... Slytherin Student(uncredited)
## 154                     Thomas Williamson ... Hogwarts Student(uncredited)
##                                                      Characters  FirstName
## 1                                               Lord Voldemort       Ralph
## 2                                   Professor Albus Dumbledore     Michael
## 3                                      Professor Severus Snape        Alan
## 4                                                 Harry Potter      Daniel
## 5                                                  Ron Weasley      Rupert
## 6                                             Hermione Granger        Emma
## 7                                                Luna Lovegood      Evanna
## 8                                                 Bill Weasley    Domhnall
## 9                                               Fleur Delacour    Clémence
## 10                        Griphook / Professor Filius Flitwick     Warwick
## 11                                                  Ollivander        John
## 12                                         Bellatrix Lestrange      Helena
## 13                                                 Death Eater      Graham
## 14                                            Gringotts' Guard     Anthony
## 15                                      Aged Gringotts' Goblin       Rusty
## 16                                                      Bogrod         Jon
## 17                                            Helena Ravenclaw       Kelly
## 18                                               Lucius Malfoy       Jason
## 19                                             Narcissa Malfoy       Helen
## 20                                                Draco Malfoy         Tom
## 21                                       Hogsmeade Death Eater         Ian
## 22                Hogsmeade Death Eater(as Benjamin Northover)        Benn
## 23                                        Aberforth Dumbledore      Ciarán
## 24                                           Ariana Dumbledore        Hebe
## 25                                          Neville Longbottom     Matthew
## 26                                             Seamus Finnigan       Devon
## 27                                              Lavender Brown      Jessie
## 28                                                 Padma Patil      Afshan
## 29                                                      Leanne    Isabella
## 30                                                Romilda Vane        Anna
## 31                                                  Katie Bell    Georgina
## 32                                             Cormac McLaggen     Freddie
## 33                                 Dean Thomas(as Alfie Enoch)      Alfred
## 34                                                   Cho Chang       Katie
## 35                                                       Nigel     William
## 36                                              Screaming Girl        Sian
## 37                                               Ginny Weasley      Bonnie
## 38                                               Amycus Carrow       Ralph
## 39                                               Alecto Carrow     Suzanne
## 40                                Professor Minerva McGonagall      Maggie
## 41                                   Professor Horace Slughorn         Jim
## 42                                             Pansy Parkinson    Scarlett
## 43                                               Gregory Goyle        Josh
## 44                                               Blaise Zabini       Louis
## 45                                                 Twin Girl 1       Amber
## 46                                                 Twin Girl 2        Ruby
## 47                                     Professor Pomona Sprout      Miriam
## 48                                               Madam Pomfrey       Gemma
## 49                                        Kingsley Shacklebolt      George
## 50                                                 Remus Lupin       David
## 51                                               Molly Weasley       Julie
## 52                                              Arthur Weasley        Mark
## 53                                                Fred Weasley       James
## 54                                              George Weasley      Oliver
## 55                                               Percy Weasley       Chris
## 56                                                 Argus Filch       David
## 57                                             Pius Thicknesse         Guy
## 58                                                     Scabior        Nick
## 59                                            Nymphadora Tonks     Natalia
## 60                                                       Giant        Phil
## 61                                                       Giant       Garry
## 62                                                       Giant        Tony
## 63                                             Fenrir Greyback        Dave
## 64                                                 Death Eater    Penelope
## 65                                   Professor Sybil Trelawney        Emma
## 66                                           Young Lily Potter       Ellie
## 67                                       Young Petunia Dursley     Ariella
## 68                                         Young Severus Snape    Benedict
## 69                                      The Sorting Hat(voice)      Leslie
## 70                                          Young James Potter       Alfie
## 71                                          Young Sirius Black       Rohan
## 72                                                 Lily Potter   Geraldine
## 73                                                James Potter      Adrian
## 74                                           Baby Harry Potter        Toby
## 75                                                    Wormtail     Timothy
## 76                                               Rubeus Hagrid      Robbie
## 77                                                Sirius Black        Gary
## 78                                                 Death Eater       Peter
## 79                                                 Death Eater      Judith
## 80                                                 Death Eater        Emil
## 81                                                 Death Eater         Bob
## 82                                                 Death Eater   Granville
## 83                                                 Death Eater        Tony
## 84                                                 Death Eater      Ashley
## 85                       Albus Severus Potter - 19 Years Later      Arthur
## 86                                Lily Potter - 19 Years Later      Daphne
## 87              James Potter - 19 Years Later(as William Dunn)        Will
## 88                             Astoria Malfoy - 19 Years Later        Jade
## 89                            Scorpius Malfoy - 19 Years Later      Bertie
## 90                               Rose Weasley - 19 Years Later      Helena
## 91                               Hugo Weasley - 19 Years Later        Ryan
## 92                    Death Eater in Gringotts(scenes deleted)         Jon
## 93                                Gringotts Goblin(uncredited)       Karen
## 94                                   Wizard Parent(uncredited)     Michael
## 95                                Gringotts Goblin(uncredited)     Michael
## 96                                Gringotts Goblin(uncredited)      Lauren
## 97                     Wizard with Dog in Painting(uncredited)       David
## 98                                Gringotts Goblin(uncredited)        Josh
## 99                                      Deatheater(uncredited)      Johann
## 100                                    Oliver Wood(uncredited)        Sean
## 101                               Hogwarts Student(uncredited)        Jada
## 102                                         Parent(uncredited)         Ben
## 103                                       Snatcher(uncredited)      Collet
## 104                              Slytherin Student(uncredited)        Dean
## 105                                       Snatcher(uncredited)   Christoph
## 106           Tom Marvolo Riddle(archive footage) (uncredited)   Christian
## 107                                  Wizard Parent(uncredited)  Gioacchino
## 108                                  Wizard Parent(uncredited)     Valerie
## 109                                     Deatheater(uncredited)        Paul
## 110                                    Death Eater(uncredited)      Sharon
## 111                                  Wizard Parent(uncredited)  Sarah-Jane
## 112                                 Chief Snatcher(uncredited)       David
## 113                                  Wizard parent(uncredited)       Sheri
## 114                             Augusta Longbottom(uncredited)     Ninette
## 115                              Senior Gryffindor(uncredited)       Grace
## 116                                  Wizard Parent(uncredited)        Sean
## 117                               Gringotts Goblin(uncredited)       Diane
## 118                               Ravenclaw Senior(uncredited)     Rosalie
## 119                                    Death Eater(uncredited)        Rich
## 120                         Young Girl in Epilogue(uncredited)      Hattie
## 121                  Hogwart's First Year Epilogue(uncredited)     Melissa
## 122                             Gryffindor Student(uncredited)     Natalie
## 123  Professor Quirinus Quirrell(archive footage) (uncredited)         Ian
## 124                  Wedding Guest (The Weasley's)(uncredited)     Stephen
## 125                      Dining Wizard in Painting(uncredited)       David
## 126       Baby of Dining Wizard Family in Portrait(uncredited)      Harper
## 127                               Hogwarts Student(uncredited)     Matthew
## 128                              One-Legged Wizard(uncredited)      Steven
## 129                                    Death Eater(uncredited)         Joe
## 130                               Ravenclaw Senior(uncredited)       Gemma
## 131                                    Death Eater(uncredited)      Hrvoje
## 132                               Gringotts Goblin(uncredited)     Maxwell
## 133                                 Wizard Teacher(uncredited)       Debra
## 134                              Ravenclaw Student(uncredited)   Christina
## 135                                Ministry Wizard(uncredited)       Sarah
## 136                               Hogwarts Student(uncredited)    Jonathan
## 137                                      Passenger(uncredited)        Tony
## 138                                 Slytherin Girl(uncredited)     Sha'ori
## 139                                    Teddy Lupin(uncredited)        Luke
## 140                               Gringotts Goblin(uncredited)        Lisa
## 141                                    Death Eater(uncredited)   Elisabeth
## 142                               Gringotts Goblin(uncredited)       Keijo
## 143                              Ravenclaw Student(uncredited)      Joshua
## 144                               Gringotts Goblin(uncredited)        Mark
## 145                               Gringotts Goblin(uncredited)        Arti
## 146                                    Death Eater(uncredited)        Glen
## 147                               Hogwarts Teacher(uncredited)      Albert
## 148                              Augustus Rookwood(uncredited)     Richard
## 149                                    Death Eater(uncredited)        Nick
## 150                              Gryffindor Senior(uncredited)       Aaron
## 151                         Railway Station Porter(uncredited)        John
## 152                             Knight of Hogwarts(uncredited)     Spencer
## 153                              Slytherin Student(uncredited)         Amy
## 154                               Hogwarts Student(uncredited)      Thomas
##     LastName.1   LastName.2 LastName.3             LastName.4
## 1        Ralph      Fiennes        ...                   Lord
## 2      Michael       Gambon        ...              Professor
## 3         Alan      Rickman        ...              Professor
## 4       Daniel    Radcliffe        ...                  Harry
## 5       Rupert        Grint        ...                    Ron
## 6         Emma       Watson        ...               Hermione
## 7       Evanna        Lynch        ...                   Luna
## 8     Domhnall      Gleeson        ...                   Bill
## 9     Clémence        Poésy        ...                  Fleur
## 10     Warwick        Davis        ...               Griphook
## 11        John         Hurt        ...             Ollivander
## 12      Helena       Bonham     Carter                    ...
## 13      Graham         Duff        ...                  Death
## 14     Anthony      Allgood        ...             Gringotts'
## 15       Rusty        Goffe        ...                   Aged
## 16         Jon          Key        ...                 Bogrod
## 17       Kelly    Macdonald        ...                 Helena
## 18       Jason       Isaacs        ...                 Lucius
## 19       Helen      McCrory        ...               Narcissa
## 20         Tom       Felton        ...                  Draco
## 21         Ian         Peck        ...              Hogsmeade
## 22        Benn    Northover        ...              Hogsmeade
## 23      Ciarán        Hinds        ...              Aberforth
## 24        Hebe    Beardsall        ...                 Ariana
## 25     Matthew        Lewis        ...                Neville
## 26       Devon       Murray        ...                 Seamus
## 27      Jessie         Cave        ...               Lavender
## 28      Afshan         Azad        ...                  Padma
## 29    Isabella    Laughland        ...                 Leanne
## 30        Anna      Shaffer        ...                Romilda
## 31    Georgina     Leonidas        ...                  Katie
## 32     Freddie       Stroma        ...                 Cormac
## 33      Alfred        Enoch        ...                   Dean
## 34       Katie        Leung        ...                    Cho
## 35     William      Melling        ...                  Nigel
## 36        Sian        Grace   Phillips                    ...
## 37      Bonnie       Wright        ...                  Ginny
## 38       Ralph       Ineson        ...                 Amycus
## 39     Suzanne        Toase        ...                 Alecto
## 40      Maggie        Smith        ...              Professor
## 41         Jim    Broadbent        ...              Professor
## 42    Scarlett        Byrne        ...                  Pansy
## 43        Josh      Herdman        ...                Gregory
## 44       Louis      Cordice        ...                 Blaise
## 45       Amber        Evans        ...                   Twin
## 46        Ruby        Evans        ...                   Twin
## 47      Miriam    Margolyes        ...              Professor
## 48       Gemma        Jones        ...                  Madam
## 49      George       Harris        ...               Kingsley
## 50       David      Thewlis        ...                  Remus
## 51       Julie      Walters        ...                  Molly
## 52        Mark     Williams        ...                 Arthur
## 53       James       Phelps        ...                   Fred
## 54      Oliver       Phelps        ...                 George
## 55       Chris       Rankin        ...                  Percy
## 56       David      Bradley        ...                  Argus
## 57         Guy        Henry        ...                   Pius
## 58        Nick        Moran        ...                Scabior
## 59     Natalia         Tena        ...             Nymphadora
## 60        Phil       Wright        ...                  Giant
## 61       Garry        Sayer        ...                  Giant
## 62        Tony       Adkins        ...                  Giant
## 63        Dave       Legeno        ...                 Fenrir
## 64    Penelope       McGhie        ...                  Death
## 65        Emma     Thompson        ...              Professor
## 66       Ellie Darcey-Alden        ...                  Young
## 67     Ariella     Paradise        ...                  Young
## 68    Benedict       Clarke        ...                  Young
## 69      Leslie     Phillips        ...                    The
## 70       Alfie     McIlwain        ...                  Young
## 71       Rohan      Gotobed        ...                  Young
## 72   Geraldine   Somerville        ...                   Lily
## 73      Adrian      Rawlins        ...                  James
## 74        Toby     Papworth        ...                   Baby
## 75     Timothy        Spall        ...               Wormtail
## 76      Robbie     Coltrane        ...                 Rubeus
## 77        Gary       Oldman        ...                 Sirius
## 78       Peter           G.       Reed                    ...
## 79      Judith        Sharp        ...                  Death
## 80        Emil      Hostina        ...                  Death
## 81         Bob         Yves        Van             Hellenberg
## 82   Granville       Saxton        ...                  Death
## 83        Tony      Kirwood        ...                  Death
## 84      Ashley      McGuire        ...                  Death
## 85      Arthur        Bowen        ...                  Albus
## 86      Daphne           de  Beistegui                    ...
## 87        Will         Dunn        ...                  James
## 88        Jade       Gordon        ...                Astoria
## 89      Bertie      Gilbert        ...               Scorpius
## 90      Helena       Barlow        ...                   Rose
## 91        Ryan       Turner        ...                   Hugo
## 92         Jon     Campling        ...                  Death
## 93       Karen     Anderson        ...              Gringotts
## 94     Michael        Aston        ...                 Wizard
## 95     Michael      Henbury     Ballan                    ...
## 96      Lauren      Barrand        ...              Gringotts
## 97       David       Barron        ...                 Wizard
## 98        Josh      Bennett        ...              Gringotts
## 99      Johann        Benét        ... Deatheater(uncredited)
## 100       Sean  Biggerstaff        ...                 Oliver
## 101       Jada      Brevett        ...               Hogwarts
## 102        Ben    Champniss        ...     Parent(uncredited)
## 103     Collet      Collins        ...   Snatcher(uncredited)
## 104       Dean       Conder        ...              Slytherin
## 105  Christoph      Cordell        ...   Snatcher(uncredited)
## 106  Christian      Coulson        ...                    Tom
## 107 Gioacchino          Jim    Cuffaro                    ...
## 108    Valerie         Dane        ...                 Wizard
## 109       Paul       Davies        ... Deatheater(uncredited)
## 110     Sharon          Day        ...                  Death
## 111 Sarah-Jane           De  Crespigny                    ...
## 112      David        Decio        ...                  Chief
## 113      Sheri      Desbaux        ...                 Wizard
## 114    Ninette        Finch        ...                Augusta
## 115      Grace     Meurisse    Francis                    ...
## 116       Sean      Francis     George                    ...
## 117      Diane      Gibbins        ...              Gringotts
## 118    Rosalie      Gilmore        ...              Ravenclaw
## 119       Rich        Goble        ...                  Death
## 120     Hattie      Gotobed        ...                  Young
## 121    Melissa      Gotobed        ...              Hogwart's
## 122    Natalie     Harrison        ...             Gryffindor
## 123        Ian         Hart        ...              Professor
## 124    Stephen        Hawke        ...                Wedding
## 125      David       Heyman        ...                 Dining
## 126     Harper       Heyman        ...                   Baby
## 127    Matthew      Hodgkin        ...               Hogwarts
## 128     Steven      Hopwood        ...             One-Legged
## 129        Joe       Kallis        ...                  Death
## 130      Gemma        Kayla        ...              Ravenclaw
## 131     Hrvoje        Klecz        ...                  Death
## 132    Maxwell        Laird        ...              Gringotts
## 133      Debra Leigh-Taylor        ...                 Wizard
## 134  Christina          Low        ...              Ravenclaw
## 135      Sarah         Lowe        ...               Ministry
## 136   Jonathan      Massahi        ...               Hogwarts
## 137       Tony   Montalbano        ...  Passenger(uncredited)
## 138    Sha'ori       Morris        ...              Slytherin
## 139       Luke     Newberry        ...                  Teddy
## 140       Lisa       Osmond        ...              Gringotts
## 141  Elisabeth      Roberts        ...                  Death
## 142      Keijo      Salmela        ...              Gringotts
## 143     Joshua       Savary        ...              Ravenclaw
## 144       Mark       Sealey        ...              Gringotts
## 145       Arti         Shah        ...              Gringotts
## 146       Glen      Stanway        ...                  Death
## 147     Albert         Tang        ...               Hogwarts
## 148    Richard      Trinder        ...               Augustus
## 149       Nick       Turner        ...                  Death
## 150      Aaron       Virdee        ...             Gryffindor
## 151       John       Warman        ...                Railway
## 152    Spencer      Wilding        ...                 Knight
## 153        Amy        Wiles        ...              Slytherin
## 154     Thomas   Williamson        ...               Hogwarts
##                 LastName.5             LastName.6             LastName.7
## 1                Voldemort                                              
## 2                    Albus             Dumbledore                       
## 3                  Severus                  Snape                       
## 4                   Potter                                              
## 5                  Weasley                                              
## 6                  Granger                                              
## 7                 Lovegood                                              
## 8                  Weasley                                              
## 9                 Delacour                                              
## 10               Professor                 Filius               Flitwick
## 11                                                                      
## 12               Bellatrix              Lestrange                       
## 13                   Eater                                              
## 14                   Guard                                              
## 15              Gringotts'                 Goblin                       
## 16                                                                      
## 17               Ravenclaw                                              
## 18                  Malfoy                                              
## 19                  Malfoy                                              
## 20                  Malfoy                                              
## 21                   Death                  Eater                       
## 22                   Death               Eater(as               Benjamin
## 23              Dumbledore                                              
## 24              Dumbledore                                              
## 25              Longbottom                                              
## 26                Finnigan                                              
## 27                   Brown                                              
## 28                   Patil                                              
## 29                                                                      
## 30                    Vane                                              
## 31                    Bell                                              
## 32                McLaggen                                              
## 33               Thomas(as                  Alfie                 Enoch)
## 34                   Chang                                              
## 35                                                                      
## 36               Screaming                   Girl                       
## 37                 Weasley                                              
## 38                  Carrow                                              
## 39                  Carrow                                              
## 40                 Minerva             McGonagall                       
## 41                  Horace               Slughorn                       
## 42               Parkinson                                              
## 43                   Goyle                                              
## 44                  Zabini                                              
## 45                    Girl                                              
## 46                    Girl                                              
## 47                  Pomona                 Sprout                       
## 48                 Pomfrey                                              
## 49             Shacklebolt                                              
## 50                   Lupin                                              
## 51                 Weasley                                              
## 52                 Weasley                                              
## 53                 Weasley                                              
## 54                 Weasley                                              
## 55                 Weasley                                              
## 56                   Filch                                              
## 57              Thicknesse                                              
## 58                                                                      
## 59                   Tonks                                              
## 60                                                                      
## 61                                                                      
## 62                                                                      
## 63                Greyback                                              
## 64                   Eater                                              
## 65                   Sybil              Trelawney                       
## 66                    Lily                 Potter                       
## 67                 Petunia                Dursley                       
## 68                 Severus                  Snape                       
## 69                 Sorting             Hat(voice)                       
## 70                   James                 Potter                       
## 71                  Sirius                  Black                       
## 72                  Potter                                              
## 73                  Potter                                              
## 74                   Harry                 Potter                       
## 75                                                                      
## 76                  Hagrid                                              
## 77                   Black                                              
## 78                   Death                  Eater                       
## 79                   Eater                                              
## 80                   Eater                                              
## 81                   Hubar                    ...                  Death
## 82                   Eater                                              
## 83                   Eater                                              
## 84                   Eater                                              
## 85                 Severus                 Potter                     19
## 86                    Lily                 Potter                     19
## 87                  Potter                     19                  Years
## 88                  Malfoy                     19                  Years
## 89                  Malfoy                     19                  Years
## 90                 Weasley                     19                  Years
## 91                 Weasley                     19                  Years
## 92                   Eater                     in       Gringotts(scenes
## 93      Goblin(uncredited)                                              
## 94      Parent(uncredited)                                              
## 95               Gringotts     Goblin(uncredited)                       
## 96      Goblin(uncredited)                                              
## 97                    with                    Dog                     in
## 98      Goblin(uncredited)                                              
## 99                                                                      
## 100       Wood(uncredited)                                              
## 101    Student(uncredited)                                              
## 102                                                                     
## 103                                                                     
## 104    Student(uncredited)                                              
## 105                                                                     
## 106                Marvolo         Riddle(archive               footage)
## 107                 Wizard     Parent(uncredited)                       
## 108     Parent(uncredited)                                              
## 109                                                                     
## 110      Eater(uncredited)                                              
## 111                 Wizard     Parent(uncredited)                       
## 112   Snatcher(uncredited)                                              
## 113     parent(uncredited)                                              
## 114 Longbottom(uncredited)                                              
## 115                 Senior Gryffindor(uncredited)                       
## 116                 Wizard     Parent(uncredited)                       
## 117     Goblin(uncredited)                                              
## 118     Senior(uncredited)                                              
## 119      Eater(uncredited)                                              
## 120                   Girl                     in   Epilogue(uncredited)
## 121                  First                   Year   Epilogue(uncredited)
## 122    Student(uncredited)                                              
## 123               Quirinus       Quirrell(archive               footage)
## 124                  Guest                   (The Weasley's)(uncredited)
## 125                 Wizard                     in   Painting(uncredited)
## 126                     of                 Dining                 Wizard
## 127    Student(uncredited)                                              
## 128     Wizard(uncredited)                                              
## 129      Eater(uncredited)                                              
## 130     Senior(uncredited)                                              
## 131      Eater(uncredited)                                              
## 132     Goblin(uncredited)                                              
## 133    Teacher(uncredited)                                              
## 134    Student(uncredited)                                              
## 135     Wizard(uncredited)                                              
## 136    Student(uncredited)                                              
## 137                                                                     
## 138       Girl(uncredited)                                              
## 139      Lupin(uncredited)                                              
## 140     Goblin(uncredited)                                              
## 141      Eater(uncredited)                                              
## 142     Goblin(uncredited)                                              
## 143    Student(uncredited)                                              
## 144     Goblin(uncredited)                                              
## 145     Goblin(uncredited)                                              
## 146      Eater(uncredited)                                              
## 147    Teacher(uncredited)                                              
## 148   Rookwood(uncredited)                                              
## 149      Eater(uncredited)                                              
## 150     Senior(uncredited)                                              
## 151                Station     Porter(uncredited)                       
## 152                     of   Hogwarts(uncredited)                       
## 153    Student(uncredited)                                              
## 154    Student(uncredited)                                              
##               LastName.8 LastName.9          LastName.10
## 1                                                       
## 2                                                       
## 3                                                       
## 4                                                       
## 5                                                       
## 6                                                       
## 7                                                       
## 8                                                       
## 9                                                       
## 10                                                      
## 11                                                      
## 12                                                      
## 13                                                      
## 14                                                      
## 15                                                      
## 16                                                      
## 17                                                      
## 18                                                      
## 19                                                      
## 20                                                      
## 21                                                      
## 22            Northover)                                
## 23                                                      
## 24                                                      
## 25                                                      
## 26                                                      
## 27                                                      
## 28                                                      
## 29                                                      
## 30                                                      
## 31                                                      
## 32                                                      
## 33                                                      
## 34                                                      
## 35                                                      
## 36                                                      
## 37                                                      
## 38                                                      
## 39                                                      
## 40                                                      
## 41                                                      
## 42                                                      
## 43                                                      
## 44                                                      
## 45                                                      
## 46                                                      
## 47                                                      
## 48                                                      
## 49                                                      
## 50                                                      
## 51                                                      
## 52                                                      
## 53                                                      
## 54                                                      
## 55                                                      
## 56                                                      
## 57                                                      
## 58                                                      
## 59                                                      
## 60                                                      
## 61                                                      
## 62                                                      
## 63                                                      
## 64                                                      
## 65                                                      
## 66                                                      
## 67                                                      
## 68                                                      
## 69                                                      
## 70                                                      
## 71                                                      
## 72                                                      
## 73                                                      
## 74                                                      
## 75                                                      
## 76                                                      
## 77                                                      
## 78                                                      
## 79                                                      
## 80                                                      
## 81                 Eater                                
## 82                                                      
## 83                                                      
## 84                                                      
## 85                 Years      Later                     
## 86                 Years      Later                     
## 87              Later(as    William                Dunn)
## 88                 Later                                
## 89                 Later                                
## 90                 Later                                
## 91                 Later                                
## 92              deleted)                                
## 93                                                      
## 94                                                      
## 95                                                      
## 96                                                      
## 97  Painting(uncredited)                                
## 98                                                      
## 99                                                      
## 100                                                     
## 101                                                     
## 102                                                     
## 103                                                     
## 104                                                     
## 105                                                     
## 106         (uncredited)                                
## 107                                                     
## 108                                                     
## 109                                                     
## 110                                                     
## 111                                                     
## 112                                                     
## 113                                                     
## 114                                                     
## 115                                                     
## 116                                                     
## 117                                                     
## 118                                                     
## 119                                                     
## 120                                                     
## 121                                                     
## 122                                                     
## 123         (uncredited)                                
## 124                                                     
## 125                                                     
## 126               Family         in Portrait(uncredited)
## 127                                                     
## 128                                                     
## 129                                                     
## 130                                                     
## 131                                                     
## 132                                                     
## 133                                                     
## 134                                                     
## 135                                                     
## 136                                                     
## 137                                                     
## 138                                                     
## 139                                                     
## 140                                                     
## 141                                                     
## 142                                                     
## 143                                                     
## 144                                                     
## 145                                                     
## 146                                                     
## 147                                                     
## 148                                                     
## 149                                                     
## 150                                                     
## 151                                                     
## 152                                                     
## 153                                                     
## 154
```

#Question 1e
*	e. Present the first 10 rows of the data.frame() – It should have only FirstName, Surname, and Character columns. 



## Question 2 SportsBall (50%)
*	a. On the ESPN website, there are statistics of each NBA player. Navigate to the San Antonio Spurs current statistics (likely http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs). You are interested in the Shooting Statistics table. 
*	b. Scrape the page with any R package that makes things easy for you. There are a few tables on the page, so make sure you are targeting specifically the Shooting Statistics table. 
* c. Clean up the table (You might get some warnings if you’re working with tibbles) • You’ll want to create an R data.frame() with one observation for each player. Make sure that you do not accidentally include blank rows, a row of column names, or the Totals row in the table as observations. 
	• The column PLAYER has two variables of interest in it: the player’s name and their position, denoted by 1-2 letters after their name. Split the cells into two columns, one with Name and the other Position. 
	• Check the data type of all columns. Convert relevant columns to numeric. Check the data type of all columns again to confirm that they have changed! 
	
* d. Create a colorful bar chart that shows the Field Goals Percentage Per Game for each person. It will be graded on the following criteria. • Informative Title, centered 
	• Relevant x and y axis labels (not simply variables names!) 
	• Human-readable axes with no overlap (you might have to flip x and y to fix that). Note: You do not have to convert the decimal to a percentage. 
	• Color the columns by the team member’s position (so, all PF’s should have the same color, etc.) 


## Question 2

```r
SpursStatsURL <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"
SpursShootingURLData <- read_html("http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs")

SpursShootingStats <- html_text(html_nodes(SpursShootingURLData, "td"))

#create a data frame of spurs stats
SpursShootingStats <-  as.data.frame(SpursShootingStats)

#Print only shooting stats table
SpursShootingStats <- SpursShootingStats[243:452,]

#Convert to data frame
SpursShootingStats <- as.data.frame(SpursShootingStats)

#Split single column into mulltiple columns
SpursShootingStats <- as.data.frame(matrix(SpursShootingStats[,1], byrow=TRUE, ncol = 15))
```

#Rename columns

```r
names(SpursShootingStats) <- c("Player", "FGM", "FGA", "FG%", "3PM", "3PA", "3P%", "FTM", "FTA", "FT%", "2PM","2PA", "2P%", "PPS", "AFG%")
```
