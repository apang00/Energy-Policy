library(tidyverse)
library(haven)
library(readxl)

data_new <- read_excel("data/raw_data/consumption.xlsx")

data_new <- data_new |> 
  slice(-3) |>
  slice(-1)

data_new <- data_new |>
  select(...2, ...11, `Ⅴ．電灯電力需要実績月報`) |>
  rename(area = `Ⅴ．電灯電力需要実績月報`, year = ...2, total_energy = ...11) |>
  slice(-1) |>
  mutate(
    month = substr(year, 5, 6),
    year = substr(year, 1, 4),
    area = case_when(
      area == "北海道電力" ~ "hokkaido",
      area == "東北電力" ~ "tohoku",
      area == "東京電力" ~ "tokyo",
      area == "中部電力" ~ "chubu",
      area == "北陸電力" ~ "hokuriku",
      area == "関西電力" ~ "kansai",
      area == "中国電力" ~ "chugoku",
      area == "四国電力" ~ "shikoku",
      area == "九州電力" ~ "kyushu",
      area == "沖縄電力" ~ "okinawa"
    )
  )

write_csv(data_new, "data/analysis_data/energy.csv")
