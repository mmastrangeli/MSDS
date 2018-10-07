#Problem 1

#Right clicked on a folder and clicked in the context menu “GIT Bash Here”.
#mkdir u03_p1
#cd u03_p1
#git clone “https://github.com/caesar0301/awesome-public-datasets”
#Problem 2

#a
df <- read.table( "titanic.csv", header = TRUE, sep = "," )
#b
mf <- table( df$Sex )
mf
barplot( mf/(mf[1] + mf[2]), main = "People on the Titanic", xlab = "Sex", ylab="Frequency", col=c("Blue") )

#c
sapply( df[c(2,6,10)], function(x){mean(x, na.rm = TRUE)} )
#Problem 3

readSleep <- function( sdata )
{
  #a
  medAge <- median( sdata$Age, na.rm = TRUE )
  minSdur <- min(sdata$Duration, na.rm = TRUE)
  maxSdur <- max(sdata$Duration, na.rm = TRUE)
  meanRses <- mean( sdata$RSES, na.rm = TRUE )
  sdRses <- sd( sdata$RSES, na.rm = TRUE )
  tbl <- cbind(as.list(medAge),minSdur,maxSdur,meanRses,sdRses)
  colnames(tbl) <- c("medAge", "minSdur", "maxSdur", "meanRses", "sdRses")
  obja <- as.data.frame(tbl)
  
  #b
  t <- cbind( c(maxSdur-minSdur)*5 )
  colnames(t) <- c("durRange")
  report <- data.frame(obja$medAge, obja$meanRses, obja$sdRses, t)/5
  
  #c
  colnames(report) <- c("MedianAge", "SelfEsteem", "SE_SD", "DurationRange")
  
  #d
  round(report, digits = 2)
  
}

sdata1 <- read.csv( "sleep_data_01.csv", header = TRUE )
obj <- readSleep( sdata1 )
obj
#Problem 4

#a
library(fivethirtyeight)
#b
pkg <- data(package = "fivethirtyeight")
df <- as.data.frame( get( pkg$results[22,"Item"] ) )

#c
#vignette("fivethirtyeight", package="fivethirtyeight")
#https://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/

#URL path to the physical library on my computer
upath <- pkg$results[22,"LibPath"]
upath

#d
dim(df)
colnames(df)
#Problem 5

#a
colnames(df)
length(colnames(df))

#b
major_count <- table(df$major_category)

#c
par(las=2)
barplot( major_count, horiz = TRUE, main = "Number of students per major", xlab = "Number of students",ylab="Major", col=c("Red") )

#d
write.table( major_count, file = "fivethirtyeight.csv", row.names = FALSE, sep=",", col.names = c("major_category", "freq"))
