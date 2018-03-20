#library(sem)
library(lavaan)

data <- read.csv("out.csv")
model <- readLines("mode.lav")
fit <- sem(model, data=data)
summary <- summary(fit, standardized=TRUE)
