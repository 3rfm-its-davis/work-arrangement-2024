data_label <- tibble(
  x = 100,
  y = 90,
  label = paste0(
    "y = ",
    round(
      coef(lm(hours_total ~ naive_total, data = data))[2], 2
    ),
    "x + ",
    round(
      coef(lm(hours_total ~ naive_total, data = data))[1], 2
    )
  )
)

plot <- data %>%
  select(naive_total, hours_total) %>%
  group_by_all() %>%
  reframe(n = n()) %>%
  ggplot() +
  geom_point(
    aes(
      x = naive_total, y = hours_total,
      size = sqrt(n),
      alpha = 0.2,
      stroke = 0
    )
  ) +
  # abline for a=0.75 and a =1.33
  geom_abline(
    intercept = 0,
    slope = 0.75,
    linetype = "dotted"
  ) +
  # abline for a=0.75 and a =1.33
  geom_abline(
    intercept = 0,
    slope = 1,
    linetype = "dotdash"
  ) +
  geom_abline(
    intercept = 0,
    slope = 1.33,
    linetype = "dotted"
  ) +
  labs(
    x = "Total of Work Hours Reported for Each Day",
    y = "Total of Work Hours Reported as Matrix Response"
  ) +
  theme_bw() +
  theme(
    legend.position = "none",
  ) +
  coord_fixed()

ggsave(
  filename = file.path(
    "output",
    "ds",
    "scatterplot_work_hour.png"
  ),
  width = 4,
  height = 4,
  dpi = 300,
  units = "in"
)
