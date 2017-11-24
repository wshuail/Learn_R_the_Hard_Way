
# part 1
model <- glm(formula = vs ~ wt + disp, data = mtcars, 
             family = binomial)
summary(model)

newdata <- data.frame(wt = 2.1, disp = 180)
predict(model, newdata, type = 'response')

# Part 2
library(ResourceSelection)
hoslem.test(mtcars$vs, fitted(model))

# part 3

model_weight <- glm(vs ~ wt, mtcars, family = binomial)
summary(model_weight)

range(mtcars$wt)

xweight <- seq(0, 6, 0.01)

yweight <- predict(model_weight, list(wt = xweight),
                   type = 'response')
plot(mtcars$wt, mtcars$vs, pch = 16, xlab = 'WEIGHT', ylab = 'VS')
lines(xweight, yweight)

# part 4


