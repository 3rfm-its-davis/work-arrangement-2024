for (i in 1:5) {
  factor_lm_model <- lm(
    paste0("factor_a_", i, " ~ age +
      gender +
      income +
      kids +
      education12 +
      impedance +
      jobtype12 +
      neighborhood +
      homeownership"),
    data = data
  )

  # get the variable name that are significant at 0.05 level
  p <- summary(factor_lm_model)$coefficients %>%
    .[, 4]
  n <- names(p)

  print(i)

  tibble(
    variable = n,
    p_value = p
  ) %>%
    filter(p_value < 0.05) %>%
    .[-1, ] %>%
    pull(variable) %>%
    print()
}
