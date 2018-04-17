library(plotrix)
data <- read.csv("age.csv")
agebreaks <- c(0,1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,500)
agelabels <- c("0-1","1-4","5-9","10-14","15-19","20-24","25-29","30-34",
               "35-39","40-44","45-49","50-54","55-59","60-64","65-69",
               "70-74","75-79","80-84","85+")

data$age_grouping <- cut(data$Age, breaks = agebreaks, labels = agelabels)
library(plyr)
c <- count(data, "age_grouping")
female <- data[data$Gender == 'Female',]
male <- data[data$Gender == 'Male',]

male$age_grouping <- cut(male$Age, breaks = agebreaks, labels = agelabels)
female$age_grouping <- cut(female$Age, breaks = agebreaks, labels = agelabels)
#write.csv(file="male.csv", male)
#write.csv(file="female.csv", female)
class(c)
male_count <- count(male, "age_grouping")
female_count <- count(female, "age_grouping")

xy.pop<-c(11, 28, 19, 8, 8, 2, 0,  3, 0,  1, 1, 2, 1)
xx.pop<-c(4, 6, 3, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0)
agelabels<-c("20-24","25-29","30-34",
             "35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74",
             "75-79","80-84")
mcol<-color.gradient(c(0,0,0.5,1),c(0,0,0.5,1),c(1,1,0.5,1),18)
fcol<-color.gradient(c(1,1,0.5,1),c(0.5,0.5,0.5,1),c(0.5,0.5,0.5,1),18)
par(mar=pyramid.plot(xy.pop,xx.pop,labels=agelabels,
                     main="Age distribution",lxcol=mcol,rxcol=fcol, space = 0.5, gap = 3,
                    show.values=TRUE))

