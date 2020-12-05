# ui.R
# Load in libraries
library(shiny)
library(plotly)

# First side bar panel for intro page
intro_sidebar_Paragraph <- sidebarPanel(
      textOutput("Our dataset is used to recognize differing COVID-19 datasets across 
      counties in Washington State. We are attempting to analyze the differing
      number & type of hospitals in each county, positive cases per county, and 
      Hopspitalizations types and cases by race in counties with varying populations,
      demographics, and incomes. With this we intend to analyze which counties
      may have disadvantages over others when it comes to dealing with COVID,
      due to differing levels of access to healthcare resources per county.
      This helps meet our overarching goal of combating health disparities in 
      Washington State by providing dataset analyses comparing how COVID has 
      impacted different people and cities."),
      align = "left"
)

# First main panel for intro page
intro_main_image <- mainPanel(
  img(source("scripts/uwmc.jpg")), align = "right")

# First page
intro_panel <- tabPanel(
  "Intro",
  titlePanel("Introduction"),
  sidebarLayout(
    sidebarPanel(
      intro_sidebar_Paragraph
    )
  )
)

# Define the UI and what pages/tabs go into it
ui <- navbarPage(
  "Washington State Health and Resources",
  intro_panel
)