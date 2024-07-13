data <- read_sav(
  file.path(
    "..",
    "Dataset",
    "covid19-2023-merged-processed.sav"
  )
) %>%
  select(
    row_index,
    age,
    gender,
    income,
    kids,
    education12,
    impedance,
    jobtype12,
    neighborhood,
    homeownership,
    starts_with("factor_a_"),
    cluster
  ) %>%
  mutate_if(
    is.numeric,
    as.numeric
  ) %>%
  mutate_at(
    vars(starts_with("att_")),
    function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  )

for (i in 1:5) {
  coefs <- lm(
    as.formula(
      paste0(
        "factor_a_", i, " ~ (age == 1) +
      (age == 3) +
      (gender == 1) +
      (income == 1) +
      (income == 3) +
      (income == 4) +
      (kids == 1) +
      (gender == 1 & kids == 1) +
      (education12 == 2) +
      (education12 == 3) +
      (impedance == 2) +
      (impedance == 3) +
      (impedance == 4) +
      is.na(impedance) +
      (jobtype12 == 2) +
      (jobtype12 == 3) +
      (neighborhood == 2) +
      (neighborhood == 3) +
      (homeownership == 1)"
      )
    ),
    data = data
  ) %>%
    summary() %>%
    .$coefficients

  # extract significant variables by p=0.05
  rnames <- rownames(coefs) %>% str_replace("TRUE", "")
  coefs %>%
    as_tibble() %>%
    rownames_to_column("variable") %>%
    mutate(variable = rnames) %>%
    filter(`Pr(>|t|)` < 0.05) %>%
    select(variable, Estimate) %>%
    print()
}
