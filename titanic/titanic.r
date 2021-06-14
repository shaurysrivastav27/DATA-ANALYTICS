
 train<- read.csv("/home/shaury/Downloads/nptel/titanic/train.csv")
 test<- read.csv("/home/shaury/Downloads/nptel/titanic/test.csv")
 #View(train)
 library(tidyverse)
 train<-na.omit(train)
 png("/home/shaury/Desktop/pvsc/pclass.png");
 pl<-ggplot(train)+geom_bar(aes(Survived,fill=factor(Pclass)))
 print(pl);
 dev.off();
 
 png("/home/shaury/Desktop/pvsc/pclass-diff.png");
 pl<-ggplot(train)+geom_bar(aes(Survived,fill=factor(Pclass)),position='dodge')
 print(pl)
 dev.off();
 
 png("/home/shaury/Desktop/pvsc/sex.png");
 pl<-ggplot(train)+geom_bar(aes(Survived,fill=factor(Sex)))
 print(pl);
 dev.off();
 
 png("/home/shaury/Desktop/pvsc/sex-diff.png");
 pl<-ggplot(train)+geom_bar(aes(Survived,fill=factor(Sex)),position='dodge')
 print(pl);dev.off();
 
 m1<- glm(Survived~ Sex+Pclass,train,family='gaussian');
 summary(m1);
 
 pred<- predict(m1,train);
 pred<- round(pred,0);
 table(pred,train$Survived);
 
 #test data
 y_pred= predict(m1,test)
 y_pred=round(y_pred,0)

