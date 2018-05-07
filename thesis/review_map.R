library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
library(dplyr)

data <- read.csv("reviews.csv", stringsAsFactors = FALSE)


docs <- Corpus(VectorSource(data$reviews))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, 
               c("bank", "account", "banking", "state", 
                 "service", "will", "branch", "customer", 
                 "one", "sbt", "kerela",
                 "fast", "thanks", "without", 
                 "information", "facility", "make", "members", 
                 "hello", "give",
                 "gives", "gave", "call", "asked", "called",
                 "getting", "giving", "jaipur", "travancore", 
                 "can", "patiala",
                 "also", "banks", "card")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

png("wordcloud_reviews.png", width=300,height=350)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")