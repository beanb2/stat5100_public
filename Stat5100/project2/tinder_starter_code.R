library(stat5100)

# Read in the data
tinder <- read.csv("C:/Users/Brennan/Downloads/tinder.csv")

# SAS handles missing values differently than R does. This code 
# makes adjustments to make the csv file more "R friendly". 
# This chunk of code converts all variables (except ID) to numeric. 
# Ignore the warnings associated with this code. 
for(i in 2:ncol(tinder)){
  tinder[, i] <- as.numeric(tinder[, i])
}

# Convert the categorical variables to factors. 
tinder$Orientation <- as.factor(tinder$Orientation)
tinder$Gender <- as.factor(tinder$Gender)
tinder$Education <- as.factor(tinder$Education)
tinder$Income <- as.factor(tinder$Income)
tinder$Employment <- as.factor(tinder$Employment)

# Check hard upper bound on genuine. 
hist(tinder$Genuine)
summary(tinder$Genuine)

# Add new ID variable that names observations based on order in the csv file.
tinder$ID2 <- 1:nrow(tinder)

# Sequence plot of genuine scores. 
plot(tinder$ID2, tinder$Genuine, type = "l")

# Split the data into training (approx 80%) and test (approx 20%) sets. 
set.seed(123)
tinder$select <- sample(0:1, prob = c(0.8, 0.2),
                        size = nrow(tinder), replace = TRUE)

train <- tinder[tinder$select == 0, ]
test <- tinder[tinder$select == 1, ]

# Look at initial model. R will automatically create dummy variables for 
# factor variables. 
lm_full <- lm(Genuine ~ SocPrivConc + InstPrivConc + Narcissism + SelfEsteem + 
                Loneliness + Hookup + Friends + Partner + Travel + 
                SelfValidation + Entertainment + Orientation + Gender + 
                Education + Income + Employment +
                Age + ImpFitness + ImpEnergy + ImpAttractive, 
              data = train)

# Obtain test set error: 
test$pred <- predict(lm_full, newdata = test)
test$ERROR <- test$Genuine - test$pred

# Na.rm = true handles observations with missing values. 
mean(test$ERROR^2, na.rm = TRUE)
