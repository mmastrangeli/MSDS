dfTrain
dfTest
dfTrainVar <- dfTrain$BusinessTravel
#levels(dfTrain$BusinessTravel)

dfTrain$BusinessTravel <- factor(dfTrain$BusinessTravel)
head(dfTrain[, 'BusinessTravel'])

dfTrainBusinessTravelDummies <- model.matrix(~dfTrain$BusinessTravel -1, data = dfTrain)
head(dfTrainBusinessTravelDummies)
dfTrainJobSatisfactionDummies <- model.matrix(~dfTrain$JobSatisfaction -1, data = dfTrain)
head(dfTrainJobSatisfactionDummies)

head(dfTrain[, 'Attrition'])

dfTrainAttritionDummies <- model.matrix(~dfTrain$Attrition -1, data = dfTrain)
head(dfTrainAttritionDummies)

lm(formula = dfTrainAttritionDummies ~ dfTrainBusinessTravelDummies + dfTrainJobSatisfactionDummies)



#Transform data to normalize variables for multivariant analysis. 
##Factor for Regression
head(dfTrain[, 'BusinessTravel'])

dfTrainBusinessTravelDummies <- model.matrix(~dfTrain$BusinessTravel -1, data = dfTrain)
head(dfTrainBusinessTravelDummies)
dfTrainJobSatisfactionDummies <- model.matrix(~dfTrain$JobSatisfaction -1, data = dfTrain)
head(dfTrainJobSatisfactionDummies)

head(dfTrain[, 'Attrition'])

dfTrainAttritionDummies <- model.matrix(~dfTrain$Attrition -1, data = dfTrain)
head(dfTrainAttritionDummies)

lm(formula = dfTrainAttritionDummies ~ dfTrainBusinessTravelDummies + dfTrainJobSatisfactionDummies)




#Factor Annual Income into 6 levels
dfTrain$AnnIncomeGroups <- cut(dfTrain$AnnualIncome, breaks=c(0,50000,100000,199999,Inf),labels=c("$0-$50,000", "$50,000-$100,000", "$100,000-$200,000", "Over $200,000"))
#Factor Age of Employee into Age Groups, 8 levels
dfTrain$AgeGroup <- cut(dfTrain$Age, breaks = c(18,30,40,50,Inf), labels = c("18-30", "30-40", "40-50", "Over 50"))
dfTrain$Attrition <- factor(dfTrain$Attrition)
dfTrain$Gender <- factor(dfTrain$Gender)
dfTrain$JobLevel <- factor(dfTrain$JobLevel)
dfTrain$JobLevel <- factor(dfTrain$JobLevel)
dfTrain$MaritalStatus <- factor(dfTrain$MaritalStatus)
dfTrain$EnvironmentSatisfaction <- cut(dfTrain$EnvironmentSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$JobInvolvement <- cut(dfTrain$JobInvolvement, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$JobSatisfaction <- cut(dfTrain$JobSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$RelationshipSatisfaction <- cut(dfTrain$RelationshipSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$PerformanceRating <- cut(dfTrain$PerformanceRating, breaks = 4, labels = c("Does Not Meet Expectations", "Meets Some Expections", "Meets Expectations", "Exceeds Expectations"))
dfTrain$WorkLifeBalance <- cut(dfTrain$WorkLifeBalance, breaks = 4, labels = c("Bad", "Good", "Better", "Best"))






dfTrain$Attrition <- factor(dfTrain$Attrition)
dfTrain$BusinessTravel <- factor(dfTrain$BusinessTravel)
dfTrain$Education <- cut(dfTrain$EnvironmentSatisfaction, breaks = 5, labels = c("HighSchool", "SomeCollege", "College", "Graduate", "Doctoral"))
dfTrain$EducationField <- factor(dfTrain$EducationField)
dfTrain$EnvironmentSatisfaction <- cut(dfTrain$EnvironmentSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$Gender <- factor(dfTrain$Gender)
dfTrain$JobInvolvement <- cut(dfTrain$JobInvolvement, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$JobLevel <- cut(dfTrain$Joblevel, breaks = 4, labels = c("Entry", "Middle", "Director", "VP" "Executive"))
dfTrain$JobSatisfaction <- cut(dfTrain$JobSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))

dfTrain$JobRole <- factor(dfTrain$JobRole)
dfTrain$JobLevel <- factor(dfTrain$JobLevel)
dfTrain$MaritalStatus <- factor(dfTrain$MaritalStatus)


dfTrain$RelationshipSatisfaction <- cut(dfTrain$RelationshipSatisfaction, breaks = 4, labels = c("Low", "Medium", "High", "Very High"))
dfTrain$PerformanceRating <- cut(dfTrain$PerformanceRating, breaks = 4, labels = c("Does Not Meet Expectations", "Meets Some Expections", "Meets Expectations", "Exceeds Expectations"))
dfTrain$WorkLifeBalance <- cut(dfTrain$WorkLifeBalance, breaks = 4, labels = c("Bad", "Good", "Better", "Best"))

