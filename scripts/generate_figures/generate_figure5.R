library(tidyverse)
library(ggthemes)

data <- read_csv("data/analysis_data/stroke.csv")

data <- data |>
  group_by(period, prefecture_code) |>
  summarise(num = sum(people_transported, na.rm = TRUE)) |>
  ungroup()

data <- data |>
  filter(prefecture_code %in% c(13, 26, 27, 47, 31))

data$prefecture_code <- factor(data$prefecture_code)
plot <- data |>
  ggplot(
    aes(x = period, y = num, color = prefecture_code, group = prefecture_code)
  ) +
  scale_color_manual(values = c("blue", "red", "black", "red4", "cadetblue"),
                     labels = c("Tokyo", "Kyoto", "Osaka", "Tottori", "Okinawa")) +
  geom_point() +
  geom_line(key_glyph = "point") +
  theme_bw() +
  theme(panel.background = element_rect(fill = "white")) +
  labs(x = "Period", y = "Heatstroke Incidents", color = "Prefecture")


ggsave("other/figures/figure5.png", plot)