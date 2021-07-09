
dataf = read.csv('pvsc/data.sci/python/Refactored_Py_DS_ML_Bootcamp-master/10-Data-Capstone-Projects/911.csv')
head(dataf)
library(tidyverse)

dataf <- dataf %>% separate(title , c('reason','title'),sep = ':')
head(dataf)

head(dataf %>% count(zip,sort=T))
library(Amelia)
missmap(dataf,main='Missing Map')

head(dataf %>% count(twp,sort=T)) 

ggplot(dataf)+geom_bar(aes(x=reason,fill=factor(reason)))

head(dataf$timeStamp)
dataf$timeStamp <- as.POSIXct(dataf$timeStamp,format="%Y-%m-%d %H:%M:%OS")
head(dataf)


dataf$hour <- format(dataf$timeStamp,'%H')
dataf$month <- format(dataf$timeStamp,'%m')
dataf$days <- weekdays(dataf$timeStamp)
dataf$date<- format(dataf$timeStamp,"%Y-%m-%d")
head(dataf)

ggplot(dataf)+geom_bar(aes(x=days,fill=factor(reason)),position = 'dodge')

ggplot(dataf)+geom_bar(aes(x=month,fill=factor(reason)),position = 'dodge')


# bymonth <- df.groupby('month').count()
bymonth = dataf %>% group_by(month) 
bymonth <- count(bymonth,reason)
bymonth
calls = NULL;
j <-1;
for (i in unique(dataf$month)) {
    calls[j]<- sum(bymonth[bymonth$month==i,]$n)
  j=j+1;
}
bymonth <- cbind(unique(dataf$month),calls)
colnames(bymonth) <- c('month','calls')
bymonth<- bymonth %>% data.frame() %>% sapply(as.numeric) %>% data.frame() %>% arrange(month)
bymonth
ggplot(bymonth)+geom_line(aes(x=month,y=calls,col='red'))
ggplot(bymonth,aes(x=month,y=calls))+geom_smooth(aes(col='red'),method='lm')+geom_point()

head(dataf)
#date count
bydate <- dataf %>% group_by(date)
bydate <- count(bydate,reason)
bydate
calls <- NULL;
j<-1;
for(i in unique(dataf$date)){
    calls[j] <- sum(bydate[bydate$date==i,]$n)
    j= j+1
}
bydate <- cbind(unique(dataf$date),calls)
colnames(bydate)<- c('date','calls')
bydate <- bydate %>% data.frame() 
bydate$date <- as.POSIXct(bydate$date,format='%Y-%m-%d')
bydate$calls <- as.numeric(bydate$calls)
bydate <- bydate %>% data.frame() %>% arrange(date)
ggplot(bydate)+geom_line(aes(x=date,y=calls))
#ems
bydate <- dataf %>% group_by(date)
bydate <- count(bydate,reason)
ems <- bydate[bydate$reason=='EMS',]
ems$date <- as.POSIXct(ems$date,format='%Y-%m-%d')
ems$n <- as.numeric(ems$n)
ggplot(ems)+geom_line(aes(x=date,y=n))
#fire
fire <- bydate[bydate$reason=='Fire',]
fire$date <- as.POSIXct(fire$date,format='%Y-%m-%d')
fire$n <- as.numeric(fire$n)
ggplot(fire)+geom_line(aes(x=date,y=n))

#traffic
traffic <- bydate[bydate$reason=='Traffic',]
traffic$date <- as.POSIXct(traffic$date,format='%Y-%m-%d')
traffic$n <- as.numeric(traffic$n)
ggplot(traffic)+geom_line(aes(x=date,y=n))


#hour day group by
dataf$new<- as.character(dataf$hour)
dataf$new <-paste(dataf$new, dataf$days)
byhour <- dataf %>% group_by(new)
head(byhour)
byhour <- count(byhour,reason)
calls <- NULL;
j<-1;
for(i in unique(byhour$new)){
  calls[j] <- sum(byhour[byhour$new==i,]$n)
  j= j+1
}
mat <- matrix(calls,7,24,byrow=T)
heatmap(mat)


#month day group by
dataf$new <- paste(dataf$month,dataf$days)
bymonthday<- dataf %>% group_by(new)
bymonthday<- count(bymonthday,reason)
bymonthday
calls <- NULL;
j<-1;
for(i in unique(bymonthday$new)){
  calls[j] <- sum(bymonthday[bymonthday$new==i,]$n)
  j= j+1
}
mat <- matrix(calls,7,9,byrow=T)
colnames(mat) = c(unique(dataf$month))
heatmap(mat)








