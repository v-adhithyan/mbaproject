require(ggplot2)
data <- read.csv("data/price.csv")

cols <- c("SBM"="cyan","SBT"="blue","SBI"="green", "SBBJ" = "magenta")

g <- ggplot(data, aes(id))
g <- g + geom_line(aes(y=sbm, color="SBM"))
g <- g + geom_line(aes(y=sbt, color="SBT"))
g <- g + geom_line(aes(y=sbi, color="SBI"))
g <- g + geom_line(aes(y=sbbj, color="SBBJ"))
g <- g + scale_colour_manual(name="Legend",values=cols)
g <- g + ylab("Price in INR") + xlab("Days")+ theme(axis.ticks.x=element_blank())
g