# Chapter 10
# Lib 1: Principal Components Analysis

# load the data
head(USArrests)
usarrests <- USArrests
# the have large means
# 1 mean row and 2 means column
apply(usarrests, 2, mean)
apply(usarrests, 2, var)

# scale the data
usarrests_scale <- prcomp(usarrests, scale = T)
names(usarrests_scale)

# see the mean and sd
usarrests_scale$center
usarrests_scale$scale

# see the pca loading
usarrests_scale$rotation

dim(usarrests_scale$x)
biplot(usarrests_scale, scale = 0)

usarrests_scale$rotation <- -usarrests_scale$rotation
usarrests_scale$x <- -usarrests_scale$x
biplot(usarrests_scale, scale = 0)

# the sd of each variable
usarrests_scale$sdev
var <- usarrests_scale$sdev^2
var

# the variable explained
pve <- var/sum(var)
pve

plot(pve, type = 'b')
plot(cumsum(pve), type = 'b')

# 10.5 Lab 2: Clusting
# 10.5.1 K-Means Clusting

# kmeans function
set.seed(2)
x <- matrix(rnorm(50*2), ncol = 2)
x[1:25, 1] = x[1:25, 1] + 3
x[1:25, 2] = x[1:25, 2] - 4
x

# perform K-Means with K=2
km <- kmeans(x, 2, nstart = 20)
km
km$cluster
plot(x, col = (km$cluster + 1), main = 'K-Means Clustering',
     pch = 20, cex = 2)

# K = 3
set.seed(6)
km_k3 <- kmeans(x, 3, nstart = 20)
plot(x, col = (km_k3$cluster + 1), pch = 20, cex = 1.5)

# nstart was used to set the initial clusters
set.seed(7)
km_2 <- kmeans(x, 3, nstart = 1)
km_2$tot.withinss

km_3 <- kmeans(x, 3, nstart = 50)
km_3$tot.withinss
# a larger nstart is better

# 10.5.2 Hierachical clustering
# hclust() function
# dist function to compute the Euclidean distance

x
hclust_complete <- hclust(dist(x), method = 'complete')
hclust_average <- hclust(dist(x), method = 'average')
hclust_single <- hclust(dist(x), method = 'single')

# plot the result
par(mfrow = c(1, 3))
plot(hclust_complete)
plot(hclust_average)
plot(hclust_single)

# determine a cluster labels
cutree(hclust_complete, 2)
cutree(hclust_average, 2)
cutree(hclust_single, 2)

# scale the data
x_scale <- scale(x)
hclust_complete_scale <- hclust(dist(x_scale))
plot(hclust_complete_scale)

# correlation-based distance
x <- matrix(rnorm(30*3), ncol = 3)
dd <- as.dist(1 - cor(t(x)))
hclust_dd <- hclust(dd)
plot(hclust_dd)


# 10.6 Lab 3 NCI60 data example

# load the data
library(ISLR)
head(NCI60)
class(NCI60)
names(NCI60)

nci_data <- NCI60$data
nci_labs <- NCI60$labs
class(nci_data)
class(nci_labs)
length(nci_labs)

# examine the cancer type
nci_labs[1: 4]
table(nci_labs)

# 10.6.1 PCA method
head(nci_data)
nci_data_scale <- prcomp(nci_data, scale = T)
nci_data_scale$x

# plot the result
Cols <- function(vec){
        cols <- rainbow(length(unique(vec)))
        return (cols(as.numeric(as.factor(vec))))
}

par(mfrow = c(1, 2))
plot(nci_data_scale$x[, 1:2], pch = 19, col = Cols(nci_labs))

summary(nci_data_scale)
plot(nci_data_scale)

# plot the PVE
pve <- 100*nci_data_scale$sdev^2/sum(nci_data_scale$sdev^2)
par(mfrow = c(1, 2))
plot(pve, type = 'o', col = 'blue')
plot(cumsum(pve), type = 'o', col = 'blue')

summary(nci_data_scale)$importance[2, ]
summary(nci_data_scale)$importance[3, ]

# Clusting the observations of the NCI60 data
nci_scale <- scale(nci_data)
nci_distance <- dist(nci_scale)
par(mfrow = c(1, 3))
plot(hclust(nci_distance), labels = nci_labs)
plot(hclust(nci_distance, method = 'average'), labels = nci_labs)
plot(hclust(nci_distance, method = 'single'), labels = nci_labs)

# the complete method is better
hc <- hclust(dist(nci_scale))
hc
hc_cluster <- cutree(hc, 4)
hc_cluster
table(hc_cluster, nci_labs)

plot(hc, labels = nci_labs)
abline(h = 139, col = 'red')

# compare with the k-mean cluster
set.seed(9)
km <- kmeans(nci_scale, 4, nstart = 20)
km_cluster <- km$cluster
table(km_cluster, hc_cluster)

# perform on the first few components
hc_few <- hclust(dist(nci_data_scale$x[, 1:5]))
plot(hc_few, labels = nci_labs)
table(cutree(hc_few, 4), nci_labs)




