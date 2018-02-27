library('survey')
library('dplyr')
library("psych")
library('plyr')
library('e1071')

options(warn = -1)
data = read.csv("out.csv")

data$service=revalue(data$service, c("Pathetic" = 1, "Poor" = 2, "Same" = 3, "Good" = 4, "Excellent" = 5))
data$satisfaction = revalue(data$satisfaction, c("Very dissatisfied" = 1, "Dissatisfied" = 2,
                                                "Neutral" = 3,
                                                "Very Satisfied" = 5, "Satisfied" = 4))
data$expectation = revalue(data$expectation, c("Much worse" = 1, "Worse" = 2,
                                                 "Neutral" = 3,
                                                 "Equal to expectation" = 4, "Better than expectation" = 5))
data$before_merger = revalue(data$before_merger, c("Very far from ideal" = 1, 
                                                   "Far from ideal" = 2,
                                                   "Neutral" = 3,
                                                   "Close to ideal" = 4, "Ideal" = 5))
# Psychological contract breach
# Customer satisfaction - time to before merger
# Loyalty - recommend to switc

write.csv(file="out.csv", data)
data = read.csv(file="out.csv")

age <- table(data$age)
gender <- table(data$gender)
account <- table(data$account)
year <- table(data$year)
location <- table(data$location)

happy <- table(data$happy)
pleased <- table(data$pleased)
disappointed <- table(data$disappointed)
violated <- table(data$violated)
grateful <- table(data$grateful)
info <- table(data$info)
commute <- table(data$commute)
id <- table(data$id)

pcv <- select(data, happy, pleased, disappointed,
              violated, grateful, info,
              commute, id)

time <- table(data$time)
effort <- table(data$effort)
consistency <- table(data$consistency)
willing <- table(data$willing)
approachable <- table(data$approachable)
courteous <- table(data$courteous)
listen <- table(data$listen)
honest <- table(data$honest)
effort <- table(data$effort)
neat <- table(data$neat)
needs <- table(data$needs)


service_performance <- select(data, time, effort, 
                              willing, approachable, courteous, 
                              listen, honest, effort,
                              neat, needs)

service <- table(data$service)
satisfaction <- table(data$satisfaction)
expectation <- table(data$expectation)
before_merger <- table(data$before_merger)


customer_satisfaction <- select(data, service, satisfaction, expectation, before_merger)

recommend <- table(data$recommend)
avail_service <- table(data$avail_service)
open_again <- table(data$open_again)
another_branch <- table(data$another_branch)


loyalty<- select(data, recommend, avail_service, open_again, another_branch, negative)
#negative, another_branch)
pcv_reliablity <- alpha(pcv, -1, -1, 1, 1, -1, 1, 1, 1)
sp_reliablity <- alpha(service_performance)
cs_reliablity <- alpha(customer_satisfaction)
loyalty_reliablity <- alpha(loyalty, 1, 1, 1, 1, -1, check.keys = TRUE)

pcv_reliablity
sp_reliablity
cs_reliablity
loyalty_reliablity

cor(pcv, customer_satisfaction, method="pearson")

uncs <- as.numeric(unlist(customer_satisfaction))
unlo <- as.numeric(unlist(loyalty))
#scatter.smooth(as.numeric(unlist(customer_satisfaction)), as.numeric(unlist(loyalty)))
#plot(density(uncs), main="Customer satisfaction", ylab="Frequency", round(e1071::skewness(uncs), 2))
plot(density(unlo), main="Loyalty", ylab="Frequency", round(e1071::skewness(unlo), 2))

unpcv <- as.numeric(unlist(pcv))
plot(density(unpcv), main="PCV", ylab="Frequency", round(e1071::skewness(unpcv), 2))


unsp <- as.numeric(unlist(service_performance))
plot(density(unsp), main="Service perf", ylab="Frequency", round(e1071::skewness(unsp), 2))

regress.cs.loyalty <- lm(uncs~unlo, data=data)
