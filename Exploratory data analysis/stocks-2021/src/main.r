# data for 2021
library(quantmod)
library(tidyverse)
getSymbols(Symbols = 'BAC',auto.assign = T)
BACdf<- data.frame(date=index(BAC),coredata(BAC))
BAC <- BACdf[format(BACdf$date,'%Y')>'2020',]

getSymbols(Symbols = 'C',auto.assign = T)
Cdf<- data.frame(date=index(C),coredata(C))
C <- Cdf[format(Cdf$date,'%Y')>'2020',]

getSymbols(Symbols = 'JPM',auto.assign = T)
JPMdf<- data.frame(date=index(JPM),coredata(JPM))
JPM <- JPMdf[format(JPMdf$date,'%Y')>'2020',]

banks <- merge.data.frame(BAC,JPM,all.x = T)
banks<- merge.data.frame(banks,C,all.x=T)
head(banks)

#maximum and minimum closing prices of stocks
maxclose<- sapply(subset(banks,select=c(BAC.Close,C.Close,JPM.Close)),max,2)
maxclose

minclose<- sapply(subset(banks,select=c(BAC.Close,C.Close,JPM.Close)),min,2)
minclose

reter = function(x){
  return (x/(x-1))
}
banksr<- sapply(subset(banks,select=c(BAC.Close,C.Close,JPM.Close)),reter)
banksr <- data.frame(banksr)
rownames(banksr)<-banks$date
colnames(banksr)<-c('BAC','C','JPM')

#histogram plots
ggplot(banksr)+geom_histogram(aes(BAC),color='pink',bins=10)
ggplot(banksr)+geom_histogram(aes(JPM),color='pink',bins=10)
ggplot(banksr)+geom_histogram(aes(C),color='pink',bins=10)

#scatter plots
pl<- ggplot(banksr)
pl+geom_point(aes(x=BAC,y=JPM,alpha=0.2))
pl+geom_point(aes(x=BAC,y=C,alpha=0.2))
pl+geom_point(aes(x=C,y=JPM,alpha=0.2))

#minimum and maximum returns
minret<- sapply(banksr,min,2)
minret
minret[2]

maxret<- sapply(banksr,max,1)
maxret

#minimum returns day
for (i in colnames(banksr)){
  print(banksr[banksr[i]==minret[i],])
}

#maximum returns day
for (i in colnames(banksr)){
  print(banksr[banksr[i]==maxret[i],])
}

banksr$date<- banks$date
str(banksr)
rownames(banksr)<- NULL;
#final plots
library(ggside)
pl<-ggplot(banksr)+geom_density(aes(x=BAC,fill='BAC'))
pl+geom_density(aes(x=JPM,fill='JPM'))+geom_density(aes(x=C,fill='C'))

pl<-ggplot(banksr)
pl+geom_line(aes(x=date,y=BAC))
pl+geom_line(aes(x=date,y=C))
pl+geom_line(aes(x=date,y=JPM))

pl<-ggplot(banksr)
pl<-pl+geom_line(aes(x=date,y=BAC,color='BAC'))+geom_line(aes(x=date,y=C,color='C'))
pl<-pl+geom_line(aes(x=date,y=JPM,,color='JPM'))+labs(x='date',y='returns')
pl

library(corrgram)
corrgram(banksr)
library(corrplot)
corrplot(cor(subset(banksr,select=-c(date))),method='number',col=c('black','yellow'))
#clustermap
heatmap(cor(subset(banksr,select=-c(date))))

library(plotly)
pl<-ggplotly(pl)
pl
