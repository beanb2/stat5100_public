# Extract the utah snow load study dataset
library(snowload)
library(tidyverse)

data(ut2017)

# Subset the data to only include Utah locations.
utsub <- ut2017[ut2017$STATE == "UT", ]

# Cluster stations that are nearly identical to 
# reduce the effect of influential points. 
tdist2 <- fields::rdist.earth(utsub[, c("LONGITUDE", "LATITUDE")], miles = FALSE)
telev <- abs(outer(utsub$ELEVATION, utsub$ELEVATION, "-"))

# Distance of 4km produces a score of 1, difference
# of 50m produces a score of 1. 
dist.clust <- stats::as.dist((tdist/4) + (telev/50))

tclust <- hclust(dist.clust, method = "complete")
cu.id <- cutree(tclust, h = 2)

utsub$id <- cu.id

# Create new clustered dataset taking the median of all 
# measures. 
utsub2 <- utsub %>%
  dplyr::group_by(id) %>%
  dplyr::summarise(longitude = round(mean(LONGITUDE), 3),
                   latitude = round(mean(LATITUDE), 3), 
                   elevation = round(mean(ELEVATION)),
                   snowload = round(mean(yr50), 3))

set.seed(123)
# Randomly replace one of the rows with an outlier value of 100 (definite outlier)
nn <- sample(1:nrow(utsub2), 1)
utsub2$snowload[nn] <- 100

temp <- lm(snowload~elevation, data = utsub2)

write.csv(utsub2, file = "snowloads.csv", row.names = FALSE)
