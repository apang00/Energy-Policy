# install.packages("readxl")
# install.packages("tidyverse")
# install.packages("haven")

library(readxl)
library(tidyverse)
library(haven)

# read data
price_data <- read_excel("data/raw_data/price.xlsx")


price_data <- price_data |>
  pivot_longer(
    cols = starts_with("q"),
    names_to = "year",
    values_to = "yen"
  )

price_data <- price_data |>
  select(area, year, price) 

price_data <- price_data |>
  mutate(
    quarter = substr(year, 7, 7),
    year = substr(year, 2, 5),
    area = case_when(
      area == "北海道" ~ "hokkaido",
      area == "東京" ~ "tokyo",
      area == "北陸" ~ "hokuriku",
      area == "中部" ~ "chubu",
      area == "関西" ~ "kansai",
      area == "四国" ~ "shikoku",
      area == "九州" ~ "kyushu",
      area == "沖縄" ~ "okinawa",
      area == "東北" ~ "tohoku",
      area == "中国" ~ "chugoku",
      TRUE ~ "NA"
    )
  )

write_csv(price_data, "data/analysis_data/price.csv")


