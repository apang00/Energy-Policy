library(tidyverse)

data <- read_csv("data/raw_data/domestic.csv")

data <- data |>
  select(!Units) |>
  mutate(
    "generation_type" = case_when(
      `electricity generation in Japan` %in% c("Coal", "Oil", "Natural gas", 
                                               "Hydro", "Biofuels", "Waste", "Wind",
                                               "Solar PV", "Geothermal", "Other sources") ~ "other",
      `electricity generation in Japan` == "Nuclear" ~ "Nuclear"
    ),
    "value" = Value,
    "year" = Year
  ) |>
  select(year, value, generation_type) |>
  group_by(year) |>
  mutate(total = sum(value)) |>
  filter(generation_type == "Nuclear") |>
  filter(year >= 2005 & year <= 2015) |>
  summarise(year, percent_nuclear = value / total)

data$percent_nuclear <- replace_na(data$percent_nuclear, 0)

write_csv(data, "data/analysis_data/clean_domestic.csv")