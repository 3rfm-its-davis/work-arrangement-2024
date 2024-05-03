set.seed(100)

km <- kmeans(
  data %>%
    select(
      days_main_1,
      days_main_2,
      days_main_3
    ) %>%
    mutate(
      days_total = days_main_1 + days_main_2 + days_main_3,
      days_main_1 = days_main_1 / days_total,
      days_main_2 = days_main_2 / days_total,
      days_main_3 = days_main_3 / days_total
    ) %>%
    select(-days_total),
  6,
  iter.max = 1000
)

data <- data %>%
  mutate(cluster = km$cluster) %>%
  mutate(
    cluster = labelled(
      cluster,
      c(
        "Primary" = 1,
        "Primary_Home" = 2,
        "Temporary" = 3,
        "All_Mixed" = 4,
        "Home" = 5,
        "Temporary_Home" = 6
      )
    )
  )
