plot <- data %>%
  select(row_index, matches("days_main")) %>%
  gather(
    key = "key",
    value = "value",
    matches("days_main")
  ) %>%
  group_by(key, value) %>%
  reframe(
    n = n() / nrow(data)
  ) %>%
  ggplot(
    aes(
      x = value,
      y = n,
      color = key
    )
  ) +
  geom_line() +
  geom_point() +
  theme_bw() +
  theme(
    legend.position = "bottom"
  ) +
  labs(
    x = "Number of Days",
    y = "Proportion of Workers"
  ) +
  scale_y_continuous(
    labels = scales::percent_format()
  ) +
  scale_x_continuous(
    breaks = 0:7
  ) +
  guides(
    color = guide_legend(
      title = "Place of Work",
    ),
  ) +
  scale_color_discrete(
    labels = c(
      "Primary Location",
      "Temporary Location",
      "Home"
    )
  )

ggsave(
  filename = file.path(
    "output",
    "ds",
    "main_work_days_distribution.png"
  ),
  width = 7,
  height = 3.5,
  dpi = 300,
  units = "in"
)
