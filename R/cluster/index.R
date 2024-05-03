hc <- hclust(
  data %>%
    select(
      row_index,
      age,
      gender,
      income,
      kids,
      education12,
      impedance,
      jobtype12,
      commute,
      neighborhood,
      homeownership,
      factor_1,
      factor_2,
      factor_3,
    ) %>%
    dist()
)

memb <- cutree(hc, k = 6)

plot(hc)

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
    cluster =
      rows[cluster]
  )

center_table <- km$centers %>%
  round(3)

center_table_rows <- c("Primary", "Primary_Home", "Temporary", "All_Mixed", "Home", "Temporary_Home")
center_table_cols <- c("Primary", "Temporary", "Home")

rownames(center_table) <- center_table_rows
colnames(center_table) <- center_table_cols

center_table %>%
  write.csv(
    file.path(
      "output",
      "mnl",
      "center_table.csv"
    )
  )
