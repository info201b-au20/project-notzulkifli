library(tidyverse)
hospitals <- read.csv("Hospitals.csv")
county <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

#Create a table with all the calculated information below:
hospital_summary <- hospitals %>% 
  filter(STATE == "WA") %>% 
  group_by(COUNTY) %>% 
  summarize(
    Total_Unique_Owners = length(unique(WA_owners$OWNER)),
    WA_hospitals_mean = mean(WA_hospitals$`Number of hospitals`),
    WA_hospitals_median = median(WA_hospitals$`Number of hospitals`),
    WA_Counties = nrow(WA_hospitals),
    Highest_number_hospital = max(WA_hospitals$`Number of hospitals`)
  )

colnames(hospital_summary)

#Total unique number of ownerships of hospitals in WA
WA_owners <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(OWNER, COUNTY) %>%
  summarize("Number of hospitals" = length(COUNTY))

length(unique(WA_owners$OWNER))

#Mean number of hospitals in WA counties:
WA_hospitals <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(COUNTY) %>%
  summarize("Number of hospitals" = length(COUNTY))

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

