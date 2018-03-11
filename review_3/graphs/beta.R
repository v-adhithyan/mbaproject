beta <- read.csv("data/beta.csv")
beta_plot <- function () {
  g <- ggplot(beta, aes(x, group=1, colour=c(sbm, sbt, sbi, sbbj)))
  g <- g + geom_line(aes(y=sbm), color="red")
  g <- g + geom_line(aes(y=sbt), color="blue")
  g <- g + geom_line(aes(y=sbi), color="green")
  g <- g + geom_line(aes(y=sbbj), color="black")
  g <- g + labs(y = "Beta", x = "Event", title = "Volatilty of stock prices of SBI and it's associates before and after merger")
  g <- g + scale_fill_manual(values=c("red", "blue", "green", "black"), 
                    name="Legend",
                    breaks=c("sbm", "sbt", "sbi", "sbbj"),
                    labels=c("sbm", "sbt", "sbi", "sbbj"))
  g
}

beta_plot_1 <- function () {
  beta <- read.csv("data/beta1.csv")
  g <- ggplot(beta, aes(bank, group=1, colour=bank))
  g <- g + geom_line(aes(y=before_news))
  g <- g + geom_line(aes(y=on_the_day))
  g <- g + geom_line(aes(y=till_merger))
  g
}
beta_plot_1()