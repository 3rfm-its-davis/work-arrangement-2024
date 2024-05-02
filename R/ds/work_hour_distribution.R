data %>%
  select(row_index, matches("hours_total")) %>%
  gather(
    key = "key",
    value = "value",
    matches("hours_total")
  ) %>%
  mutate(
    value = cut(
      value,
      breaks = seq(0, 90, 5),
      include.lowest = TRUE,
      right = FALSE
    ),
  ) %>%
  group_by(key, value) %>%
  reframe(
    n = n() / nrow(data)
  ) %>%
  ggplot() +
  geom_line(
    aes(
      x = value %>% as.numeric(),
      y = n,
      color = key,
    )
  ) +
  geom_point(
    aes(
      x = value %>% as.numeric(),
      y = n,
      color = key
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "bottom"
  ) +
  labs(
    x = "Number of Hours",
    y = "Proportion of Workers"
  ) +
  scale_y_continuous(
    labels = scales::percent_format()
  ) +
  scale_x_continuous(
    breaks = 0:18,
    labels = paste0(
      "[",
      seq(0, 90, 5) - 5,
      "-",
      seq(5, 95, 5) - 5,
      ")"
    )
  ) +
  guides(
    color = guide_legend(
      title = "Place of Work",
    ),
  ) +
  scale_color_discrete(
    labels = c(
      "Total",
      "Primary Location",
      "Temporary Location",
      "Home"
    )
  ) +
  theme(
    axis.text.x = element_text(
      angle = 22.5,
      hjust = 0.9
    )
  )

ggsave(
  filename = file.path(
    "output",
    "ds",
    "work_hours_distribution.png"
  ),
  width = 8,
  height = 4,
  dpi = 300,
  units = "in"
)
