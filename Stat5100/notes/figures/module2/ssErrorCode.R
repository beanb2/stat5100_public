library(ggplot2)

set.seed(123)
x <- rnorm(50)
y <- 2*x + rnorm(50, sd = 0.7) 

tdf <- data.frame(x = x, y = y)
test <- lm(y~x, data = tdf)

p1 <- ggplot(data = tdf) +
  geom_point(aes(x = x, y = y)) + 
  geom_abline(slope = 0, intercept = mean(y), lty = 2, lwd = 1, col = "gray40") + 
  geom_segment(aes(x = x, y = y, xend = x, yend = mean(tdf$y)),
               col = "blue") + 
  ggtitle("SS Total") + 
  theme_bw() + 
  theme(text = element_text(size = 16),
        plot.title = element_text(hjust = 0.5))


p2 <- ggplot(data = tdf) +
  geom_point(aes(x = x, y = y)) + 
  geom_abline(slope = test$coefficients[2], 
              intercept = test$coefficients[1], lty = 2, lwd = 1, col = "gray40") + 
  geom_segment(aes(x = x, y = y, xend = x, 
                   yend = test$coefficients[1] + test$coefficients[2]*x),
               col = "blue") + 
  ggtitle("SS Error") + 
  theme_bw() + 
  theme(text = element_text(size = 16),
        plot.title = element_text(hjust = 0.5))

pdf(file = "ssError.pdf", width = 14)
gridExtra::grid.arrange(p1, p2, nrow = 1)
dev.off()
