 library(caTools)
 set.seed(123)
 df = read.csv("/home/shaury/Downloads/nptel/Iris.csv")
 sample =sample.split(df,SplitRatio=0.85)
 train = subset(df,sample ==TRUE)
 test = subset(df,sample ==FALSE)
 l1 <- glm(train$Species~ train$SepalLengthCm+train$SepalWidthCm+ train$PetalLengthCm+train$PetalWidthCm ,df,family=binomial)
 summary(l1)
 train = test
 View(test)
 y_pre = predict(l1,train)
 table(y_pre,test$Species)
 View(y_pre)


