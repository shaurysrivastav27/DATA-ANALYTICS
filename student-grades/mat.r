#linear regression
#student-mat.csv
df<- read.csv("/home/shaury/Desktop/pvsc/data.sci/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R/student-mat.csv",sep=';')

#G1 G2 G3 grades for three sems;

#plot
library(tidyverse);
library(corrplot)
library(corrgram)
num.col<- sapply(df,is.numeric)
#filter
cor.data<-cor(df[,num.col])
print(cor.data)
#corr plot
#corrplot(cor.data)
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/corr.png");
print(corrgram(df));
dev.off();

#corrgram blue - positive corr,red - negative corr

#plots
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/g3bar.png");
pl<-ggplot(data=df,aes(G3))+geom_bar();
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/g2bar.png");
pl<-ggplot(data=df,aes(G2))+geom_bar();
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/g1bar.png");
pl<-ggplot(data=df,aes(G2))+geom_bar();
print(pl);
dev.off();


#train-test split

library(caTools)
set.seed(101)
sample<- sample.split(df$G3,SplitRatio=0.70)
train<-subset(df,sample==TRUE)
test<-subset(df,sample==FALSE)


#model
m1<- lm(G3~G1+G2+school+absences,train)
plot(m1) #for R2,residuals etc

#for plotting the lm in ggplot
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/G2lm.png");
pl<-ggplot(train,aes(G2,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/G1lm.png");
pl<-ggplot(train,aes(G1,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/abs.png");
pl<-ggplot(train,aes(absences,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'));
print(pl);
dev.off();


#resiudals plots - mostly normal
res<- residuals(m1);res = data.frame(res);
head(res);
ggplot(res,aes(res))+geom_histogram(aes(alpha=0.1,bins=10))
pred<-predict(m1,test);

to_zero= function(x){
			if(x<0){
 				return(0)
			}
			else{
				return(x)
			}
}
pred<-lapply(pred,to_zero);
results <- cbind(pred,test$G3);
colnames(results)<-c('pred','actual');
#R2
# R2 = 1 - SSE/SST
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/student-grades/images/model.png");
print(plot(m1));
dev.off();
SSE = sum( (results$pred - results$actual)^2 );
SST = sum( (mean(df$G3) - results$actual )^2 );
R2 = 1- SSE/SST;
print(R2);


