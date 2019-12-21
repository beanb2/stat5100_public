set.seed(123)

x = rnorm(100)
y = x + 3*(x+abs(min(x)))*rnorm(100, sd = 0.1)

tdf <- data.frame(x = x, y = y)
temp <- lm(y~x, data = tdf)

pdf(file = "BFtest.pdf", width = 10, height = 8)
plot(temp$fitted.values, temp$residuals, xlab = "Fitted", ylab = "Residuals", pch = 16)
abline(v = median(temp$residuals), lty = 2, lwd = 2, col = "red")
dev.off()
