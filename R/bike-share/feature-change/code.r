library(tidyverse)
#feature engineering;
train<- separate(train,datetime,c('date','time'),sep=" ") %>% separate(train,time,c('hour'),sep=":");

train$hour<- as.numeric(train$hour);

test<- separate(test,datetime,c('date','time'),sep=" ") %>% separate(test,time,c('hour'),sep=":");

test$hour<- as.numeric(test$hour);

