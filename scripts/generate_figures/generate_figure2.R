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
  labs(x = "Year", y = "Percent of Nuclear Energy Produced") +
  ggtitle("Percent of Nuclear Energy Produced Domestically")

ggsave("other/figures/figure2.png", plot)