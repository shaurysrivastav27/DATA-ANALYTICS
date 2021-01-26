df = read.csv("path/Salary.csv")
x = df$Years_of_exp #regressor
y = df$Salary #regressand
plot(x,y)


fit1 = lm(formula = y~x)
summary(fit1)

#model assesment 
y1 = predict(fit1,data.frame(x = c(1.3,2,3.7,1.5,1.2)))


#residual plot
res = y-y1
plot(res,y)
