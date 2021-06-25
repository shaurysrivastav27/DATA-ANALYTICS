dataf<-read.csv('D:/pvsc/data.sci/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Machine Learning Projects/CSV files for ML Projects/loan_data.csv');


head(dataf);

dataf$inq.last.6mths<- as.numeric(factor(dataf$inq.last.6mths));
dataf$delinq.2yrs<- as.numeric(factor(dataf$delinq.2yrs));
dataf$pub.rec<- as.numeric(factor(dataf$pub.rec));
dataf$not.fully.paid<- as.numeric(factor(dataf$fully.paid));
dataf$credit.policy<- as.numeric(factor(dataf$credit.policy));


 ggplot(dataf)+geom_histogram(aes(fico,fill=factor(not.fully.paid)),color='black',bins=30);
 
  ggplot(dataf)+geom_bar(aes(purpose,fill=factor(not.fully.paid)),color='black',bins=30,position='dodge');
 
 ggplot(dataf)+geom_point(aes(int.rate,fico,color=not.fully.paid),alpha=0.2)+scale_color_gradient(low='red',high='green');

library(caTools);
set.seed(101);
sample<- sample.split(dataf,SplitRatio=0.75);
train<- subset(dataf,sample==T);
test <- subset(dataf,sample==F);



library(e1071);
model<- svm(not.fully.paid~.,train);
summary(model);
pred<-predict(model,test);
pred<-sapply(pred,round);
table(pred,test$not.fully.paid);


#tunning the model temp<- tune(svm,train.x=not.fully.paid~., data=train,kernel='radial',ranges=list(cost=c(0.1,0.25,0.5,0.75,1), gamma=c(0.01,0.02,0.03,0.05,0.1,0.2,0.3)));








