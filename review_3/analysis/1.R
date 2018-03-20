library(semPLS)
data("ECSImobi")

pcv <- read.csv("pcv.csv")
loyalty <- read.csv("loyalty.csv")
sp <- read.csv("sp.csv")
cs <- read.csv("cs.csv")

cor(pcv, cs)