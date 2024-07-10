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
    ret_svc_density = ret_density + svc_density
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
