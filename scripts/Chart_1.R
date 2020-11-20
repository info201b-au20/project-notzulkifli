library(stringr)
library(lintr)
Hospitals <- read.csv("Hospitals.csv")
View(Hospitals)
install.packages("dplyr") 
library(dplyr)

test <- select(Hospitals, COUNTY)

total_counties <- Hospitals %>%
  filter(STATE == "WA") %>% 
  group_by(COUNTY) %>% 
  summarise(count = n())

boxplot(total_counties$count, xlab = "1 = first quartile/min, 2 = median, 4 = third quartile, 32 = max", ylab = "Statistics of Number of Hospitals in Counties", horizontal = TRUE, axes = FALSE, staplewex = 1)
text(x=fivenum(total_counties$count), labels =fivenum(total_counties$count), y=1.25)
