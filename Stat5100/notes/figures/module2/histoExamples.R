set.seed(123)

pdf("distTable.pdf", width = 12, height = 20)
par(mfrow = c(5, 3))
plot.new()
text(x = 0.5, y = 0.5, "Normal", cex = 2)
x <- rnorm(200)
qqnorm(x, main = "Normal Prob. Plot")
qqline(x)
hist(x, xlim = c(-4, 4), ylim = c(0, 80), main = "Histogram")

plot.new()
text(x = 0.5, y = 0.5, "Short Tail", cex = 2)
y <- runif(200, min = -2, max = 2)
qqnorm(y)
qqline(y)
hist(y, xlim = c(-4, 4), ylim = c(0, 80), main = "")

plot.new()
text(x = 0.5, y = 0.5, "Long Tail", cex = 2)
z <- rt(200, df=4)
qqnorm(z, main = "")
qqline(z)
hist(z, xlim = c(-4, 4), ylim = c(0, 80), main = "", breaks = 30)

plot.new()
text(x = 0.5, y = 0.5, "Right Skew", cex = 2)
q = rgamma(200, shape = 1) - 3
qqnorm(q, main = "")
qqline(q)
hist(q, xlim = c(-4, 4), ylim = c(0, 80), main = "")

plot.new()
text(x = 0.5, y = 0.5, "Left Skew", cex = 2)
r = -rgamma(200, shape = 1) + 3
qqnorm(r, main = "")
qqline(r)
hist(r, xlim = c(-4, 4), ylim = c(0, 80), main = "")

dev.off()






pdf("dist_question_short.pdf", width = 5, height = 5)
y <- runif(200, min = -2, max = 2)
qqnorm(y, main = "")
qqline(y)
dev.off()

pdf("dist_question_long.pdf", width = 5, height = 5)
z <- rt(200, df=4)
qqnorm(z, main = "")
qqline(z)
dev.off()







