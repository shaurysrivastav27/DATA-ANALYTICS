df = read_csv("path/admission.csv")
df = na.omit(df)
m2  = lm(df$Chance_of_Admit.~,data=df)
summary(m2)
# Call:
# lm(formula = df$Chance_of_Admit ~ ., data = df)

#Residuals:
#      Min        1Q    Median        3Q       Max 
#-0.266883 -0.022999  0.009031  0.033434  0.156761 

#Coefficients:
#                    Estimate Std. Error t value Pr(>|t|)    
#(Intercept)       -1.2798040  0.1042101 -12.281  < 2e-16 ***
#GRE_Score          0.0018523  0.0005022   3.689 0.000251 ***
#TOEFL_Score        0.0027833  0.0008716   3.193 0.001497 ** 
#University_Rating  0.0060727  0.0038000   1.598 0.110670    
#SOP                0.0016630  0.0045654   0.364 0.715820    
#LOR                0.0164008  0.0041514   3.951 8.94e-05 ***
#CGPA               0.1191327  0.0097052  12.275  < 2e-16 ***
#Research           0.0244154  0.0066162   3.690 0.000249 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.05991 on 489 degrees of freedom
#Multiple R-squared:  0.8233,	Adjusted R-squared:  0.8208 
#F-statistic: 325.5 on 7 and 489 DF,  p-value: < 2.2e-16



y1 = predict(m2,data.frame(df$GRE_Score+df$TOEFL_Score+df$LOR+df$CGPA+df$Research))
plot(y1,rstandard(m2))
abline(h=2,lty=2)
abline(h=-2,lty=2)
vec=identify(y1,rstandard(m2))

vec
#[1]   9  10  38  39  40  57  59  61  62  63  64  65  66  78  90  91  92  93 101
#[20] 113 325 356 357 372 374 384 481
df1 = df[-c(vec),]
m3 = lm(df1$Chance_of_Admit~ df1$GRE_Score+df1$TOEFL_Score+df1$LOR+df1$CGPA+df1$Research)
summary(m3)

#Call:
#lm(formula = df1$Chance_of_Admit ~ df1$GRE_Score + df1$TOEFL_Score + 
#   df1$LOR + df1$CGPA + df1$Research)

#Residuals:
#    Min       1Q   Median       3Q      Max 
#-0.16426 -0.02475  0.00306  0.02879  0.11190 

#Coefficients:
#                  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)     -1.3408903  0.0772981 -17.347  < 2e-16 ***
#df1$GRE_Score    0.0020891  0.0003890   5.371 1.24e-07 ***
#df1$TOEFL_Score  0.0027725  0.0006552   4.231 2.80e-05 ***
#df1$LOR          0.0176933  0.0029215   6.056 2.88e-09 ***
#df1$CGPA         0.1208630  0.0071631  16.873  < 2e-16 ***
#df1$Research     0.0239942  0.0051726   4.639 4.57e-06 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.04502 on 464 degrees of freedom
#Multiple R-squared:  0.8888,	Adjusted R-squared:  0.8876 
#F-statistic: 741.4 on 5 and 464 DF,  p-value: < 2.2e-16

y1 = predict(m3,data.frame(df1$GRE_Score+df1$TOEFL_Score+df1$LOR+df1$CGPA+df1$Research))
plot(y1,rstandard(m3))
