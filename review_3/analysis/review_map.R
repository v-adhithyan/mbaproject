library(tm)
library(SnowballC)
library(RColorBrewer)
library(dplyr)

data <- read.csv("reviews/sbtreviews.csv", stringsAsFactors = FALSE)


docs <- Corpus(VectorSource(data$reviews))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("bank", "account", "banking", "state", "service", "will", "branch", "customer", "one", "sbt", "kerela")) 
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

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=TRUE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))