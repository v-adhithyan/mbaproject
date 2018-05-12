library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
library(dplyr)

data <- read.csv("df.csv", stringsAsFactors = FALSE)


docs <- Corpus(VectorSource(data$x))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, 
               c("bank", "account", "banking", "state", "<ef>", "<bf>", "<bd>",
                 "service", "will", "branch", "customer", 
                 "one", "sbt", "kerela",
                 "fast", "thanks", "without", 
                 "information", "facility", "make", "members", 
                 "hello", "give",
                 "gives", "gave", "call", "asked", "called",
                 "getting", "giving", "jaipur", "travancore", 
                 "can", "patiala",
                 "also", "banks", "card", "merger", "facebookpageposts", "hai",
                 "said", "sir", "sbi", "comments", "facebookpostcomments", "facebookpost", "may", "now")) 
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

png("madu_wordcloud_reviews.png", width=500,height=500)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()
png("madu_freq_words.png", width=500,height=500)
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")
dev.off()