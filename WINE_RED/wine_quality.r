df = read.csv("/home/shaury/Downloads/nptel/winequality-red.csv")
View(df)
m3 = lm(df$quality~.,data=df)
summary(m3)


m4 = lm(df$quality~ df$volatile.acidity+df$chlorides+df$free.sulfur.dioxide+df$total.sulfur.dioxide+df$pH+df$sulphates+df$alcohol)
summary(m4)


y1 = predict(m4,data.frame(df$volatile.acidity+df$chlorides+df$free.sulfur.dioxide+df$total.sulfur.dioxide+df$pH+df$sulphates+df$alcohol))
plot(y1,rstandard(m4))
vec = identify=(y1,rstandard(m4))

#vec=c(8,9,46,63,93,152,162,282,365,391,410,441,456,460,482,496,518,577,589,639,646,648,653,691,704,724,814,829,831,833,834,873,877,900,938,943,944,1025,1091,1121,1125,1203,1234,1236,1240,1277,1300,1308,1375,1399,1404,1424,1430,1450,1467,1470,1479,1483,1506,1550)
df = df[-vec,]
View(df)
m5 = lm(df$quality~df$volatile.acidity+df$chlorides+df$free.sulfur.dioxide+df$total.sulfur.dioxide+df$pH+df$sulphates+df$alcohol)
summary(m5)




y1 = predict(m5,data.frame(df$volatile.acidity+df$chlorides+df$free.sulfur.dioxide+df$total.sulfur.dioxide+df$pH+df$sulphates+df$alcohol))
plot(y1,rstandard(m5))
 

