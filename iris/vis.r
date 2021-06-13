library(tidyverse);

iris= read.csv("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/iris/Iris.csv")
pl<-ggplot(data=iris,aes(color=Species))
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/iris/irissepallength.png");
pl1<-pl+geom_point(aes(Id,SepalLengthCm));
print(pl1);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/iris/irissepalwidth.png");
pl1<-pl+geom_point(aes(Id,SepalWidthCm));
print(pl1);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/iris/irispetallength.png");
pl1<-pl+geom_point(aes(Id,PetalLengthCm ));
print(pl1);
dev.off();

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/iris/irispetalwidth.png");
pl1<-pl+geom_point(aes(Id,PetalWidthCm ));
print(pl1);
dev.off();

