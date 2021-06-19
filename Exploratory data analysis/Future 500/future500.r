dataf<- read.csv("/home/shaury/Desktop/pvsc/data.sci/superds/future500.csv",header=T,na.strings=c('',' ','?','-'));
library(tidyverse);

#data cleaning
#for special characters: alphabets,characters;
dataf$Revenue<- gsub('[^0-9]','',dataf$Revenue);
dataf$Expenses <- gsub('[^0-9]','',dataf$Expenses);
dataf$Growth<- gsub('[^0-9]','',dataf$Growth);
#conversion into numeric
dataf$Growth<- sapply(dataf$Growth,as.numeric);
dataf$Revenue<-sapply(dataf$Revenue,as.numeric);
dataf$Expenses<-sapply(dataf$Expenses,as.numeric);

#for picking up the NA values; 
dataf[complete.cases(dataf),] #row complete or not;


#missing data - INDUSTRY
temp<-dataf;
#temp[is.na(temp$Industry)]; #for selecting the na rows 
temp<- temp[!is.na(temp$Industry),]; # deleting the rows

#reseting the row numbers
rownames(temp)<-c(1:498) #or NULL;

#factual analysis method - STATE;
temp[is.na(temp$State) & temp$City=='New York','State']<-'NY';
temp[is.na(temp$State) & temp$City=='San Francisco','State']<-'CA';

#median imputation;
m<-median(temp[temp$Industry=='Retail','Employees'],na.rm=TRUE);
temp[is.na(temp$Employees) & temp$Industry=='Retail','Employees']<-m;

m<-median(temp[temp$Industry=='Financial Services','Employees'],na.rm=TRUE);
temp[is.na(temp$Employees) & temp$Industry=='Financial Services','Employees']<-m;


m<-median(temp[temp$Industry=='Construction','Growth'],na.rm=TRUE);
temp[ temp$Industry=='Construction' & is.na(temp$Growth),'Growth']<-m;


#revenue - profit = expenses.
m<-median(temp[temp$Industry=='Construction','Revenue'],na.rm=TRUE);
temp[temp$Industry=='Construction' & is.na(temp$Revenue),'Revenue']<-m;

m<-median(temp[temp$Industry=='Construction','Profit'],na.rm=TRUE);
temp[temp$Industry=='Construction' & is.na(temp$Profit),'Profit']<-m;

temp <- temp %>% mutate(Expenses = Revenue - Profit);

#scatter plots 
png("/home/shaury/Desktop/pvsc/data.sci/superds/advR/Future\ 500/revvsind.png");
pl<-ggplot(temp,aes(x = ID)) + geom_point(aes(y = Revenue, col = Industry ));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/superds/advR/Future\ 500/expvsind.png");
pl<-ggplot(temp,aes(x = ID)) + geom_point(aes(y = Expenses, col = Industry ));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/superds/advR/Future\ 500/profitvsind.png");
pl<-ggplot(temp,aes(x = ID)) + geom_point(aes(y = Profit, col = Industry ));
print(pl);
dev.off();



#scatter plot :: revenue ~ expenses
png("/home/shaury/Desktop/pvsc/data.sci/superds/advR/Future\ 500/revvsexp.png");
pl<-ggplot(temp,aes(x = Revenue)) + geom_point(aes(y = Expenses, col = Industry , size = Profit ,alpha= 0.1)) + geom_smooth(aes(y = Expenses, color = Industry),fill=NA,size=1.2);
print(pl);
dev.off();




#boxpolts
png("/home/shaury/Desktop/pvsc/data.sci/superds/advR/Future\ 500/growth.png");
pl<-ggplot(temp,aes(x= Industry ,y = Growth)) + geom_jitter(aes(color = Industry)) + geom_boxplot(aes(fill = Industry) , alpha = 0.5, outlier.color= NA);
print(pl);
dev.off();












