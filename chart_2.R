library(tidyverse)
library(ggplot2)
library(stringr)
library(readxl)

washington_history <- read_excel("C:/Users/themo/Desktop/INFO 201/washington-history.xlsx")



ggplot(data = washington_history) +
  geom_point(mapping = aes(x = positive, y = hospitalizedCurrently)) +
  geom_smooth(mapping = aes(x = positive, y = hospitalizedCurrently)) +
  labs(title="Number of Positive Cases vs Current Hospitalizations in Washington",
       x ="Positive Cases", y = "Current Hospitalizations")