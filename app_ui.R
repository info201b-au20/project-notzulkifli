# ui.R
# Load in libraries
library(shiny)
library(plotly)
library(ggplot2)
library(RColorBrewer)
library(shinythemes)

# Read in the data set
RaceData <- read.csv("scripts/Data.csv", stringsAsFactors = FALSE)
hospitals <- read.csv("scripts/Hospitals.csv")


# Muhammad's Work
WA_owners <- hospitals %>%
  filter(STATE == "WA") %>%
  group_by(OWNER, COUNTY) %>%
  summarize(length(COUNTY))
names(WA_owners)[names(WA_owners) == "length(COUNTY)"] <- "Hospitals"


select_values <- unique(WA_owners$COUNTY)

sidebar_content <- selectInput(
  inputId = "sidebar_content",
  label = "County",
  choices = select_values
)

main_content <- mainPanel(
  plotlyOutput("boxplot"),

  p(
    "Three counties do not have any hospitals at all. They are Douglas,
    Skamania, and Wahkiakum."
  )
)

# Define the UI and what pages/tabs go into it
ui <- fluidPage(
  theme = shinytheme("superhero"),
  navbarPage(
    "Washington State Health and Resources",
    tabPanel(
      "Introduction",
      mainPanel(
        h1("Introdution:", align = "center"),
        p("Our dataset is used to recognize differing COVID-19 datasets
             across counties in Washington State. We are attempting to analyze
             the differing number & type of hospitals in each county, positive
             cases per county, and Hopspitalizations types and cases by race in
             counties with varying populations, demographics, and incomes. With
             this we intend to analyze which counties may have disadvantages
             over others when it comes to dealing with COVID, due to differing
             levels of access to healthcare resources per county. This helps
             meet our overarching goal of combating health disparities in
             Washington State by providing dataset analyses comparing how COVID
             has impacted different people and cities.", align = "center"),
        br(),
        h3("Data-Driven Questions:", align = "center"),
        p("The questions that we set out to answer are: ",
          br(),
          strong("Are there health disparities present between different 
                 ethnicities/races that lead them to have poor healthcare as 
                 compared to others?"),
          br(),
          strong("Is there a correaltion between the number of hospitalization and
                 number of COVID cases in Washington?"),
          br(),
          strong("How many and what types of hospitals are in the counties
                 of Washington state?"),
          align = "center"
        ),
        br(),
        h3("Datsets:", align = "center"),
        p("The data sets we used were provided from the",
      em("Department of Homeland Security (Foundation-Level Data), and The
         COVID Tracking Project"),
        "and these data sets will aid us in our analysis to answer the questions while using a",
      strong("line chart, scatter plot, and bar chart"), 
      "to further support our findings.",
          align = "center"
        ),
        tags$img(src = "uwmedcenter.png", align = "center"),
        p("UW Medical Center", align = "center")
      ),
    ),
    tabPanel(
      "Number of COVID cases per race",


      # Application title
      titlePanel("Number of Covid Cases per Race in WA State"),

      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("checkGroup",
            label = h3("Please Choose the
                                      Race/Races You Want to See the Data for"),
            choices = list(
              "White" = "Cases_White",
              "Black" = "Cases_Black",
              "LatinX" = "Cases_LatinX",
              "Asian" = "Cases_Asian",
              "AIAN" = "Cases_AIAN",
              "NHPI" = "Cases_NHPI"
            ),
            selected = "Cases_White"
          )
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotlyOutput("viz"),
          textOutput("analysis")
        )
      )
    ),
    tabPanel(
      "Current Hospitalizatoins",
      p("work in progress")
    ),
    tabPanel(
      "Type of Hospitals in Counties",

      titlePanel("Number and Type of Hospitals in WA Counties"),

      sidebarLayout(
        sidebarPanel(
          sidebar_content
        ),
        main_content
      )
    ),
    tabPanel(
      "Summary",
      h2("Summary Analysis:"),
      p("Using data from the Department of Homeland Security and the New
             York Times, we determined that receiving information on hospitals
             and relating information (such as number of beds or any pertinent
             information on the hospital) would be best for our analysis on the
             state of Washington. We calculated the total unique type of
             ownership a hospital in WA could have (6), we also calculated the
             mean (3.667) and median (2) amount of hospitals in each county from
             the data given. We found that there were 36 counties in WA with at
             least one hospital, and there are 39 counties total meaning 3
             counties have no hospitals at all. We also provided a box and
             whisker plot for the number of hospitals per county, a scatterplot
             for the number of positive COVID cases vs current number of
             hospitalizations, and a bar chart of the number of hospitals vs
             number of deaths. We believed that calculating these values are
             most pertinent for us to determine the degree to which COVID-19 has
             affected the state of Washington."),
      tags$img(
        src = "mask.png", align = "right", height = 800,
        width = 800
      )
    )
  )
)