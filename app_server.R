# server.R
# Load in libraries
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)

# Define server function
server <- function(input, output) {
  
  # Render text object that returns the paragraph
  output$image <- renderImage({
    outfile <- tempfile(fileext = ".jpg")
    
    jpg(outfile, width = 480, height = 640)
    hist(rnorm(input$obs), main = "Generated in renderImage()")
    dev.off()
    
    list(src = outfile,
         contentType = 'image/jpg',
         width = 480,
         height = 640,)
  }, deleteFile = TRUE)
}
