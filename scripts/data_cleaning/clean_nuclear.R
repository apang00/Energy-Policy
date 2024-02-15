#### Preamble ####
# Purpose: Cleans nuclear energy production data in Japan.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(readxl)
library(haven)

clean_sheet <- function(sheet) {
  sheet <- sheet |>
    filter(...2 == "供給力　計" | ...3 == "原子力発電所") |>
    select(!c(1, 4, 15))
  
  sheet <- sheet |>
    rbind(c("a", "b", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
  
  colnames(sheet) <- NULL
  
  sheet <- sheet |>
    t() |>
    as.data.frame() |>
    rename("area_id" = "V3", "total" = "V2", "nuclear" = "V1") |>
    select(nuclear, total, area_id) |>
    slice(-2) |>
    slice(-1)
  
  sheet <- sheet |>
    mutate(
      nuclear = as.numeric(nuclear),
      total = as.numeric(total)
    ) 
  
  return(sheet)
}


clean_file <- function(file, year) {
  sheets <- excel_sheets(file) 
  total_data <- data.frame()
  
  c <- 1
  while (c < 13){
    sheet <- read_excel(file, sheets[c])
    data <- clean_sheet(sheet)
    data <- data |>
      mutate(
        year = case_when(
          c < 10 ~ year,
          c >= 10 ~ year + 1
        ),
        month = case_when(
          c < 10 ~ c + 3,
          c == 10 ~ 1,
          c == 11 ~ 2,
          c == 12 ~ 3
        )
      )
    
    total_data <- rbind(total_data, data)
    c <- c + 1
  }
  
  return(total_data)
}


year <- 2007 
total_data <- data.frame()

while (year < 2016) {
  file <- sprintf("data/raw_data/nuclear/%d.xls", year)
  data <- clean_file(file, year)
  total_data <- rbind(total_data, data)
  year <- year + 1
}

total_data <- total_data |>
  filter(year != 2007 & year != 2016)

total_data$nuclear <- total_data$nuclear |> replace_na(0)
total_data$total <- total_data$total |> replace_na(0)

write_csv(total_data, "data/analysis_data/nuclear.csv")
