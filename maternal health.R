#predict maternal risk using KNN algorithm
#import data
maternal <- read.csv("C:/Users/dashi/Downloads/Maternal Health Risk Data Set.csv")
summary(maternal)
str(maternal)
names(maternal) <- c("Age", "SystolicBP", "DiastolicBP", "BS", "BodyTemp", "HeartRate", "RiskLevel")
maternal$RiskLevel <- factor(maternal$RiskLevel,
                             levels = c("high risk", "mid risk", "low risk"),
                             labels = c("1", "2", "3"))
str(maternal)
#identify missing data
maternal <- maternal[complete.cases(maternal),]
str(maternal)
#look at histograms to understand the distribution of variables
hist(maternal$Age)
hist(maternal$SystolicBP)
hist(maternal$DiastolicBP)
hist(maternal$BodyTemp)
hist(maternal$HeartRate)
#convert data into numeric format

maternal$RiskLevel <- as.numeric(maternal$RiskLevel)
str(maternal)
hist(maternal$RiskLevel)
#Build the model
#Data splicing
trainingSet <- maternal[1:980, 1:6]
testSet <- maternal[981:1014, 1:6]

#split diagnosis
trainingOutcomes <- maternal[1:980, 7]
testOutcomes <- maternal[981:1014, 7]
#Apply KNN algorithm
library(class)
predictions <- knn(train = trainingSet, cl = trainingOutcomes, k = 31,
                   test = testSet)
#display predictions
predictions
#model evaluations
table(testOutcomes, predictions)
#finding accuracy
actuals_preds <- data.frame(cbind(actuals=testOutcomes, predicted=predictions))
correlation_accuracy <- cor(actuals_preds)
head(actuals_preds)
