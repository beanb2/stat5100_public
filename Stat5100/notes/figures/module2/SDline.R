# Adapted From:
# - https://blog.revolutionanalytics.com/2016/08/simulating-form-the-bivariate-normal-distribution-in-r-1.html

N <- 200 # Number of random samples
set.seed(123)
# Target parameters for univariate normal distributions
rho <- 0.6
mu1 <- 1; s1 <- 2
mu2 <- 1; s2 <- 8

# Parameters for bivariate normal distribution
mu <- c(mu1,mu2) # Mean
sigma <- matrix(c(s1^2, s1*s2*rho, s1*s2*rho, s2^2),
                2) # Covariance matrix

library(MASS)
bvn1 <- mvrnorm(N, mu = mu, Sigma = sigma) # from MASS package

tdf <- data.frame(x = bvn1[,1], y = bvn1[,2])

p <- cor(tdf$x, tdf$y)
sdx <- sd(tdf$x)
sdy <- sd(tdf$y)
mx <- mean(tdf$x)
my <- mean(tdf$y)

intx <- -p*(sdy/sdx)*mx + my
inty <- -p*(sdx/sdy)*my + mx
intsd <- -(sdy/sdx)*mx + my


library(tidyverse)

pdf(file = "sdline.pdf", width = 7, height = 5)
ggplot(data = tdf) + 
  geom_point(aes(x = x, y =y), pch = 1) + 
  geom_abline(slope = p*(sdy/sdx), intercept = intx, col = "red", lwd = 1) +
  geom_abline(slope = 1/(p*(sdx/sdy)), intercept = -inty/(p*(sdx/sdy)), 
              col = "blue", lwd = 1) +
  geom_abline(slope = (sdy/sdx), intercept = intsd, lty = 2, lwd = 1) +
  theme_bw() + 
  theme(text = element_text(size = 16))
dev.off()
