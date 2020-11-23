library(tidyverse)
library(knitr)
library(tidyr)
hospitals <- read.csv("Hospitals.csv")
county <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

#Create a table with all the calculated information below:
WA_hospitals <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(COUNTY) %>%
  summarize("Number of hospitals" = length(COUNTY))

#Total number of beds per county
beds_per_county <- hospitals %>%
  group_by(COUNTY) %>% 
  filter(STATE == "WA") %>% 
  summarise("Number of beds" = max(BEDS))

#Table of Hospital Summary
hospital_summary <- hospitals %>%
  filter(STATE == "WA") %>%
  select(COUNTY, BEDS) %>% 
  group_by(COUNTY) %>% 
  summarize(total_beds = sum(BEDS)) %>%
  arrange(-total_beds) %>%
  top_n(10)

kable(hospital_summary)