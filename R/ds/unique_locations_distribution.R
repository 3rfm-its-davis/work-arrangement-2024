plot <- data %>%
  select(row_index, matches("days_place")) %>%
  mutate(
    places_worked = case_when(
      days_place_1 > 0 & days_place_2 == 0 & days_place_3 == 0 ~ "Primary Only",
      days_place_1 == 0 & days_place_2 > 0 & days_place_3 == 0 ~ "Temporary Only",
      days_place_1 == 0 & days_place_2 == 0 & days_place_3 > 0 ~ "Home Only",
      days_place_1 > 0 & days_place_2 > 0 & days_place_3 == 0 ~ "Primary and Temporary",
      days_place_1 > 0 & days_place_2 == 0 & days_place_3 > 0 ~ "Primary and Home",
      days_place_1 == 0 & days_place_2 > 0 & days_place_3 > 0 ~ "Temporary and Home",
      days_place_1 > 0 & days_place_2 > 0 & days_place_3 > 0 ~ "All"
    ) %>%
      factor(
        levels = c(
          "Primary Only",
          "Temporary Only",
          "Home Only",
          "Primary and Temporary",
          "Primary and Home",
          "Temporary and Home",
          "All"
        )
      )
  ) %>%
  select(row_index, places_worked) %>%
  group_by(places_worked) %>%
  reframe(
    n = n()
  ) %>%
  mutate(
    n = n / nrow(data)
  ) %>%
  ggplot(
    aes(
      x = places_worked,
      y = n
    )
  ) +
  geom_bar(
    stat = "identity",
    fill = "steelblue"
  ) +
  geom_label(
    aes(
      label = scales::percent(round(n, 3))
    ),
    size = 3,
    position = position_stack(vjust = 0.5)
  ) +
  theme_bw() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(
      angle = 7.5,
      hjust = 0.9
    )
  ) +
  labs(
    x = "Work Locations Used in the Week",
    y = "Proportion of Workers"
  ) +
  scale_y_continuous(
    labels = scales::percent_format()
  )

ggsave(
  filename = file.path(
    "output",
    "ds",
    "unique_locations_distribution.png"
  ),
  width = 7,
  height = 3.5,
  dpi = 300,
  units = "in"
)
