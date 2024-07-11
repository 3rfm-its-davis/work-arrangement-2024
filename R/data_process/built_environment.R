geocoding <- read_csv(
  file.path(
    "..",
    "Dataset",
    "geocoding.csv"
  )
) %>%
  select(
    ResponseId,
    pop_density = D1B,
    ret_density = D1C5_RET,
    svc_density = D1C5_SVC,
    transit_freq_index = D4E
  ) %>%
  mutate_if(
    is.numeric,
    ~ case_when(
      . == -99999 ~ 0,
      TRUE ~ .
    )
  ) %>%
  mutate(
    pop_density = log(pop_density + 0.0001),
    ret_svc_density = log(ret_density + svc_density + 0.0001),
    transit_freq_index = log(transit_freq_index + 0.0001)
  ) %>%
  select(
    -ret_density,
    -svc_density
  )

data <- data %>%
  left_join(
    geocoding,
    by = "ResponseId"
  )
