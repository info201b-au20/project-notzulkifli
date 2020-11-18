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

boxplot(total_counties$count, ylab = "5 number summary of Hospitals in counties", horizontal = TRUE, axes = FALSE, staplewex = 1)
text(x=fivenum(total_counties$count), labels =fivenum(total_counties$count), y=1.25)

