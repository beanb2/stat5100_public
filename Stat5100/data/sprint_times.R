# For this script, please set the working directory to the source file location.
library(tidyverse)

run_times <- read.csv("sprint_times.csv")

run_times$gender <- as.character(run_times$gender)
run_times$gender[run_times$gender == "f"] <- "Female"
run_times$gender[run_times$gender == "m"] <- "Male"

lm1 <- lm(time ~ year, data = run_times[run_times$gender == "Female", ])
lm2 <- lm(time ~ year, data = run_times[run_times$gender == "Male", ])

lm1.1 <- lm(time ~ year, data = run_times[run_times$gender == "Female" &
                                            run_times$year < 2005, ])
lm2.1 <- lm(time ~ year, data = run_times[run_times$gender == "Male" &
                                            run_times$year < 2005, ])
pdf("run_times.pdf")
ggplot(run_times, aes(x = year, y = time, color = factor(gender))) +
  geom_point() +
  scale_x_continuous(limits = c(1900, 2252)) +
  scale_y_continuous(limits = c(6, 13)) +
  scale_color_manual(name = "Sex", values = c("red", "blue")) +
  geom_abline(intercept = lm1$coefficients[1], slope = lm1$coefficients[2],
              col = "red") +
  geom_abline(intercept = lm2$coefficients[1], slope = lm2$coefficients[2],
              col = "blue") +
  geom_abline(intercept = lm1.1$coefficients[1], slope = lm1.1$coefficients[2],
              lty = 2, col = "red") +
  geom_abline(intercept = lm2.1$coefficients[1], slope = lm2.1$coefficients[2],
              lty = 2, col = "blue") +
  theme_bw() +
  labs(x = "Year", y = "Run Time") +
  theme(legend.position = c(1, 1),
        legend.justification = c(1, 1),
        legend.background = element_blank(),
        text = element_text(size = 16))
dev.off()
