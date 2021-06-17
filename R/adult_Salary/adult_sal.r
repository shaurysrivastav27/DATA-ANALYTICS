adult<- read.csv("/home/shaury/Desktop/pvsc/data.sci/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Machine Learning Projects/CSV files for ML Projects/adult_sal.csv");

#removing X;
library(tidyverse);
adult<-subset(adult,select=-c(X));

library(Amelia);
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmap.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();

adult<-na.omit(adult);



#plots;
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/race1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(race)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/race2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(race)),position='dodge');
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/education1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(education)))
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/education2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(education)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)))
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/employer.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(type_employer)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/hr_per_week.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(hr_per_week)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/occupation.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(occupation)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/relation.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(relationship)));
print(pl);
dev.off();

#employer rows
adult<-adult %>% mutate(across('type_employer',str_replace,'Never-worked','Unemployed')) %>% mutate(across('type_employer',str_replace,'Without-pay','Unemployed')) %>% mutate(across('type_employer',str_replace,'Federal-gov','gov')) %>% mutate(across('type_employer',str_replace,'Local-gov','gov')) %>% mutate(across('type_employer',str_replace,'State-gov','gov')) %>% mutate(across('type_employer',str_replace,'Self-emp-inc','self'))  %>% mutate(across('type_employer',str_replace,'Self-emp-not-inc','self')) 


#marital columns
#not married = 1,never married = 2, married = 3
adult<-adult %>% mutate(across('marital',str_replace,'Divorced','1')) %>%  mutate(across('marital',str_replace,'Separated','1')) %>% mutate(across('marital',str_replace,'Widowed','1')) %>% mutate(across('marital',str_replace,'Married-AF-spouse','3')) %>% mutate(across('marital',str_replace,'Married-civ-spouse','3')) %>% mutate(across('marital',str_replace,'Married-spouse-absent','3')) %>% mutate(across('marital',str_replace,'Never-married','3'))

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/employer.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(type_employer)),position='dodge')
print(pl);
dev.off();


#type_employer,occupation,country
library(naniar);
adult<-replace_with_na(adult,replace = list(country=c('?',' ?'),occupation=c('?',' ?'),type_employer=c('?',' ?')));

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmaps2.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();

adult<-na.omit(adult);
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmaps3.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();


png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/age-hist.png");
print(ggplot(adult)+geom_histogram(aes(age,fill=factor(income),color='black',alpha=0.1),bins=30));
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/hr_per_week-hist.png");
print(ggplot(adult)+geom_histogram(aes(hr_per_week,fill=factor(income),color='black',alpha=0.1),bins=30));
dev.off();
#mutate method
#adult<- adult %>% mutate(across('income',str_replace,'<=50K','1')) %>% mutate(across('income',str_replace,'>50K','0'));
#adult<-  adult %>% mutate(across('type_employer',str_replace,'gov','0')) %>% mutate(across('type_employer',str_replace,'self','1')) %>% mutate(across('type_employer',str_replace,'Private','2')) %>% mutate(across('type_employer',str_replace,'Unemployed','3')) %>% mutate(across('race',str_replace,'White','0')) %>% mutate(across('race',str_replace,'Black','1')) %>% mutate(across('race',str_replace,'Asian-Pac-Islander','2')) %>% mutate(across('race',str_replace,'Other','3')) %>% mutate(across('race',str_replace,'Amer-Indian-Eskimo','4')) %>% mutate(across('occupation',str_replace,'Adm-clerical','0')) %>% mutate(across('occupation',str_replace,'Handlers-cleaners','1')) %>% mutate(across('occupation',str_replace,'Prof-specialty','2')) %>% mutate(across('occupation',str_replace,'Exec-managerial','3')) %>% mutate(across('occupation',str_replace,'Other-service','4')) %>%  mutate(across('occupation',str_replace,'Transport-moving','5')) %>% mutate(across('occupation',str_replace,'Sales','6')) %>% mutate(across('occupation',str_replace,'Farming-fishing','7')) %>% mutate(across('occupation',str_replace,'Machine-op-inspct','8')) %>% mutate(across('occupation',str_replace,'Tech-support','9')) %>% mutate(across('occupation',str_replace,'Craft-repair','10')) %>% mutate(across('occupation',str_replace,'Protective-serv','11')) %>% mutate(across('occupation',str_replace,'Armed-Forces','12')) %>% mutate(across('occupation',str_replace,'Priv-house-serv','13')) %>% mutate(across('sex',str_replace,'Male','0')) %>% mutate(across('sex',str_replace,'Female','1'));

