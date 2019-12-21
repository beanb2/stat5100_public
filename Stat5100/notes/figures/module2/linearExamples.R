set.seed(123)

pdf(file = "linPlots.pdf", width = 8, height = 8)
par(mfrow = c(3, 2))
x = rnorm(100)
y = x + 0.5*x^2 + rnorm(100, sd = 0.25)

tdf <- data.frame(x = x, y = y)
temp <- lm(y~x, data = tdf)

plot(x, y, main = "X vs Y")
plot(temp$fitted.values, temp$residuals, xlab = "Fitted", ylab = "Residuals",
     main = "Resid vs Pred")


x = rnorm(100)
y = x + 3*(x+abs(min(x)))*rnorm(100, sd = 0.1)

tdf <- data.frame(x = x, y = y)
temp <- lm(y~x, data = tdf)

plot(x, y)
plot(temp$fitted.values, temp$residuals, xlab = "Fitted", ylab = "Residuals")


x = rnorm(100)
y = 2*x + rnorm(100, sd = 0.5) 

tdf <- data.frame(x = x, y = y)
temp <- lm(y~x, data = tdf)

plot(x, y)
plot(temp$fitted.values, temp$residuals, xlab = "Fitted", ylab = "Residuals")

dev.off()



