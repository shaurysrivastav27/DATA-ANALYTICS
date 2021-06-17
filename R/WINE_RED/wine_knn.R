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
 	
#model
 library(caTools)
 set.seed(123)
 sample<-sample.split(df,SplitRatio=0.8)
 train<-subset(df,sample==TRUE)
 test<-subset(df,sample==FALSE)
 library(class)
 train<-subset(df,sample==TRUE)
 seq1<-c(1:20)
mak=0
f_ind=0
 for(i in seq1)
	{
		k1<-knn(train,test,train$quality,k=i,prob=FALSE,use.all=TRUE)
		if(mak<mean(test$quality==k1))
		{
			print(mean(test$quality==k1))
			mak=mean(test$quality==k1)
			f_ind=i
			pred<-k1;
		}
	}
print("optimal choice for k is ")
print(f_ind)
table(pred,test$quality)
