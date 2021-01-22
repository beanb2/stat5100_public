# When you read in the file, make sure that the CSV file is placed in the
# same directory as your current working directory. To find out where your
# current working directory is, use getwd()
snow <- read.csv(file = "snowloads.csv")

# Initial regression model
snow_lm <- lm(snowload ~ elevation, data = snow)
