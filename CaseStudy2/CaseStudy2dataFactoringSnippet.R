#CaseStudy2_data <- read_csv("CaseStudy2-data.csv", col_types = 
cols(
  Attrition = col_factor(levels = c("Yes", "No")),
  BusinessTravel = col_factor(levels = c("Non-Travel", "Travel_Rarely", "Travel_Frequently")),
  Department = col_factor(levels = c("Human Resources", "Research & Development", "Sales")),
  Education = col_factor(levels = c("1", "2", "3", "4", "5")),
  EducationField = col_factor(levels = c("Human Resources", "Life Sciences", "Marketing", "Medical", "Technical Degree", "Other")),
  EnvironmentSatisfaction = col_factor(levels = c("1", "2", "3", "4")),
  Gender = col_factor(levels = c("Male", "Female")),
  JobInvolvement = col_factor(levels = c("1", "2", "3", "4")),
  JobLevel = col_factor(levels = c("1", "2", "3", "4", "5")),
  JobSatisfaction = col_factor(levels = c("1", "2", "3", "4")),
  MaritalStatus = col_factor(levels = c("Single", "Married", "Divorced")),
  NumCompaniesWorked = col_factor(levels = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")), 
  OverTime = col_factor(levels = c("Yes", "No")),
  PerformanceRating = col_factor(levels = c("1", "2", "3", "4")),
  RelationshipSatisfaction = col_factor(levels = c("1", "2", "3", "4")),
  StandardHours = col_number(), 
  StockOptionLevel = col_factor(levels = c("0", "1", "2", "3")),
  WorkLifeBalance = col_factor(levels = c("1", "2", "3", "4"))
)
)