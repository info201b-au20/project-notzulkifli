# server.R
# Load in libraries
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)

# Load in the data
RaceData <- read.csv("scripts/Data.csv", stringsAsFactors = FALSE)
hospitals <- read.csv("scripts/Hospitals.csv")
washington_history <- read.csv("https://covidtracking.com/data/download/washington-history.csv")

# Rishi's Work:

# Variables
# Number of total cases in WA state
total_cases <- RaceData %>%
  filter(!is.na(Cases_Total)) %>%
  filter((State == "WA")) %>%
  filter((Date == "20201202")) %>%
  summarise(total = max(Cases_Total)) %>%
  pull(total)

# Number of total deaths in WA state
total_deaths <- RaceData %>%
  filter(!is.na(Deaths_Total)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Deaths_Total)) %>%
  pull(total)

# Number of total hospitalizations in WA state
total_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_Total)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_Total)) %>%
  pull(total)

total_percent <- as.numeric(total_cases)

# Number of black cases in WA state
black_cases <- RaceData %>%
  filter(!is.na(Cases_Black)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Cases_Black)) %>%
  pull(total)

# How many of the total cases are made up by black people in WA state
black_cases_percent <- trunc(black_cases / total_percent * 100)

# Number of black deaths in WA state
black_deaths <- RaceData %>%
  filter(!is.na(Deaths_Black)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Deaths_Black)) %>%
  pull(total)

# Number of black hospitalizations in WA state
black_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_Black)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_Black)) %>%
  pull(total)

# Number of white cases in WA state
white_cases <- RaceData %>%
  filter((State == "WA")) %>%
  filter((Date == "20201202")) %>%
  filter(!is.na(Cases_White)) %>%
  summarise(total = max(Cases_White)) %>%
  pull(total)

white_percent <- as.numeric(white_cases)

# Number of white deaths in WA state
white_deaths <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Deaths_White)) %>%
  summarise(total = max(Deaths_White)) %>%
  pull(total)

# Number of white hospitalizations in WA state
white_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_White)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_White)) %>%
  pull(total)


# How many of the total cases are made up by white people in WA state
white_cases_percent <- trunc(white_percent / total_percent * 100)


# Number of LatinX cases in WA state
latinx_cases <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Cases_LatinX)) %>%
  summarise(total = max(Cases_LatinX)) %>%
  pull(total)

# Number of LatinX deaths in WA state
latinx_deaths <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Deaths_LatinX)) %>%
  summarise(total = max(Deaths_LatinX)) %>%
  pull(total)

# Number of white hospitalizations in WA state
latinx_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_LatinX)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_LatinX)) %>%
  pull(total)

# How many of the total cases are made up by LatinX people in WA state
latinx_cases_percent <- trunc(latinx_cases / total_percent * 100)

# Number of Asian cases in WA state
asian_cases <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Cases_Asian)) %>%
  summarise(total = max(Cases_Asian)) %>%
  pull(total)

# Number of Asian deaths in WA state
asian_deaths <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Deaths_Asian)) %>%
  summarise(total = max(Deaths_Asian)) %>%
  pull(total)

# Number of Asian hospitalizations in WA state
asian_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_Asian)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_Asian)) %>%
  pull(total)

# How many of the total cases are made up by Asian people in WA state
asian_cases_percent <- trunc(asian_cases / total_percent * 100)

# Number of American Indian or Alaskan Native cases in WA state
aian_cases <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Cases_AIAN)) %>%
  summarise(total = max(Cases_AIAN)) %>%
  pull(total)

# Number of American Indian or Alaskan Native deaths in WA state
aian_deaths <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Deaths_AIAN)) %>%
  summarise(total = max(Deaths_AIAN)) %>%
  pull(total)

# Number of American Indian or Alaskan Native hospitalizations in WA state
aian_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_AIAN)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_AIAN)) %>%
  pull(total)

# How many of the total cases are made up by American Indian or Alaskan Native
# people in WA state
aian_cases_percent <- trunc(aian_cases / total_percent * 100)

# Number of Native Hawaiian and Pacific Islander cases in WA state
nhpi_cases <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Cases_NHPI)) %>%
  summarise(total = max(Cases_NHPI)) %>%
  pull(total)

