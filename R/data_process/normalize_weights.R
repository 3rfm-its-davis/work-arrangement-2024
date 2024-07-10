data <- data %>%
  left_join(
    read_sav(
      file.path(
        "..",
        "Dataset",
        "covid19-2023-weight.sav"
      )
    ),
    by = "ResponseId"
  ) %>%
  mutate(
    final_weights = final_weights / sum(final_weights) * nrow(data)
  )
