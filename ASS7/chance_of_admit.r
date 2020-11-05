df = na.omit(df)
m2  = lm(df$Chance_of_Admit~df$GRE_Score+df$TOEFL_Score+df$LOR+df$CGPA+df$Research)
summary(m2)

#Call:
#lm(formula = df$Chance_of_Admit ~ df$GRE_Score + df$TOEFL_Score + 
#    df$LOR + df$CGPA + df$Research)

#Residuals:
#     Min        1Q    Median        3Q       Max 
#-0.266163 -0.023676  0.007726  0.035259  0.158377 

#Coefficients:
#                 Estimate Std. Error t value Pr(>|t|)    
#(Intercept)    -1.3412633  0.0990308 -13.544  < 2e-16 ***
#df$GRE_Score    0.0018845  0.0005023   3.752 0.000196 ***
#df$TOEFL_Score  0.0030283  0.0008612   3.516 0.000478 ***
#df$LOR          0.0189524  0.0038053   4.981 8.79e-07 ***
#df$CGPA         0.1238177  0.0093101  13.299  < 2e-16 ***
#df$Research     0.0252904  0.0066105   3.826 0.000147 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.06001 on 491 degrees of freedom
#Multiple R-squared:  0.822,	Adjusted R-squared:  0.8202 
#F-statistic: 453.4 on 5 and 491 DF,  p-value: < 2.2e-16

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
