#### Preamble ####
# Purpose: Cleans mortality rate data in Japan.
# Date: 14 February 2024
# License: MIT

library(tidyverse)

data <- read_csv("data/analysis_data/population.csv")

data <- data |>
  rename(population = total)

data_b <- read_csv("data/analysis_data/mortality.csv")

data_b <- data_b |>
  rename(deaths = total)

data <- merge(data, data_b, by = "year")

data <- data |>
  mutate(dr = deaths/population) |>
  select(year, dr)

write_csv(data, "data/analysis_data/mr.csv")