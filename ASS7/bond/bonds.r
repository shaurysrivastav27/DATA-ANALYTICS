df = read.delim("path/bonds.txt")
x = df$CouponRate
y = df$BidPrice
plot(x,y) # comes out to be linear almost
m1 = lm(y~x) // fit model
plot(x,y) 
abline(m1) // plot the fitted line
y1 = predict(m1,data.frame(x))
plot(y1,rstandard(m1)) // plotting residual
abline(h = 2,lty=2) 
abline(h= -2,lty=2)
identify(y1,rstandard(m1)) //identifying point with anamoly behaviour
# reduced model
p = c(3,35,4,34) //skewed points
df = df[-c(3,35,4,34),]
x = df$CouponRate
y = df$BidPrice
plot(x,y) # comes out to be linear perfectly
m1 = lm(y~x) // fit model
plot(x,y) 
abline(m1) // plot the fitted line
y1 = predict(m1,data.frame(x))

summary(m1)
