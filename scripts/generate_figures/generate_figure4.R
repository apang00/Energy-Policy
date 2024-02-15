#### Preamble ####
# Purpose: Generates Figure 4.
# Date: 14 February 2024
# License: MIT

library(tidyverse)
library(ggthemes)

data <- read_csv("data/analysis_data/stroke.csv")

data <- data |>
  group_by(period) |>
  summarise(num = sum(people_transported, na.rm = TRUE))

plot <- data |>
  ggplot(
    mapping = aes(x = period, y = num)
  ) +
  geom_bar(stat = "identity", fill = "lavender") +
  theme_test() +
  labs(x = "Period", y = "Number of Heatstroke Incidents") +
  labs(caption = "FIGURE 4: Heatstroke Incidents from 2008 to 2015", color = "") +
  theme(plot.caption=element_text(hjust=0.5))

ggsave("other/figures/figure4.png", plot)