
library(tidyverse)

energy_data <- read_csv("data/analysis_data/energy.csv")
price_data <- read_csv("data/analysis_data/price.csv")

energy_data <- energy_data |>
  filter(year >= 2004 & year <= 2015) |>
  mutate(month = as.numeric(month)) |>
  mutate(
    quarter = case_when(
      month <= 3 ~ 1,
      month > 3 & month <= 6 ~ 2,
      month > 6 & month <= 9 ~ 3,
      month > 9 ~ 4
    )
  )

data <- merge(energy_data, price_data, by = c("quarter", "area", "year"))

data <- data |>
  select(!quarter)

write_csv(data, "data/analysis_data/consumption.csv")