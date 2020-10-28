df = read.csv("path/Salary.csv")
x = df$Years_of_exp #regressor
y = df$Salary #regressand
fit1 = lm(formula = y~x)
summary(fit1)
#model assesment 

