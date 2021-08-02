library(tidyverse)
boston <- read.csv('/home/shaury/boston.csv')
head(boston)
library(caTools)
set.seed(101)
sample = sample.split(boston,SplitRatio = 0.8)
train = subset(boston,sample==T)
test = subset(boston,sample==F)
str(train)
str(test)
# linear regression simple
model1 = lm(Price~.,data=train)
model1$coefficients
model1$residuals
plot(model1$residuals)
abline(h = 2)
abline(h = -2)
plot(model1)

pred = predict(model1,test)
sse = sum((pred-test$Price)^2)
sst = sum((pred-mean(test$Price))^2)
1- (sse/sst)

#lasso 
library(glmnet)
x_train = model.matrix(Price~.,data=train)
y_train = train$Price
x_test = model.matrix(Price~.,data=test)
y_test = test$Price
model2 = glmnet(x_train,y_train,data=train,alpha = 1)
cv.out = cv.glmnet(x_train,y_train,alpha=1)
plot(cv.out)
cv.out$lambda.min

pred2 = predict(model2,s=cv.out$lambda.min,newx = x_test)
sse = sum((pred2-y_test)^2)
sst = sum((pred2-mean(y_test))^2)
1- (sse/sst)

# random forest
library(randomForest)
model3 = randomForest(Price~.,n.tree=100,mtry=5,data=train)
pred3 = predict(model3,test)
plot(x=pred3,y=test$Price)



sse = sum((pred3-test$Price)^2)
sst = sum((pred3-mean(test$Price))^2)
1- (sse/sst)


pred = (pred+pred2+pred3)/3
sse = sum((pred-y_test)^2)
sst = sum((pred-mean(y_test))^2)
1- (sse/sst)
head(boston)
library(neuralnet)
mx = max(test$Price)
mi = min(test$Price)
maxtab = sapply(train,max,2)
mintab = sapply(train,min,2)
maxteb = sapply(test,max,2)
minteb = sapply(test,min,2)
scaledtrain<- scale(train,center = mintab ,scale = maxtab-mintab)
scaledtest<- scale(test,center = minteb ,scale = maxteb-minteb)
model4<- neuralnet(Price~X0+X1+X2+X3+X4+X5+X6+X7+X8+X9+X10+X11+X12,hidden=c(12,6,4),data=scaledtrain,linear.output=T)
plot(model4)
pred4<- compute(model4,scaledtest)
ans = (pred4$net.result*(mx-mi)) + mi
head(ans)
sse = sum((ans-test$Price)^2)
sst = sum((ans-mean(test$Price))^2)
1- (sse/sst)
#infrence: random forest performs much better in case of this dataset
ans = data.frame(ans,pred3,test$Price)
colnames(ans) = c('NN','RF','AC')
head(ans)

