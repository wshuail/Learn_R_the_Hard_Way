# apply

str(apply)
function(x, MARGIN, FUN, ...)
     
x <- matrix(rnorm(200), 20, 10)
dim(x)

apply(x, 1, mean)  # 1 means row
apply(x, 2, mean)  # 2 means column
apply(x, 3, mean)  # error

apply(x, 1, sum)
apply(x, 2, max)

# the arguments can be passed to FUN.
apply(x, 1, quantile, probs = c(0.25, 0.75))

# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)

x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
rowSums(x)
rowMeans(x)
colSums(x)
colMeans(x)

rowSums(x, dims = 2)  # error
rowMeans(x, dims = 2)  # error

y <- matrix(1:20, 4, 5)
y
rowSums(y)
rowMeans(y, dims = 2)  # error

options(digits = 2)
b <- array(rnorm(2 * 2 * 2), c(2, 2, 2))
b
rowMeans(b, dims = 2)

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))  # rnorm
dim(a)
a
apply(a, c(1, 2), mean)
rowMeans(a, dims = 2)









