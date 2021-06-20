adult<- read.csv("/home/shaury/Desktop/pvsc/data.sci/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Machine Learning Projects/CSV files for ML Projects/adult_sal.csv",na.strings=c('?'));

library(Amelia);
library(tidyverse);

missmap(adult,main='Missing Map');
adult<-na.omit(adult);

#type employer

adult$type_employer<- gsub('State-gov','gov',adult$type_employer);
adult$type_employer<- gsub('Federal-gov','gov',adult$type_employer);
adult$type_employer<- gsub('Local-gov','gov',adult$type_employer);
adult$type_employer<- gsub('Private','self',adult$type_employer);
adult$type_employer<- gsub('Self-emp-inc','self',adult$type_employer);
adult$type_employer<- gsub('Without-pay','unemployed',adult$type_employer);
adult$type_employer<- gsub('Never-worked','unemployed',adult$type_employer);
adult$type_employer<- gsub('Self-emp-not-inc','self',adult$type_employer);

#marital
adult$marital<- gsub('Never-married','never married',adult$marital);
adult$marital<- gsub('Married-civ-spouse','married',adult$marital);
adult$marital<- gsub('Divorced','not married',adult$marital);
adult$marital<- gsub('Married-spouse-absent','married',adult$marital);
adult$marital<- gsub('Separated','not married',adult$marital);
adult$marital<- gsub('Married-AF-spouse','married',adult$marital);
adult$marital<- gsub('Widowed','not married',adult$marital);
           
#country
adult<-  adult %>% mutate(across('country',str_replace,'United-States','1')) %>% mutate(across('country',str_replace,'Cuba','1')) %>% mutate(across('country',str_replace,'Jamaica','1')) %>% mutate(across('country',str_replace,'Puerto-Rico','1')) %>% mutate(across('country',str_replace,'Mexico','1')) %>% mutate(across('country',str_replace,'Honduras','1')) %>% mutate(across('country',str_replace,'Canada','1')) %>% mutate(across('country',str_replace,'Columbia','1')) %>% mutate(across('country',str_replace,'Nicaragua','1')) %>% mutate(across('country',str_replace,'Peru','1')) %>% mutate(across('country',str_replace,'Haiti','1'))%>% mutate(across('country',str_replace,'El-Salvador','1')) %>% mutate(across('country',str_replace,'Guatemala','1')) %>% mutate(across('country',str_replace,'India','2')) %>% mutate(across('country',str_replace,'Iran','2')) %>% mutate(across('country',str_replace,'Philippines','2')) %>% mutate(across('country',str_replace,'Cambodia','2')) %>% mutate(across('country',str_replace,'Thailand','2')) %>% mutate(across('country',str_replace,'Taiwan','2')) %>% mutate(across('country',str_replace,'China','2')) %>% mutate(across('country',str_replace,'Japan','2')) %>% mutate(across('country',str_replace,'Hong','2')) %>% mutate(across('country',str_replace,'Laos','2')) %>% mutate(across('country',str_replace,'Vietnam','2')) %>% mutate(across('country',str_replace,'Ecuador','3')) %>% mutate(across('country',str_replace,'South','3')) %>% mutate(across('country',str_replace,'Trinadad&Tobago','3')) %>% mutate(across('country',str_replace,'England','4')) %>% mutate(across('country',str_replace,'Germany','4')) %>% mutate(across('country',str_replace,'Poland','4')) %>% mutate(across('country',str_replace,'Ireland','4')) %>% mutate(across('country',str_replace,'Hungary','4')) %>% mutate(across('country',str_replace,'Holand-Netherlands','4'))%>% mutate(across('country',str_replace,'Greece','4')) %>% mutate(across('country',str_replace,'Scotland','4')) %>% mutate(across('country',str_replace,'Yugoslavia','4')) %>% mutate(across('country',str_replace,'Italy','4')) %>% mutate(across('country',str_replace,'France','4')) %>%  mutate(across('country',str_replace,'Portugal','4')) %>% mutate(across('country',str_replace,'Dominican-Republic','4'));

adult$country<- gsub('[^0-9]','1',adult$country);
adult$country<- gsub('11111111111111111111111111','1',adult$country);

temp<-adult;
temp$income<-as.numeric(factor(adult$income));
temp$occupation <-as.numeric(factor(adult$occupation));
temp$sex<-as.numeric(factor(adult$sex));
temp$race<-as.numeric(factor(adult$race));
temp$education_num<-as.numeric(factor(adult$education_num));
temp$marital<-as.numeric(factor(adult$marital));
temp$type_employer<-as.numeric(factor(adult$type_employer));
temp$country<-as.numeric(factor(temp$country));

temp<- subset(temp,select=-c(X,relationship,education,fnlwgt,capital_gain,capital_loss));

#visuals

#model
library(caTools);
set.seed(101);
sample<-sample.split(temp,SplitRatio=0.8);
train<-subset(temp,sample==T);
test<-subset(temp,sample==F);

library(MASS);
m1<- lda(income~.,train);

pred<-predict(m1,test);

table(pred$class,test$income);

plot(m1);



