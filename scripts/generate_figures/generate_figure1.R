#### Preamble ####
# Purpose: Generates Figure 1.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(ggthemes)

data <- read_csv("data/analysis_data/consumption.csv")
data

data <- data |>
  select(year, total_energy, price) |>
  group_by(year) |>
  summarise(total_energy = mean(total_energy), price = mean(price))
mean_price_2011 <- 16.92426	
mean_consumption_2011 <- 7163859

data <- data |>
  mutate(
    relative_consumption = total_energy/mean_consumption_2011,
    relative_price = price/mean_price_2011
  )
data |>
  select(year, relative_consumption, relative_price)

plot <- data |>
  ggplot(
    mapping = aes(x = year)
  ) +
  theme_fivethirtyeight() +
  theme(
    plot.background = element_rect(fill = "white"),
    panel.grid = element_line(color = "black"),
    panel.background = element_rect(fill = "white")
  ) +
  scale_x_continuous(breaks = data$year) +
  geom_point(aes(y = relative_consumption, color = "Energy Consumption")) +
  geom_path(aes(y = relative_consumption), linetype = "dotted") +
  geom_point(aes(y = relative_price, color = "Price")) +
  geom_path(aes(y = relative_price), linetype="dotdash") +
  geom_hline(yintercept = 1)

ggsave("other/figures/figure1.png", plot)