# Number of Native Hawaiian and Pacific Islander deaths in WA state
nhpi_deaths <- RaceData %>%
  filter((State == "WA")) %>%
  filter(!is.na(Deaths_NHPI)) %>%
  summarise(total = max(Deaths_NHPI)) %>%
  pull(total)

# Number of Native Hawaiian and Pacific Islander hospitalizations in WA state
nhpi_hospitalizations <- RaceData %>%
  filter(!is.na(Hosp_NHPI)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Hosp_NHPI)) %>%
  pull(total)

# How many of the total cases are made up by Native Hawaiian and Pacific
# Islander people in WA state
nhpi_cases_percent <- trunc(nhpi_cases / total_percent * 100)


races <- function(race) {
  df <- filter(RaceData, State == "WA")
  race_num <- df[[race]]
  number <- as.numeric(race_num)
  max_num <- max(number, na.rm = TRUE)
  return(max_num)
}



viz <- function(input) {
  plan <- RaceData %>%
    gather("type", "n", 3:ncol(RaceData)) %>%
    filter(!is.na(n)) %>%
    filter(State == "WA")
  plan$Date <- as.character(plan$Date)
  plan$Date <- as.Date(plan$Date, "%Y%m%d")
  plan$n <- as.numeric(plan$n)
  filter_specific <- plan %>% filter(type %in% input)

  v <- ggplot(filter_specific) +
    geom_line(aes(x = Date, y = n, group = type, color = type))
  v <- ggplotly(v)
  return(v)
}

# Muhammad's Work:
WA_owners <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(OWNER, COUNTY) %>%
  summarize(length(COUNTY))
names(WA_owners)[names(WA_owners) == "length(COUNTY)"] <- "Hospitals"

WA_hospitals <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(OWNER) %>%
  summarize(length(OWNER))
names(WA_hospitals)[names(WA_hospitals) == "length(OWNER)"] <- "Number of Hospitals"


# Peyton's Work:
wa_covid <- washington_history %>%
  select(positive, hospitalizedCurrently, date) %>%
  drop_na()

date_range <- c(min(wa_covid$date), max(wa_covid$date))

# Zulkifli's Work:
top_10_beds_county <- hospitals %>%
  filter(STATE == "WA") %>%
  select(COUNTY, BEDS) %>%
  group_by(COUNTY) %>%
  summarize(total_beds = sum(BEDS)) %>%
  arrange(-total_beds) %>%
  top_n(10)

percentage_of_cases_race <- list(
  Black = black_cases_percent,
  White = white_cases_percent,
  Latinx = latinx_cases_percent,
  Asian = asian_cases_percent,
  AIAN = aian_cases_percent,
  NHPI = nhpi_cases_percent
)

df_percentage_cases_race <- enframe(percentage_of_cases_race)
names(df_percentage_cases_race)[names(
  df_percentage_cases_race
) == "name"] <- "Race"
names(df_percentage_cases_race)[names(
  df_percentage_cases_race
) == "value"] <- "Percentage of Cases in WA"


# Define server function
server <- function(input, output) {
  output$viz <- renderPlotly({
    viz(input$checkGroup)
  })

  output$analysis <- renderText({
    # paste0("")
  })

  output$hospitalizations <- renderPlotly({
    plot <- wa_covid %>%
      filter(date >= input$choose_date[1], date <= input$choose_date[2])

    ggplot(plot) +
      geom_point(mapping = aes(x = positive, y = hospitalizedCurrently)) +
      geom_smooth(mapping = aes(x = positive, y = hospitalizedCurrently)) +
      labs(
        title = "Positive COVID Cases vs Current Hospitalizations",
        x = "Positive Cases", y = "Current Hospitalizations"
      )
  })

  output$df_percentage_cases_race <- renderDataTable({
    df_percentage_cases_race
  })

  output$top_10_beds_county <- renderDataTable({
    top_10_beds_county
  })

  output$WA_hospitals <- renderDataTable({
    WA_hospitals
  })

  output$boxplot <- renderPlotly({
    plot <- WA_owners %>%
      filter(COUNTY == input$sidebar_content)

    ggplot(plot, mapping = aes_string(x = "OWNER", y = "Hospitals")) +
      geom_bar(stat = "identity") +
      coord_cartesian(ylim = c(0, 20)) +
      labs(title = "Hospitals", x = "Ownership", y = "Number of Hospitals")
  })
}
