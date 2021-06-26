
dataf<- read.csv('data_banknote_authentication.txt',sep=',',header = T,row.names = NULL)
id <- seq(1:nrow(dataf))
dataf<-cbind(id,dataf)
head(dataf)
corrgram(dataf)
cor(dataf)
#image.var,#image.skew

pl<- ggplot(dataf,aes(y=X.Class.))
pl+geom_point(aes(X.Image.Var.))
ggplot(dataf,aes(y=X.Image.Var.))+geom_point(aes(x=id,color=X.Class.))
ggplot(dataf)+geom_bar(aes(X.Class.,fill=factor(X.Class.)),position = 'dodge')
ggplot(dataf,aes(y=X.Image.Skew.))+geom_point(aes(x=id,color=X.Class.))
ggplot(dataf,aes(y=X.Image.Curt.))+geom_point(aes(x=id,color=X.Class.))
ggplot(dataf,aes(y=X.Entropy.))+geom_point(aes(x=id,color=X.Class.))
dataf<- subset(dataf,select = -c(id))
#scaling data.
maxs<- apply(subset(dataf,select= -c(X.Class.)),2,max)
mins<- apply(subset(dataf,select= -c(X.Class.)),2,min)
scaled.df<- scale(subset(dataf,select= -c(X.Class.)),center = maxs, scale= maxs - mins)
head(scaled.df)
scaled.df<-data.frame(scaled.df,dataf$X.Class.)
head(scaled.df)
#train-test split

library(caTools)
set.seed(101)
sample<- sample.split(scaled.df,SplitRatio = 0.7)
train<- subset(scaled.df,sample==TRUE);
test<- subset(scaled.df,sample==FALSE);

nn<- neuralnet(dataf.X.Class.~ X.Image.Var. + X.Image.Skew. + X.Image.Curt. + X.Entropy. ,data = train, hidden =10,linear.output = FALSE)
plot(nn)
pred <- compute(nn, subset(test,select= -c(dataf.X.Class.)))
str(pred)
round(pred$net.result[1])
max(pred$net.result)
head(pred$net.result)
ans <- sapply(pred$net.result,round)
unique(ans)
table(ans,test$dataf.X.Class.)
