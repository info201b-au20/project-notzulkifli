# app.R
# Load in libraries
library("shiny")

# Read in files (source)
source("app_ui.R")
source("app_server.R")

# Create the shiny app by defining the UI and server
shinyApp(ui = ui, server = server)