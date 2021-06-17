df<- read.csv("/home/shaury/Downloads/nptel/Iris.csv")
 plot(df,col=c("red","blue","green")[ df$Species])
 library(MASS)
 library(tidyverse)
 set.seed(123)
 library(caTools)
 sample<-sample.split(df,SplitRatio=0.8)
 train<-subset(df,sample==TRUE)
 test<-subset(df,sample==FALSE)
 View(train)
 l1<-lda(train$Species~ train$PetalLengthCm+train$PetalWidthCm+train$SepalWidthCm+train$SepalLengthCm)
 l1
 train=test
 pred<-predict(l1,data.frame(train))
 table(pred$class,test$Species)
 score<-mean(pred$class==test$Species)
 score


