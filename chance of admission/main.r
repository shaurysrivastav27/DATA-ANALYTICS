df = read.csv("/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/admission.csv")
df = na.omit(df)


library(tidyverse);
pl<-ggplot(df,aes(y=Chance_of_Admit))

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/GRE_Score.png');
pl1<- pl+ geom_point(aes(GRE_Score,color='Red'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/TOEFL.png');
pl1<- pl+ geom_point(aes(TOEFL_Score,color='Green'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/UniRate.png');
pl1<- pl+ geom_point(aes(University_Rating,color='Blue'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/sop.png');
pl1<- pl+ geom_point(aes(SOP,color='Red'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/lor.png');
pl1<- pl+ geom_point(aes(LOR,color='Green'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/cgpa.png');
pl1<- pl+ geom_point(aes(CGPA,color='Blue'));
print(pl1);
dev.off();

png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/research.png');
pl1<- pl+ geom_point(aes(Research ,color='Red'));
print(pl1);
dev.off();


modml  = lm(Chance_of_Admit~.,data=df)
summary(modml)
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



y1 = predict(modml,df);
png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/rstd1.png');
plot(y1,rstandard(modml));
abline(h=2,lty=2);
abline(h=-2,lty=2);
dev.off();

modml<- update(lm(Chance_of_Admit~.-University_Rating-SOP,df));
summary(modml)

#Call:
#lm(formula = df$Chance_of_Admit ~ df$GRE_Score + df$TOEFL_Score + 
#   df$LOR + df$CGPA + df$Research)

#Residuals:
#    Min       1Q   Median       3Q      Max 
#-0.16426 -0.02475  0.00306  0.02879  0.11190 

#Coefficients:
#                  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)     -1.3408903  0.0772981 -17.347  < 2e-16 ***
#df$GRE_Score    0.0020891  0.0003890   5.371 1.24e-07 ***
#df$TOEFL_Score  0.0027725  0.0006552   4.231 2.80e-05 ***
#df$LOR          0.0176933  0.0029215   6.056 2.88e-09 ***
#df$CGPA         0.1208630  0.0071631  16.873  < 2e-16 ***
#df$Research     0.0239942  0.0051726   4.639 4.57e-06 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.04502 on 464 degrees of freedom
#Multiple R-squared:  0.8888,	Adjusted R-squared:  0.8876 
#F-statistic: 741.4 on 5 and 464 DF,  p-value: < 2.2e-16

y1 = predict(modml,df)
png('/home/shaury/Desktop/pvsc/data.sci/DATA-ANALYTICS/chance\ of\ admission/rstd.png');
print(plot(y1,rstandard(modml)))
dev.off();
