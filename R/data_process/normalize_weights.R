data <- data %>%
  mutate(
    final_weights = final_weights / sum(final_weights) * nrow(data)
  )
