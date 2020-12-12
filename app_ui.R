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
washington_history <- read.csv("https://covidtracking.com/data/download/washington-history.csv")

# Peyton's Work:
wa_min_date <- washington_history %>%
  filter(!is.na(date)) %>%
  filter(date == min(date)) %>%
  pull(date)

wa_max_date <- washington_history %>%
  filter(!is.na(date)) %>%
  filter(date == max(date)) %>%
  pull(date)

date_range <- c(min(wa_covid$date), max(wa_covid$date))

# Widgets
choose_date <- dateRangeInput("choose_date", label = h3("Date range",
  start = date_range[1], end = date_range[2],
  format = "yyyy-mm-dd", startview = "month",
  weekstart = 0, language = "en", separator = " to "
))

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
        h1("Introduction:", align = "center"),
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
          strong("Is there a correaltion between the number of hospitalization
          and number of COVID cases in Washington?"),
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
        "and these data sets will aid us in our analysis to answer the questions
      while using a",
          strong("line chart to display 'Number of COVID cases per Race',
                 scatter plot to display the 'Current Hospitalizations', and
                 bar chart to display the 'Type of Hospitals in Counties'"),
          "to further support our findings.",
          align = "center"
        ),
        tags$img(src = "uwmedcenter.png", align = "center"),
        p("UW Medical Center", align = "center")
      ),
    ),
    tabPanel(
      "Number of COVID cases per Race",


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
          textOutput("analysis"),
          br(),
          br(),
          h2("Chart Analysis:"),
          p(
            "This line chart shows the number of covid cases per race in WA
            State. Our data looks at 6 races:",
            strong("White, Black, LatinX, Asian,
         American Indian Alaskan Native, and Native Hawaiian Pacific Islander"),
            "in order to see if any health disparities occurred toward a certain
            race/races. As we can see from the get go, there is a large number
            of cases especially affecting the",
            strong("White , Black, and LatinX"),
         "communities. However, when we take a closer look, we can see potential
            disparities affecting racial groups we can flag the",
            strong("LatinX community"),
            "as possibly being affected as they have",
            em("a large number of total
            cases (21%) but only make up a small amount of the population
            (13% according to the database)"),
            "as opposed to ",
            em("White people that make
            up 69% of the population and account for 46% of the cases"), "or ",
            em("Black
            people that account for 4% of the population while only making up 6%
            of the cases."),
            "The other races we looked at were ", strong("Asian"), "(3% of cases
            and 8% of the population),",
            strong("American Indian and Alaskan Native)"),
            "(<1% of cases and 1% of the population) and",
            strong("Hawaiian Native and
            Pacific Islander"), "(1% of cases and <1% of the population).
            One point that should be noted is that the total percentage of cases
            total up to about 55% and that the other 45% of the data is still
            being collected as we speak, comes from an unknown source, or comes
            from a mix of 2 races, a race we did not include in our analysis.
            Due to this daunting statistic, more work needs to be done and more
            resources must be given to the LatinX community in order to aid them
            in the fight against COVID-19."
          )
        )
      )
    ),
    tabPanel(
      "Current Hospitalizations",

      titlePanel("WA COVID_19 Cases and Hospitalizations"),

      sidebarLayout(
        sidebarPanel(
          choose_date
        ),
        mainPanel(
          plotlyOutput("hospitalizations"),
          h2("Chart Analysis:"),
          p("This scatterplot shows the relationship between the increasing
          number of
      positive cases of COVID-19 in Washington compared to the current number of
      hospitalizations on that date. Some observations to be noted are the spike
      in the scatterplot in the beginning of the pandemic as many people were
      exposed to the virus due to lack of social distancing, which can be viewed
 by changing the date range. However, when adjusting the dates we can see midway
      through the graph the number of cases and hospitalizations diminish as
      quarantine protocols are put in place but spike again as people start to
      let up on social distancing later on.")
        )
      )
    ),
    tabPanel(
      "Type of Hospitals in Counties",

      titlePanel("Number and Type of Hospitals in WA Counties"),

      sidebarLayout(
        sidebarPanel(
          sidebar_content
        ),
        mainPanel(
          main_content,
          h2("Chart Analysis:"),
          p(
            "This interactive bar graph displays the type of ownership on the x
            axis and the number of hospitals on the y axis. The user may explore
            each county in Washington state. There are three countries that do
            not have hospitals. They are,",
         strong("Douglas, Skamania, and Wahkiakum."), "All of these counties are
            rural and do not have large populations.
            Otherwise, every other country has at least 1 hospital.",
           strong("King county has the greatest number of hospitals and the most
            diverse types of hospitals"), "in terms of ownership which is to be
            expected given that they are the most populous county in WA.
            There are many possible types of ownerships and the data shows many
            counties rely on",
            em("nonprofits or government hospitals"), "to serve their
            county. These counties tend to be smaller in population and would
            therefore lack this essential resource without support from
            nonprofits and the government. Of the government hospitals, most
            tend to be",
            em("district/authority rather than federally or state owned."),
           "This indicates that it is crucial to support and fund hospitals that
            serve rural and underserved areas as they sometimes are the only
            hospital in the area."
          )
        )
      )
    ),
    tabPanel(
      "Summary",
      h2("Summary Analysis:"),
      p(
        "Using data from the,",
        em("Department of Homeland Security and The COVID Tracking Project"),
        "we determined that receiving information on hospitals
        and relating information (such as number of beds or any pertinent
        information on the hospital) would be best for our analysis on the
        state of Washington. We calculated that there are",
        strong("6 unique types of
        ownership a hospital in WA"),
        "could have and that the mean amount
        of hospitals in each county in WA is 3.667 whereas the median is 2.
        the data given. We found that there were 36 counties in WA with at
        least one hospital, whereas 3 counties have no hospitals at all.
        We also provided a line chart to analyze the number of COVID
        cases per Race, scatterplot for the number of positive COVID
        cases vs current number of hospitalizations, and a bar chart to display
        the number and types of hospitals in Washington counties. We believed
        that calculating these values are most pertinent for us to determine the
        degree to which COVID-19 has affected the state of Washington."
      ),
      br(),
      br(),
      h3("Key take away #1"),
      p(
        "As we examined the COVID-19 cases in the state of Washington, we
        noticed that",
        strong("LatinX Communities"),
        "have been effected the most in the racial groups with 21% of cases
        even only when they make up only 13% of population. One important
        information to note is when totaled up, the percentage of cases is
        totaled up to 55% with 45% of the data still being collected.",
        strong("LatinX communities"), "are in need of our support during this
        pandemic to aid them from COVID-19. We should do so by providing more
      resources from the disparities it causes to racial groups in Washington"
      ),
      dataTableOutput("df_percentage_cases_race"),
      br(),
      br(),
      h3("Key take away #2"),
      p(
        "In examining differing health resources among
        Washington state we found the top ten counties with the most hospital
       beds to correspond to the counties with the highest populations such as",
        strong("King and Spokane county."),
        "This is one major takeaway as areas where there
        may be less of a population or lower income counties may have a lack of
        hospital beds and resources in their area. In our Hospitalization data
        we found that the",
        em("more positive cases the higher the spike in currently
        hospitalized patients."),
        "As the cases spike, areas where there is a lack
        of hospitals and hospital beds are at",
        em("higher risk for COVID life
        threatening effects."),
        "This helps address our second original question of
        how COVID cases may impact hospital capacities as well our overarching
        topic of health disparities by displaying that some counties may be
        fortunate to have more resources than others impacting patients
        abilities to receive healthcare treatment options for COVID-19."
      ),
      dataTableOutput("top_10_beds_county"),
      br(),
      br(),
      h3("Key take away #3"),
      p("Of the 132 hospitals total in WA, 31.8% are owned by district
        governments and 42.4% are nonprofits. The least common type of ownership
        is local and state owned hospitals as well as proprietary. This data
        displays how it is crucial to invest in and support nonprofit hospitals
        and district/authority owned hospitals as they are types of hospitals
        most commonly available to support rural and underserved communities."),
      dataTableOutput("WA_hospitals"),
      tags$img(
        src = "mask.png", align = "center", height = 800,
        width = 800
      )
    )
  )
)
