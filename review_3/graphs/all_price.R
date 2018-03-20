require(ggplot2)
data <- read.csv("data/price.csv")

g <- ggplot(data, aes(id))
g <- g + geom_line(aes(y=sbm), color="red")
g <- g + geom_line(aes(y=sbt), color="blue")
g <- g + geom_line(aes(y=sbi), color="green")
g <- g + geom_line(aes(y=sbbj), color="magenta")
g <- g + scale_color_discrete(breaks=c("sbm", "sbt", "sbi", "sbbj"),
                            values=c("red", "blue", "green", "magenta"))