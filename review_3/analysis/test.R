
pcv <- read.csv("pcv.csv")
cs <- read.csv("cs.csv")
sp <- read.csv("sp.csv")
loyalty <- read.csv("loyalty.csv")


chisq.test(pcv, cs)
chisq.test(cs, loyalty)

lm(pcv~cs)