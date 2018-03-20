library('semPLS')

data <- read.csv("loyalty-1.csv")
names <- names(data)
kcl5 <- kmeans(data, 5 )

cluster_profile <- t(kcl5$centers)
cluster_size <- kcl5$size

row_mean <- apply(cluster_profile, 1, mean)
col_mean <- apply(cluster_profile, 2, mean)

sorted_profile<-cluster_profile[order(row_mean),c(4,3,1,2,5)]

# reordered cluster sizes and profiles
cluster_size[c(4,3,1,2,5)]/101
round(sorted_profile,2)
png("loyalty.png")
matplot(sorted_profile[,-5], type = c("b"), pch="*", lwd=3,
        xlab="Loyalty score ordered by average for total sample",
        ylab="Average Ratings for Each Cluster")
title("Not at all likely, Not very likely, Quite Likely")
dev.off()
png("not-loyalty.png")
matplot(sorted_profile[,5], type = c("b"), pch="*", lwd=3,
        xlab="Loyalty score ordered by average for total sample",
        ylab="Average Ratings for Last Cluster")
title("People who will defintely switch")
dev.off()