library(SentimentAnalysis)
data = read.csv("reviews1.csv")
reviews <- as.vector(data['reviews'])
sentiment  <- analyzeSentiment(reviews)
#s$SentimentQDAP
convertToDirection(sentiment$SentimentQDAP)
response <- as.vector(data$response)
compareToResponse(sentiment, response)
plotSentimentResponse(sentiment$SentimentQDAP, response)
