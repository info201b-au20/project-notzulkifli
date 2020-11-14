library(tidyverse)
hospitals <- read.csv("Hospitals.csv")
county <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

#Toal unique number of ownerships of hospitals in WA
WA_owners <- hospitals %>%
    filter(STATE == "WA") %>%
    group_by(OWNER, COUNTY) %>%
    summarize(length(COUNTY))
WA_owners <- length(unique(WA_owners$OWNER))

#Mean number of hospitals in WA counties:
WA_hospitals <- hospitals %>%
    filter(STATE == "WA") %>%
    group_by(COUNTY) %>%
    summarize(length(COUNTY))
WA_hospitals <- WA_hospitals %>%
    mutate("County" = str_to_sentence(WA_hospitals$COUNTY, locale = "en"))
WA_hospitals_mean <- mean(WA_hospitals$`length(COUNTY)`)

#Median number of hospitals in WA counties:
WA_hospitals_median <- median(WA_hospitals$`length(COUNTY)`)

#Number of counties in WA with hospitals:
WA_counties_hospitals <- nrow(WA_hospitals)

#Total number of counties (including 1 "Unknown") in the state of WA:
total_counties <- county %>%
    filter(state == "Washington") %>% 
    group_by(county) %>% 
    summarise(count = n())
total_counties <- nrow(total_counties)

summary_info <- list(WA_owners, WA_hospitals_mean, WA_hospitals_median, WA_counties_hospitals, total_counties)
summary_info