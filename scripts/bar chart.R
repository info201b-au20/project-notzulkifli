library(tidyverse)
hospitals <- read.csv("Hospitals.csv")
county <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

Washington <- county %>%
  filter(state == "Washington") %>%
  filter(date == max(date)) %>%
  group_by(county) %>%
  summarize(deaths) %>%
  ungroup()
Washington <- Washington %>% 
  mutate("County" = str_to_sentence(Washington$county, locale = "en"))
Washington$county <- NULL
View(Washington)

WA_hospitals <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(COUNTY) %>%
  summarize(length(COUNTY))
WA_hospitals <- WA_hospitals %>%
  mutate("County" = str_to_sentence(WA_hospitals$COUNTY, locale = "en"))
WA_hospitals$COUNTY <- NULL
View(WA_hospitals)

mean(WA_hospitals$`length(COUNTY)`)
median(WA_hospitals$`length(COUNTY)`)
nrow(WA_hospitals)

joined <- full_join(WA_hospitals, Washington, by = "County")
names(joined)[names(joined) == "length(COUNTY)"] <- "Number_of_Hospitals"
View(joined)

Hospitals_Deaths <- ggplot(data = joined) +
  geom_col(mapping = aes(x = Number_of_Hospitals, y = deaths, col = County)) +
  labs(x = "Hospitals", y = "Number of Deaths", title = "Hospitals vs Number of Deaths")
Hospitals_Deaths