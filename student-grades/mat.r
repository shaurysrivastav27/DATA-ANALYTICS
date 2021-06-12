#linear regression
#student-mat.csv
df<- read.csv("/home/shaury/Desktop/pvsc/data.sci/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R/student-mat.csv",sep=';')

#G1 G2 G3 grades for three sems;

#plot
library(corrplot)
library(corrgram)
num.col<- sapply(df,is.numeric)
#filter
cor.data<-cor(df[,num.col])
print(cor.data)
#corr plot
corrplot(cor.data)
corrgram(df) #without the is.numeric filter

#corrgram blue - positive corr,red - negative corr

corrgram(df,order=TRUE,lower.panel=panel.shades,higher.panel=panel.pie,text.panel=test)

#plots
ggplot(df,aes(G3))+geom_bar()
ggplot(df,aes(G2))+geom_bar()
ggplot(df,aes(G1))+geom_bar()

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
ggplot(train,aes(G2,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'))
ggplot(train,aes(G1,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'))
ggplot(train,aes(absences,G3))+geom_smooth(method='lm')+geom_point(aes(color='Red'))

#resiudals plots - mostly normal
res<- residuals(m1) %>% data.frame(res);
ggplot(res,aes(residuals.m1.))+geom_histogram(aes(alpha=0.1,bins=10))


to_zero= function(vec){
			if(x<0){
 				return(0)
			}
			else{
				return(x)
			}
}
pred<-sapply(pred,to_zero)
results <- c(pred,test$G3);
colnames(results)<-c('pred','actual');
#R2
# R2 = 1 - SSE/SST

SSE = sum( (results$pred - results$actual)^2 );
SST = sum( (mean(df$G3) - result$actual )^2 );
print(R2);

R2 = 1- SSE/SST;
