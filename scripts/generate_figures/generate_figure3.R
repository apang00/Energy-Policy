#### Preamble ####
# Purpose: Generates Figure 3.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(ggthemes)

data <- read_csv("data/analysis_data/mr.csv")

data <- data |>
  group_by(year >= 2010) |>
  summarise(avg_rate = mean(dr)*100) |>
  ungroup() |>
  rename(policy = "year >= 2010") |>
  mutate(
    policy = case_when(
      policy == FALSE ~ "Before Policy",
      policy == TRUE ~ "Post Policy"
    )
  )

plot <- data |>
  ggplot(aes(x = policy)) +
  theme_fivethirtyeight() +
  theme_bw() +
  geom_point(aes(y = avg_rate)) +
  labs(x = "Policy", y = "Mortality Rate (%)") +
  labs(caption = "FIGURE 3: Mortality Rate and Energy Policy", color = "")  +
  theme(plot.caption=element_text(hjust=0.5))

ggsave("other/figures/figure3.png", plot)