library(ISLR);
#College<- read.csv('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/R/college/data.csv');
str(College)
summary(College);
library(tidyverse);

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/R/college/gradevsroom.png");
pl<-ggplot(College)+geom_point(aes(x=Grad.Rate,y=Room.Board,col=Private));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/R/college/fundergrad.png");
print(ggplot(College)+geom_histogram(aes(F.Undergrad,fill=Private),color='black',bins=30))
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/R/college/grad-hist.png");
print(ggplot(College)+geom_histogram(aes(Grad.Rate,fill=Private),color='black',bins=30))
dev.off();

College[College$Grad.Rate>100,'Grad.Rate']<-100;

library(caTools);
set.seed(101);
sample<-sample.split(College,SplitRatio=0.70);
train<-subset(College,sample==TRUE);
test<-subset(College,sample==FALSE);


library(rpart);
m1<-rpart(Private~.,method='class',train);

pred<- predict(m1,test);


library(rpart.plot);
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/R/college/tree.png");
print(prp(m1));
dev.off();

final <- pred[,2];
final <- sapply(final,function(x) ifelse(x>0.5,'Yes','No'));

table(final,test$Private);

#random forest;
library(randomForest);
m2 <- randomForest(Private~.,train);
pred<-predict(m2,test);

m2; #confusion matrix;

table(pred,test$Private);






