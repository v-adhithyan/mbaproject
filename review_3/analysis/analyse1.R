library(tidyverse)

df <- read.csv("out.csv")
glimpse(df)

prop.table(table(df$gender))
library(gmodels)
CrossTable(df$age,df$gender,prop.r=FALSE,prop.t=FALSE,prop.chisq=FALSE,format="SPSS")


ggplot(df,aes(x=age))+
  geom_bar()+
  facet_grid(~gender)

ggsave("plots/age_distribution.png")