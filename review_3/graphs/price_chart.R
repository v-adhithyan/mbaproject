require(ggplot2)
files = c("data/sbt.csv", "data/sbi.csv", "data/sbbj.csv", "data/sbm.csv")
for (f in files) {
  data <- read.csv(f)
  min <- min(data$Close.Price)
  max <- max(data$Close.Price)
  
  bank_name <- as.character(strsplit(f, ".csv"))
  save_png <- paste("plots/", bank_name, ".png")
  d <- as.Date(data$Date)
  xrange <- as.Date(c(d[1], d[length(d)]))
  png(filename=save_png)
  plot(data$Close.Price ~ d, type="l", col="blue", ylim=c(min, max),
       xlab = "Date", ylab = "INR", xlim=xrange)
  title(main = paste(bank_name, "share price"), col.main="red", font.main=4)
  dev.off()
}

