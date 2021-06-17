#kaggle competition bike-sharing
train <-read.csv("bike-share/train.csv")
test <- read.csv("bike-share/test.csv")

library(ggplot2)
png('bike-share/temp-vs-count.png');
pl<-ggplot(train)+geom_point(aes(temp,count,color = temp))
print(pl);
dev.off();

png('bike-share/datetime-vs-count.png');
pl<-ggplot(train)+geom_point(aes(datetime,count,color = temp))+scale_color_gradient(high='red',low='green');
print(pl);
dev.off();

cor(train['temp'],train['count'])

png('bike-share/season-vs-count.png');
pl<-ggplot(train,aes(y=count))+geom_boxplot(aes(season,color = season,group=season))+scale_color_gradient(high='red',low='green');
print(pl);
dev.off();


library(tidyverse)
#feature engineering;
train<- separate(train,datetime,c('date','time'),sep=" ") %>% separate(train,time,c('hour'),sep=":");

train$hour<- as.numeric(train$hour);

test<- separate(test,datetime,c('date','time'),sep=" ") %>% separate(test,time,c('hour'),sep=":");

test$hour<- as.numeric(test$hour);

#visualizations
png('bike-share/hour-vs-count.png');
pl<-ggplot(train,aes(y=count))+geom_point(aes(hour,color = temp,group=temp))+scale_color_gradient(high='red',low='blue');
print(pl);
dev.off();

#for workng day
png('bike-share/wokingday-hour-vs-count.png');
pl<-ggplot(subset(train,train$workingday==1),aes(y=count))+geom_point(aes(hour,color = temp,group=temp))+scale_color_gradient(high='red',low='blue');
print(pl)
dev.off();

#for non working day;
png('bike-share/wokingday0-hour-vs-count.png');
pl<-ggplot(subset(train,train$workingday==0),aes(y=count))+geom_point(aes(hour,color = temp,group=temp))+scale_color_gradient(high='red',low='blue');
print(pl)
dev.off();


#feature selection
library(corrgram);
corrgram(train);

#infrence - temp,atemp,hour,season,humidity have correlation with count;

m1<-lm(count~season+holiday+workingday+weather+temp+atemp+humidity+windspeed+hour,data=train)
summary(m1);
#infrence -weather,working,holidayday have high p values ;

m1<-update(lm(count~season+temp+atemp+humidity+windspeed+hour,data=train))
summary(m1);

pred<-predict(m1,test);
zer <- function(pred){
	if(pred>0) {
		return (pred)
		}
	else{
		return (0)
		}
}
pred<-sapply(pred,zer);

pred<- round(pred,0);

results<- cbind(pred,test$count);
colnames(results) <- c('pred','actual');
SSE = sum( (results$pred - results$actual)^2 );
SST = sum( (mean(df$G3) - result$actual )^2 );

R2 = 1- SSE/SST;

print(R2);

pred.answer<- predict(m1,test);
df<- data.frame(test$datetime);
result<- cbind(df,pred);
write.csv(result , "bike-share/answer.csv")



