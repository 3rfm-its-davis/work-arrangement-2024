data <- data %>%
  select(
    row_index,
    matches("hours_day_\\d_place")
  ) %>%
  gather(
    key = "key",
    value = "value",
    matches("hours_day_\\d_place"),
  ) %>%
  mutate(
    day = str_split(key, "_") %>% map_chr(3) %>% as.numeric(),
    place = str_split(key, "_") %>% map_chr(5) %>% as.numeric(),
    value = (value > 0) * 1
  ) %>%
  select(-key) %>%
  pivot_wider(
    names_from = place,
    values_from = value,
    names_prefix = "days_place_"
  ) %>%
  mutate(
    worked_at = case_when(
      days_place_1 == 1 ~ 3,
      days_place_2 == 1 ~ 2,
      days_place_3 == 1 ~ 1,
      TRUE ~ 0
    )
  ) %>%
  filter(
    worked_at > 0
  ) %>%
  group_by(row_index) %>%
  reframe(
    days_main_1 = sum(worked_at == 3, na.rm = TRUE) %>% as.numeric(),
    days_main_2 = sum(worked_at == 2, na.rm = TRUE) %>% as.numeric(),
    days_main_3 = sum(worked_at == 1, na.rm = TRUE) %>% as.numeric(),
    days_place_1 = sum(days_place_1, na.rm = TRUE) %>% as.numeric(),
    days_place_2 = sum(days_place_2, na.rm = TRUE) %>% as.numeric(),
    days_place_3 = sum(days_place_3, na.rm = TRUE) %>% as.numeric(),
    days_total = days_main_1 + days_main_2 + days_main_3
  ) %>%
  left_join(
    data,
    by = "row_index"
  )
