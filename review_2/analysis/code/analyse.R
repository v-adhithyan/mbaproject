library('survey')
library('dplyr')
library("psych")
library('plyr')

options(warn = -1)
data = read.csv("data.csv")

head(data)

# Psychological contract breach age - personal care
# Customer satisfaction - time to before merger
# Loyalty - recommend to switc

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
satisfied <- table(data$satisfied)
expectation <- table(data$expectation)
before_merger <- table(data$before_merger)



recommend <- table(data$recommend)
avail_service <- table(data$avail_service)
open_again <- table(data$open_again)
another_branch <- table(data$another_branch)


loyalty<- select(data, recommend, avail_service, open_again, another_branch, negative)
                  #negative, another_branch)
pcv_reliablity <- alpha(pcv, -1, -1, 1, 1, -1, 1, 1, 1)
sp_reliablity <- alpha(service_performance)
#cs_reliablity <- alpha(customer_satisfaction)
loyalty_reliablity <- alpha(loyalty, 1, 1, 1, 1, -1, check.keys = TRUE)