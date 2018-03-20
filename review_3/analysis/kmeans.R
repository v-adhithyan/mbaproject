library('semPLS')

data <- read.csv("cs-1.csv")
names <- names(data)
kcl5 <- kmeans(data, 4 , nstart=25)

cluster_profile <- t(kcl5$centers)
cluster_size <- kcl5$size

row_mean <- apply(cluster_profile, 1, mean)
col_mean <- apply(cluster_profile, 2, mean)

sorted_profile<-cluster_profile[order(row_mean),c(1,2,3,4)]

# reordered cluster sizes and profiles
cluster_size[c(1,2,3,4)]/101
round(sorted_profile,2)
png("unsatisfied.png")
matplot(sorted_profile[,-4], type = c("b"), pch="*", lwd=3,
        xlab="Satisfaction score ordered by average for total sample",
        ylab="Average Ratings for Each Cluster")
title("Not at all likely, Not very likely, Quite Likely")
dev.off()
png("satisfied.png")
matplot(sorted_profile[,4], type = c("b"), pch="*", lwd=3,
        xlab="Satisfaction score ordered by average for total sample",
        ylab="Average Ratings for Last Cluster")
title("People who are satisfied")
dev.off()