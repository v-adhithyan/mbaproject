library(plyr)
library(RColorBrewer)
#library(wesanderson)
library(ggplot2)
#library(plotly)

data <- read.csv("reviews.csv")
stars = as.vector(data$star)
freq = count(data, "stars")
freq
df <- data.frame(
  ratings = c(1:5),
  frequencies = c(71, 31, 23, 38, 36)
)

png("ratings_distribution.png", width=300,height=350)
gg <- ggplot(data=df, aes(x=ratings, y=frequencies, fill=as.factor(ratings))) + geom_bar(stat="identity")
gg <- gg + scale_fill_brewer(palette = "Dark2") + guides(fill=FALSE)
gg
dev.off()