for (i in 1:7) {
  for (j in 1:10) {
    index <- data %>%
      select(
        matches(
          paste("C13b", i, j, "\\d", sep = "_")
        )
      ) %>%
      mutate_all(~ pmax(., 0, na.rm = T)) %>%
      sweep(2, c(4, 2, 1), "*") %>%
      rowSums(na.rm = TRUE)
    data <- data %>%
      mutate(
        !!paste("C13b", i, j, sep = "_") :=
          index
      )
  }
}
