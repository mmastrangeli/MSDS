## R API Libary packages: openair, quantmod, treebase, twitteR, WDI, rOpenSci 
## (see page 123 of Gandrud)







#World Bank Data Example
##Install and Load the package
library(WDI)

#Search for fertalizer consumption data
WDIsearch("fertilizer consumption")

## Use indicator number to gather data
FertConsumpData <- WDI(indicator = "AG.CON.FERT.ZS")

##How many variables are in the data set?
## How many cases?
##Download the data using another indicator
##You can use different search term if you like
##Add the code to your makefile

##Install and load one of the packages given in the list for downloading APIs on the previous page.
#*Find an example using that package to download data.
#*Follow the example to download some data using that library.
#*Change one thing in the function to see what it does.
#*Create a PPT presentation to show in the live session.
#*You should have no more than five slides (including the title slide).
#*If you want comments on your presentation prior to the live session, post a PDF on the discussion board.

