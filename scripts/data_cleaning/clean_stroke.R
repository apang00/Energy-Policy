#### Preamble ####
# Purpose: Cleans heat stroke data in Japan.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(haven)
library(readxl)

total_data <- data.frame()
year <- 2008 
while (year < 2016) {
  data <- read_excel(sprintf("data/raw_data/stroke%d.xlsx", year))
  total_data <- bind_rows(data, total_data)
  year <- year + 1
}

total_data <- total_data |>
  rename(date = "日付",
         prefecture_code = "都道府県コード",
         people_transported = "搬送人員（計）",
         age_newborn = "年齢区分：新生児",
         age_toddler = "年齢区分：乳幼児",
         age_child = "年齢区分：少年",
         age_adult = "年齢区分：成人",
         age_senior = "年齢区分：高齢者",
         age_unknown = "年齢区分：不明",
         injury_death = "傷病程度：死亡",
         injury_severe = "傷病程度：重症",
         injury_moderate = "傷病程度：中等症",
         injury_light = "傷病程度：軽症",
         injury_other = "傷病程度：その他"
  )

total_data <- total_data |>
  mutate(
    period = substr(date, 1, 7)
  ) |>
  select(period, prefecture_code, people_transported)

write_csv(total_data, "data/analysis_data/stroke.csv")