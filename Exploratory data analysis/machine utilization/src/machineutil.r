mutil<- read.csv('/home/shaury/Desktop/pvsc/data.sci/superds/macuti.csv');
dataf<-mutil;
library(Amelia);
png("/home/shaury/Desktop/pvsc/data.sci/advR/missmap.png");
print(missmap(dataf,main='Missing Map',col=c('yellow','black')));
dev.off();
library(tidyverse);
#3% - missing data 97% - observed data;

#adding the utilization column
dataf$Utilization <- 1-dataf$Percent.Idle;

#date-time

PosixTime<- as.POSIXct(dataf$Timestamp,format = '%d/%m/%Y %H:%M');
dataf$PosixTime<- PosixTime;

dataf$Timestamp <- NULL; #dropping a column
dataf<- dataf[,c(4,1,2,3)]; #rearranging data
#RL1
RL1<- dataf[dataf$Machine=='RL1',];
RL1$Machine<-factor(RL1$Machine);

#construction of list;
mac_rl1_stats<- c(min(RL1$Utilization,na.rm=TRUE),max(RL1$Utilization,na.rm=TRUE),mean(RL1$Utilization,na.rm=TRUE))

RL1$Utilization< 0.90; #for true false vectors;
mac_rl1_u90<-as.logical(length(which(RL1$Utilization< 0.90)>0)); #returns the cols where its true
list_rl1<- list('RL1',mac_rl1_stats,mac_rl1_u90);

list_rl1$Unknown_hours <- RL1[is.na(RL1$Utilization),'PosixTime'];

list_rl1$datafRL1<- RL1;

#time series plots;
p<- ggplot(RL1);
RL1plot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/RL1.png");
print(RL1plot);
dev.off();
list_rl1$plot<-RL1plot;
#----------------------------------------------------------------

SR6<- dataf[dataf$Machine=='SR6',];
SR6$Machine<-factor(SR6$Machine);

#construction of list;
mac_sr6_stats<- c(min(SR6$Utilization,na.rm=TRUE),max(SR6$Utilization,na.rm=TRUE),mean(SR6$Utilization,na.rm=TRUE))

SR6$Utilization< 0.90; #for true false vectors;
mac_sr6_u90<-as.logical(length(which(SR6$Utilization< 0.90)>0)); #returns the cols where its true
list_sr6<- list('SR6',mac_sr6_stats,mac_sr6_u90);

list_sr6$Unknown_hours <- SR6[is.na(SR6$Utilization),'PosixTime'];

list_sr6$datafSR6<- SR6;

#time series plots;
p<- ggplot(SR6);
SR6plot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/SR6.png");
print(SR6plot);
dev.off();
list_sr6$plot<-SR6plot;

#-----------------------------------------------

SR4A<- dataf[dataf$Machine=='SR4A',];
SR4A$Machine<-factor(SR4A$Machine);

#construction of list;
mac_sr4a_stats<- c(min(SR4A$Utilization,na.rm=TRUE),max(SR4A$Utilization,na.rm=TRUE),mean(SR4A$Utilization,na.rm=TRUE))

SR4A$Utilization< 0.90; #for true false vectors;
mac_sr4a_u90<-as.logical(length(which(SR4A$Utilization< 0.90)>0)); #returns the cols where its true
list_sr4a<- list('SR4A',mac_sr4a_stats,mac_sr4a_u90);

list_sr4a$Unknown_hours <- SR4A[is.na(SR4A$Utilization),'PosixTime'];

list_sr4a$datafSR4A<- SR4A;

#time series plots;
p<- ggplot(SR4A);
SR4Aplot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/SR4A.png");
print(SR4Aplot);
dev.off();
list_sr4a$plot<-SR4Aplot;


##---------------------------------------------


RL2<- dataf[dataf$Machine=='RL2',];
RL2$Machine<-factor(RL2$Machine);

#construction of list;
mac_rl2_stats<- c(min(RL2$Utilization,na.rm=TRUE),max(RL2$Utilization,na.rm=TRUE),mean(RL2$Utilization,na.rm=TRUE))

RL2$Utilization< 0.90; #for true false vectors;
mac_rl2_u90<-as.logical(length(which(RL2$Utilization< 0.90)>0)); #returns the cols where its true
list_rl2<- list('RL2',mac_rl2_stats,mac_rl2_u90);

list_rl2$Unknown_hours <- RL2[is.na(RL2$Utilization),'PosixTime'];

list_rl2$datafRL2<- RL2;

#time series plots;
p<- ggplot(RL2);
RL2plot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/RL2.png");
print(RL2plot);
dev.off();
list_rl2$plot<-RL2plot;


#-------------------------------------------------------------------------


SR1<- dataf[dataf$Machine=='SR1',];
SR1$Machine<-factor(SR1$Machine);

#construction of list;
mac_sr1_stats<- c(min(SR1$Utilization,na.rm=TRUE),max(SR1$Utilization,na.rm=TRUE),mean(SR1$Utilization,na.rm=TRUE))

SR1$Utilization< 0.90; #for true false vectors;
mac_sr1_u90<-as.logical(length(which(SR1$Utilization< 0.90)>0)); #returns the cols where its true
list_sr1<- list('SR1',mac_sr1_stats,mac_sr1_u90);

list_sr1$Unknown_hours <- SR1[is.na(SR1$Utilization),'PosixTime'];

list_sr1$datafRL1<- RL1;

#time series plots;
p<- ggplot(SR1);
SR1plot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/SR1.png");
print(SR1plot);
dev.off();
list_sr1$plot<-RL1plot;




#------------------------------------final plot;
p<- ggplot(dataf);
dfplot<- p + geom_line(aes(x=PosixTime, y=Utilization,col=Machine),size=0.75)+facet_grid(Machine~.)+geom_hline(yintercept=0.90,col='Grey',size=1.2,linetype=3);
png("/home/shaury/Desktop/pvsc/data.sci/advR/df.png");
print(dfplot);
dev.off();




























