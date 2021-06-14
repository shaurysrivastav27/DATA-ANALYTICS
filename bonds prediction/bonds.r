df = read.csv("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/bonds.csv")
df<-na.omit(df);

x = df$CouponRate
y = df$BidPrice

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/xvsy.png");
print(plot(x,y));
dev.off();

m1 = lm(y~x) #fit model
summary(m1);


png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/xvsym1.png");
pl<-plot(x,y) 
#plot the fitted line
print(pl+abline(m1));
dev.off();

y1 = predict(m1,data.frame(x))

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/res.png");
pl<-plot(y1,rstandard(m1)) # plotting residual
print(pl+abline(h = 2,lty=2)+abline(h= -2,lty=2));
dev.off();

# identify(y1,rstandard(m1)) //identifying point with anamoly behaviour
# reduced model
p = c(3,35,4,34) #skewed points or outliers
df = df[-c(3,35,4,34),]
x = df$CouponRate
y = df$BidPrice
png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/xvsy2.png");
print(plot(x,y)) # comes out to be linear perfectly
dev.off();


m1 = update(lm(y~x)) # // fit model

png("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/bonds prediction/xvsym2.png");
print(plot(x,y)+abline(m1)) 
dev.off();


y1 = predict(m1,data.frame(x))

summary(m1)