#factor method :
temp<-factor(adult$occupation); temp<-sapply(temp,as.numeric); 
adult<- adult %>% mutate(occupation=temp);

temp<-factor(adult$sex); temp<-sapply(temp,as.numeric);
adult<- adukt %>% mutate(sex= temp);

temp<-factor(adult$income); temp<-sapply(temp,as.numeric);
adult<- adukt %>% mutate(income = temp);


#country
#1NA,2ASIA,3SA,4EUROPE
adult<-  adult %>% mutate(across('country',str_replace,'United-States','1')) %>% mutate(across('country',str_replace,'Cuba','1')) %>% mutate(across('country',str_replace,'Jamaica','1')) %>% mutate(across('country',str_replace,'Puerto-Rico','1')) %>% mutate(across('country',str_replace,'Mexico','1')) %>% mutate(across('country',str_replace,'Honduras','1')) %>% mutate(across('country',str_replace,'Canada','1')) %>% mutate(across('country',str_replace,'Columbia','1')) %>% mutate(across('country',str_replace,'Outlying-US(Guam-USVI-etc)','1')) %>% mutate(across('country',str_replace,'Nicaragua','1')) %>% mutate(across('country',str_replace,'Peru','1')) %>% mutate(across('country',str_replace,'Haiti','1'))%>% mutate(across('country',str_replace,'El-Salvador','1')) %>% mutate(across('country',str_replace,'Guatemala','1')) %>% mutate(across('country',str_replace,'India','2')) %>% mutate(across('country',str_replace,'Iran','2')) %>% mutate(across('country',str_replace,'Philippines','2')) %>% mutate(across('country',str_replace,'Cambodia','2')) %>% mutate(across('country',str_replace,'Thailand','2')) %>% mutate(across('country',str_replace,'Taiwan','2')) %>% mutate(across('country',str_replace,'China','2')) %>% mutate(across('country',str_replace,'Japan','2')) %>% mutate(across('country',str_replace,'Hong','2')) %>% mutate(across('country',str_replace,'Laos','2')) %>% mutate(across('country',str_replace,'Vietnam','2')) %>% mutate(across('country',str_replace,'Ecuador','3')) %>% mutate(across('country',str_replace,'South','3')) %>% mutate(across('country',str_replace,'Trinadad&Tobago','3')) %>% mutate(across('country',str_replace,'England','4')) %>% mutate(across('country',str_replace,'Germany','4')) %>% mutate(across('country',str_replace,'Poland','4')) %>% mutate(across('country',str_replace,'Ireland','4')) %>% mutate(across('country',str_replace,'Hungary','4')) %>% mutate(across('country',str_replace,'Holand-Netherlands','4'))%>% mutate(across('country',str_replace,'Greece','4')) %>% mutate(across('country',str_replace,'Scotland','4')) %>% mutate(across('country',str_replace,'Yugoslavia','4')) %>% mutate(across('country',str_replace,'Italy','4')) %>% mutate(across('country',str_replace,'France','4')) %>%  mutate(across('country',str_replace,'Portugal','4')) %>% mutate(across('country',str_replace,'Dominican-Republic','4'));

adult$country<- sapply(adult$country,as.numeric);
adult<- adult %>% replace_na(list(country = 1));
adult$occupation<-sapply(adult$occupation,as.numeric);
adult$type_employer<-sapply(adult$type_employer,as.numeric);
adult$income<-sapply(adult$income,as.numeric);
adult$sex<-sapply(adult$sex,as.numeric);
adult$race<-sapply(adult$race,as.numeric);
adult$marital<-sapply(adult$marital,as.numeric);
#model
model.data<-subset(adult,select=-c(fnlwgt,education,relationship));
library(caTools);
set.seed(101);
sample<-sample.split(model.data,SplitRatio=0.75);
train<-subset(model.data,sample==TRUE);
test<-subset(model.data,sample==FALSE);

m1<-glm(income~.,family='gaussian',train)
summary(m1)

pred<-predict(m1,test);
pred<-ifelse(pred>0.5,1,0);
table(pred,test$income);

m1<-update(glm(income~.-country-type_employer,family='gaussian',train))
summary(m1)
pred<-predict(m1,test);
pred<-ifelse(pred>0.5,1,0);
table(pred,test$income);
mean(pred==test$income);







