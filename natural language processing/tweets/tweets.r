#tweets analysis


library(e1071)
library(class)
library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(SnowballC)
library(syuzhet)
library(RColorBrewer)

setup_twitter_oauth('xxxxx','zzzzz', access_token = 'xxxx', access_secret = 'zzzz');






covid.tweets <- searchTwitter('covid',n=1000,lang=NULL, since = '2021-06-24', until = '2021-06-25')
covid.text <- sapply(covid.tweets,function(x) x$getText());
covid.text<- iconv(covid.text,'UTF-8','ASCII');
covid.corpus<- Corpus(VectorSource(covid.text));

term.doc.matrix = TermDocumentMatrix(covid.corpus,control=list(removePunctuation = TRUE,tolower=TRUE,stopwords= c('lockdown',stopwords('english'),'covid','covid19','virus','ocgn','variants','variantes','vaccine'),removeNumbers=TRUE));
findAssocs(term.doc.matrix, terms = c("deaths","variant","delta"), corlimit = 0.25)
head(term.doc.matrix)
term.doc.matrix<- as.matrix(term.doc.matrix)
dm<- sort(rowSums(term.doc.matrix),decreasing = TRUE);
rownames(dm)<-NULL;
dm<-data.frame(word = names(dm),freq=dm)

library(tidyverse)
ggplot(dm[1:10,],aes(x=word,y=freq))+geom_histogram(stat = 'identity',aes(fill=factor(word)))

set.seed(1234)
wordcloud(words = dm$word, freq = dm$freq, min.freq = 3,
          max.words=10, random.order=FALSE, rot.per=0.40, 
          colors=brewer.pal(8, "Dark2"))


#sentiment analysis
#syuzhet
syuzhet_vector <- get_sentiment(covid.text, method="syuzhet")
head(syuzhet_vector)
summary(syuzhet_vector)
# bing
bing_vector <- get_sentiment(covid.text, method="bing")
head(bing_vector)
summary(bing_vector)
#affin
afinn_vector <- get_sentiment(covid.text, method="afinn")
head(afinn_vector)
summary(afinn_vector)

rbind(
  sign(head(syuzhet_vector)),
  sign(head(bing_vector)),
  sign(head(afinn_vector))
)

#emotions analysis
d<- get_nrc_sentiment(covid.text)
tail(d,10)

td<-data.frame(t(d))
td_new <- data.frame(rowSums(td[2:253]))
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]
ggplot(td_new2,aes(x=sentiment,y=count))+geom_histogram(stat='identity',aes(fill=sentiment),position = 'dodge')




