geocoding <- read_csv(
  file.path(
    "..",
    "Dataset",
    "geocoding.csv"
  )
) %>%
  select(
    ResponseId,
    home_address = Home_full_,
    work_address = Work_full_,
    pop_density = D1B,
    ret_density = D1C5_RET,
    svc_density = D1C5_SVC,
    transit_freq_index = D4E
  ) %>%
  mutate(
    same_home_work = home_address == work_address
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
