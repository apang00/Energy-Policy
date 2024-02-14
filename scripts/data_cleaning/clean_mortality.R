library(tidyverse)

data <- read.table("data/raw_data/deaths.txt", header = TRUE, skip = 2)

data <- data |>
  select(Year, Total) |>
  rename(year = Year) |>
  filter(year >= 2005 & year <= 2015) |>
  group_by(year) |>
  summarise(total = sum(Total))

write_csv(data, "data/analysis_data/mortality.csv")