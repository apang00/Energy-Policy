#### Preamble ####
# Purpose: Cleans temperature data in Japan.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(readxl)

clean_csv <- function(file) {
  data <- read_csv(sprintf("data/raw_data/weather/csv/%s_201.csv", file), skip = 6)
  data <- data |>
    select(1, 2, 3, 4) |>
    rename(
      year = names(data)[1],
      month = names(data)[2],
      day = names(data)[3],
      temperature = names(data)[4]
    )|>
    filter(year >= 2005)
  
  return(data)
}

station_data <- read_excel("data/raw_data/weather/station.xlsx")

total_data <- data.frame()
count <- 1

for (id in station_data$station_id) {
  data <- clean_csv(id)
  data <- data |>
    mutate(
      id = station_data$pref_id[count]
    )
  total_data <- rbind(total_data, data)
  count <- count + 1
}

total_data <- total_data |>
  group_by(id, year, month, day) |>
  summarise(temperature_avg = mean(temperature, na.rm = TRUE)) |>
  ungroup()


write_csv(total_data, "data/analysis_data/clean_temperature.csv")