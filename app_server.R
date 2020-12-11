# server.R
# Load in libraries
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)

# Load in the data
RaceData <- read.csv("scripts/Data.csv", stringsAsFactors = FALSE)
hospitals <- read.csv("scripts/Hospitals.csv")

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

# Number of black cases in WA state
black_cases <- RaceData %>%
  filter(!is.na(Cases_Black)) %>%
  filter((State == "WA")) %>%
  summarise(total = max(Cases_Black)) %>%
  pull(total)

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


# Define server function
server <- function(input, output) {
  output$viz <- renderPlotly({
    viz(input$checkGroup)
  })

  output$analysis <- renderText({
    # paste0("")
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
