library(tidyverse)
hospitals <- read.csv("Hospitals.csv")
county <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

#Toal unique number of ownerships of hospitals in WA
WA_owners <- hospitals %>%
    filter(STATE == "WA") %>%
    group_by(OWNER, COUNTY) %>%
    summarize(length(COUNTY))
length(unique(WA_owners$OWNER))

#Mean number of hospitals in WA counties:
WA_hospitals <- hospitals %>%
    filter(STATE == "WA") %>%
    group_by(COUNTY) %>%
    summarize(length(COUNTY))
WA_hospitals <- WA_hospitals %>%
    mutate("County" = str_to_sentence(WA_hospitals$COUNTY, locale = "en"))
mean(WA_hospitals$`length(COUNTY)`)

#Median number of hospitals in WA counties:
median(WA_hospitals$`length(COUNTY)`)

#Number of counties in WA with hospitals:
nrow(WA_hospitals)

#Total number of counties (including 1 "Unknown") in the state of WA:
total_counties <- county %>%
    filter(state == "Washington") %>% 
    group_by(county) %>% 
    summarise(count = n())
nrow(total_counties)