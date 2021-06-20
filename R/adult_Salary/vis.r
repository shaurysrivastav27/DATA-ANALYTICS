library(Amelia);
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmap.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();
#plots;
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/race1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(race)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/race2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(race)),position='dodge');
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/education1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(education)))
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/education2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(education)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige1.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)))
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/employer.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(type_employer)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/hr_per_week.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(hr_per_week)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/occupation.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(occupation)));
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/relation.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(relationship)));
print(pl);
dev.off();



#after feauture engineering
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/marraige2.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(marital)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/employer.png");
pl<-ggplot(adult)+geom_bar(aes(income,fill=factor(type_employer)),position='dodge')
print(pl);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmaps2.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();

adult<-na.omit(adult);
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/missmaps3.png");
print(missmap(adult,main='Missing Map',col=c('yellow','black'),legend=FALSE));
dev.off();


png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/age-hist.png");
print(ggplot(adult)+geom_histogram(aes(age,fill=factor(income),color='black',alpha=0.1),bins=30));
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/adult_Salary/images/hr_per_week-hist.png");
print(ggplot(adult)+geom_histogram(aes(hr_per_week,fill=factor(income),color='black',alpha=0.1),bins=30));
dev.off();
