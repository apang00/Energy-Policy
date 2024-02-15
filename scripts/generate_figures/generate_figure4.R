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
  labs(x = "Period", y = "Number of Heatstroke Incidents")

ggsave("other/figures/figure4.png", plot)