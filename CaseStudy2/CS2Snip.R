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





dfTrain$AgeGroup <- cut(dfTrain$Age, breaks = c(18,30,40,50,Inf), labels = c("18-30", "30-40", "40-50", "Over 50"))
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



#filter() examples
#filter(starwars, species == "Human")
#filter(starwars, mass > 1000)

# Multiple criteria
#filter(starwars, hair_color == "none" & eye_color == "black")
#filter(starwars, hair_color == "none" | eye_color == "black")

# Multiple arguments are equivalent to and
#filter(starwars, hair_color == "none", eye_color == "black")

#filter_all() examples
# While filter() accepts expressions with specific variables, the
# scoped filter verbs take an expression with the pronoun `.` and
# replicate it over all variables. This expression should be quoted
# with all_vars() or any_vars():
#all_vars(is.na(.))
#any_vars(is.na(.))


# You can take the intersection of the replicated expressions:
#filter_all(mtcars, all_vars(. > 150))
# Or the union:
#filter_all(mtcars, any_vars(. > 150))

# You can vary the selection of columns on which to apply the
# predicate. filter_at() takes a vars() specification:
#filter_at(mtcars, vars(starts_with("d")), any_vars((. %% 2) == 0))

# And filter_if() selects variables with a predicate function:
#filter_if(mtcars, ~ all(floor(.) == .), all_vars(. != 0))



#Plot the numeric categorical and continuous variables
##Plot of Attrition Rate by Age 
dfTrain %>% ggplot(aes(Age, color = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, Age, fill = Attrition)) +
  geom_boxplot()

#DailyRate
dfTrain %>% ggplot(aes(DailyRate, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, DailyRate, fill = Attrition)) +
  geom_boxplot()

#Distance
dfTrain %>% ggplot(aes(DistanceFromHome, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, DistanceFromHome, fill = Attrition)) +
  geom_boxplot()

#MonthlyIncome
dfTrain %>% ggplot(aes(MonthlyIncome, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, MonthlyIncome, fill = Attrition)) +
  geom_boxplot()

#MonthlyRate
dfTrain %>% ggplot(aes(MonthlyRate, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, MonthlyRate, fill = Attrition)) +
  geom_boxplot()

#NumCompaniesWorked
dfTrain %>% ggplot(aes(NumCompaniesWorked, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, NumCompaniesWorked, fill = Attrition)) +
  geom_boxplot()

#PercentSalaryHike
dfTrain %>% ggplot(aes(PercentSalaryHike, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, PercentSalaryHike, fill = Attrition)) +
  geom_boxplot()

#TotalWorkingYears
dfTrain %>% ggplot(aes(TotalWorkingYears, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, TotalWorkingYears, fill = Attrition)) +
  geom_boxplot()

#TrainingTimeLastYear
dfTrain %>% ggplot(aes(TrainingTimesLastYear, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, TrainingTimesLastYear, fill = Attrition)) +
  geom_boxplot()

#YearAtCompany
dfTrain %>% ggplot(aes(YearsAtCompany, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, YearsAtCompany, fill = Attrition)) +
  geom_boxplot()

#YearInCurrentRole
dfTrain %>% ggplot(aes(YearsInCurrentRole, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, YearsInCurrentRole, fill = Attrition)) +
  geom_boxplot()

#YearsSinceLastPromotion
dfTrain %>% ggplot(aes(YearsSinceLastPromotion, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, YearsSinceLastPromotion, fill = Attrition)) +
  geom_boxplot()

#YearsWithCurrentManager
dfTrain %>% ggplot(aes(YearsWithCurrManager, colour = Attrition)) + 
  geom_freqpoly()
dfTrain %>% ggplot(aes(Attrition, YearsWithCurrManager, fill = Attrition)) +
  geom_boxplot()