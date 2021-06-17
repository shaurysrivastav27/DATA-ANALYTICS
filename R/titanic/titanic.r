
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
 
 impute_age = function(x,y){
		
	for(i in seq(1:length(x))){	
		if(is.na(x[i])){
			if(y[i]==1){
				x[i]= 37;
			}
		else if(y[i]==2){
			x[i] = 29;
		}		
		else{
			x[i] = 24;
		}
		}
	}
	return (x);
}

train$Age<- impute_age(train$Age,train$Pclass)
 train<- subset(train,select=-c(PassengerId,Name,Ticket,Cabin));

m1<-glm(Survived~.,family=binomial(link='logit'),train)
summary(m1);
 pred<- predict(m1,train);
 pred<- round(pred,0);
 table(pred,train$Survived);
m1<-glm(Survived~Pclass+Sex+Age+SibSp,family='gaussian',train);
pred<- predict(m1,train);
 pred<- round(pred,0);
 table(pred,train$Survived);
 #test data
test$Age<- impute_age(test$Age,test$Pclass)
 
 y_pred= predict(m1,test)
 y_pred=round(y_pred,0)
 res<-cbind(test$PassengerId,y_pred);
 colnames(res)<-c('PassengerId','Survived');
write.csv(res,"/home/shaury/answer.csv");




