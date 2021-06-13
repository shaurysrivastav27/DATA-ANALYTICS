library(ggplot2)



png('bike-share/temp-vs-count.png');
pl<-ggplot(train)+geom_point(aes(temp,count,color = temp))
print(pl);
dev.off();

png('bike-share/datetime-vs-count.png');
pl<-ggplot(train)+geom_point(aes(datetime,count,color = temp))+scale_color_gradient(high='red',low='green');
print(pl);
dev.off();



png('bike-share/season-vs-count.png');
pl<-ggplot(train,aes(y=count))+geom_boxplot(aes(season,color = season,group=season))+scale_color_gradient(high='red',low='green');
print(pl);
dev.off();

png('bike-share/hour-vs-count.png');
pl<-ggplot(train,aes(y=count))+geom_point(aes(hour,color = temp,group=temp))+scale_color_gradient(high='red',low='blue');
print(pl);
dev.off();


#after feature engineering

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
