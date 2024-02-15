#### Preamble ####
# Purpose: Generates Figure 1.
# Date: 14 February 2024
# License: MIT

library(tidyverse)

data <- read_csv("data/analysis_data/clean_domestic.csv")

plot <- data |>
  ggplot(
    aes(x = year)
  ) +
  theme_fivethirtyeight() +
  theme_bw() +
  scale_x_continuous(breaks = data$year) +
  geom_point(aes(y = percent_nuclear)) +
  geom_path(aes(y = percent_nuclear)) +
  labs(x = "Year", y = "Percent of Nuclear Energy") +
  labs(caption = "FIGURE 1: Domestic Nuclear Energy Production", color = "") +
  theme(plot.caption=element_text(hjust=0.5))

ggsave("other/figures/figure1.png", plot)