library(tidyverse)
library(ggplot2)
library(stringr)

washington_history <- read.csv("https://covidtracking.com/data/download/washington-history.csv")

ggplot(data = washington_history) +
  geom_point(mapping = aes(x = positive, y = hospitalizedCurrently)) +
  geom_smooth(mapping = aes(x = positive, y = hospitalizedCurrently)) +
  labs(title="Number of Positive Cases vs Current Hospitalizations in Washington",
       x ="Positive Cases", y = "Current Hospitalizations")