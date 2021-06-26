
library(MASS)
head(Boston)

library(tidyverse)
summary(Boston)

any(is.na(Boston))

dataf<-Boston;

ggplot(dataf)+geom_point(aes(crim,medv))
cor(dataf$medv,dataf$crim)
library(corrgram)
corrgram(dataf)

pl<- ggplot(dataf,aes(y=medv));
pl+geom_point(aes(black))
pl+geom_point(aes(lstat))
pl+geom_point(aes(tax))
pl+geom_point(aes(rad))
pl+geom_point(aes(age))
cor(dataf)
#tax , nox,ptratio , lstat,rm,indus,age

dataf<- scale(dataf)

cor(dataf)
#normalize data
maxs <- apply(dataf,2,max)
maxs
mins <- apply(dataf,2,min)
mins

scaled.dataf<-scale(dataf,center = mins,scale = maxs-mins);
scaled<- data.frame(scaled.dataf)

library(caTools)
set.seed(101)
sample<- sample.split(scaled,SplitRatio = 0.7)
train<- subset(scaled,sample==TRUE)
test<- subset(scaled,sample==FALSE);


library(neuralnet)
nn <- neuralnet(medv~tax+nox+ptratio+lstat+rm+age+indus,data = train,hidden = c(5,3),linear.output =TRUE)
plot(nn)

pred <- compute(nn,subset(test,select = -c(medv)))

str(pred)

true.pred<- (pred$net.result*(max(dataf$medv)-min(dataf$medv))) + min(dataf$medv)

test.r<- test$medv*(max(dataf$medv)-min(dataf$medv)) + min(dataf$medv)
mse = (sum((test.r-true.pred)^2))/nrow(test);
mse
err.df<-data.frame(test.r,true.pred)
ggplot(err.df)+geom_point(aes(test.r,true.pred))+geom_smooth(aes(test.r,true.pred))

