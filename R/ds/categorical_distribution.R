categories <- c(
  "age",
  "gender",
  "kids",
  "income",
  "education12",
  "neighborhood",
  "impedance",
  "jobtype12",
  "homeownership"
)

labels <- c(
  "Age Group",
  "Gender",
  "Presence of Kids in Household",
  "Household Income Level",
  "Educational Attainment",
  "Neighborhood Type",
  "Travel time between home\nand primary workplace",
  "Job Type",
  "Home Ownership"
)

plot_list <- list()

for (i in 1:length(categories)) {
  data_plot <- data %>%
    select(
      !!sym(categories[i]), final_weights
    ) %>%
    group_by(
      !!sym(categories[i])
    ) %>%
    reframe(
      n = n(),
      nw = sum(final_weights)
    ) %>%
    pivot_longer(
      cols = c(n, nw),
      names_to = "type",
      values_to = "n"
    ) %>%
    group_by(
      type
    ) %>%
    mutate(
      ratio = round(n / sum(n) * 100, 1) %>% paste0("%")
    )
  p <- data_plot %>%
    ggplot() +
    geom_bar(
      aes(
        x = !!sym(categories[i]),
        y = n,
        fill = type
      ),
      stat = "identity",
      position = position_dodge2(width = 1, padding = 0)
    ) +
    geom_label(
      aes(
        x = !!sym(categories[i]),
        y = n / 2,
        label =  ratio
      ),
      size = 3,
      position = position_dodge2(width = 1, padding = 0)
    ) +
    labs(
      x = labels[i],
      y = "Count"
    ) +
    scale_x_continuous(
      breaks = get_dictionary_by_target(data, categories[i]) %>% unlist(),
      labels = get_dictionary_by_target(data, categories[i]) %>% names()
    ) +
    theme_bw() +
    theme(
      axis.text.x = element_text(
        angle = 7.5,
        hjust = 0.9
      ),
      legend.position = "none"
    )

  if (i == 1) {
    p <- p + geom_label(
      data = data.frame(1),
      x = 3.75,
      y = 400,
      label = "Weighted",
      color = "#122566",
      fill = "#ffffff",
      hjust = 0.5,
      vjust = 1
    ) + geom_label(
      data = data.frame(1),
      x = 1.25,
      y = 400,
      label = "Unweighted",
      color = "#8d1111",
      fill = "#ffffff",
      hjust = 0.5,
      vjust = 1
    )
  }

  plot_list <- c(plot_list, list(p))
}

plot_grid(plotlist = plot_list) %>%
  ggsave(
    filename = file.path(
      "output",
      "ds",
      "categorical_distribution.png"
    ),
    width = 12.8,
    height = 7.2,
    dpi = 300,
    units = "in"
  )
