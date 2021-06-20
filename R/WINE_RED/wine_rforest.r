df<-read.csv("/home/shaury/Downloads/nptel/winequality-red.csv")
df<-na.omit(df);
 #View(df)
	summary(df$quality)
    temp<-c(1:nrow(df));
 #View(temp)
 	df<-cbind(temp,df)
 #Visualization
 library(tidyverse)
 	png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/WINE_RED/images/fixedacid.png");
 	pl<-ggplot(df)+geom_point(mapping=aes(df$temp,df$fixed.acidity,col=quality))+scale_color_gradient(high='red',low='green');
 	print(pl);
 	dev.off();
 	
 	png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/WINE_RED/images/chlorides.png");
 	pl<-ggplot(df)+geom_point(mapping=aes(df$temp,df$chlorides,color=quality))+scale_color_gradient(high='red',low='green');
 	print(pl);
 	dev.off();
 	
 	png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/WINE_RED/images/alcohol.png");
 	pl<-ggplot(df)+geom_point(mapping=aes(df$temp,df$alcohol,color=quality))+scale_color_gradient(high='red',low='green');
 	print(pl);
 	dev.off();
 	
 	png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/WINE_RED/images/ph.png");
 	pl<-ggplot(df)+geom_point(mapping=aes(df$temp,df$pH,color=quality))+scale_color_gradient(high='red',low='green');
 	print(pl);
 	dev.off();
 	
 	png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/WINE_RED/images/sulphates.png");
 	pl<-ggplot(df)+geom_point(mapping=aes(df$temp,df$sulphates,color=quality))+scale_color_gradient(high='red',low='green');
 	print(pl);
 	dev.off();
 	
library(caTools);
set.seed(101);
sample<-sample.split(df,SplitRatio=0.7);
train<-subset(df,sample==TRUE);
test<-subset(df,sample==FALSE);

library(randomForest);

m1<- randomForest(quality~.,train);
pred<-predict(m1,test);
pred<-round(pred,0);
table(pred,test$quality);
mean(pred==test$quality);











