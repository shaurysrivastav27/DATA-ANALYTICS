#kmeans clustering project
df1<- read.csv('/Users/HP/Downloads/winequality-red.csv',sep=';')
df2<- read.csv('/Users/HP/Downloads/winequality-white.csv',sep=';')
head(df2)
head(df1)

#adding labels
vec<-NULL;
for (i in seq(nrow(df1))){
  vec[i]<-'white';
 }
df1$label<-vec;
head(df1);

vec<-NULL;
for (i in seq(nrow(df2))){
  vec[i]<-'white';
 }
df2$label<-vec;
head(df2)


wine<-rbind(df1,df2)
head(wine)
tail(wine)

#eda
ggplot(wine)+geom_histogram(aes(residual.sugar,fill=factor(label)),color='black');

ggplot(wine)+geom_histogram(aes(wine$citric.acid,fill=factor(label)),color='black');

ggplot(wine)+geom_histogram(aes(alcohol,fill=factor(label)),color='black');

ggplot(wine)+geom_point(aes(residual.sugar,citric.acid,color=label),alpha=0.2)

ggplot(wine)+geom_point(aes(volatile.acidity,residual.sugar,color=label),alpha=0.2)

dataf<- subset(wine,select = -c(label))

wine.model<- kmeans(dataf,centers = 2,nstart=20,trace=FALSE);

print(wine.model)

table(wine.model$cluster,wine$label)
