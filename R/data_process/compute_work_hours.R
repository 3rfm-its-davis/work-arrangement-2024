data <- data %>%
  select(
    row_index,
    matches("^C13b_\\d{1,2}_\\d{1,2}$")
  ) %>%
  gather(
    key = "key",
    value = "value",
    matches("^C13b_\\d{1,2}_\\d{1,2}$"),
  ) %>%
  mutate(
    day = str_replace(
      key,
      "C13b_(\\d{1,2})_\\d{1,2}",
      "\\1"
    ) %>% as.numeric(),
    time = str_extract(key, "\\d{1,2}$") %>% as.numeric(),
    period = case_when(
      time %in% 2:3 ~ 1,
      time %in% 4:6 ~ 2,
      time %in% 7:8 ~ 3,
      T ~ 4
    )
  ) %>%
  mutate(
    binary = intToBin(value),
    place_1 = (binary %>% substr(1, 1) %>% as.numeric()) /
      (binary %>% str_count("1")),
    place_2 = (binary %>% substr(2, 2) %>% as.numeric()) /
      (binary %>% str_count("1")),
    place_3 = (binary %>% substr(3, 3) %>% as.numeric()) /
      (binary %>% str_count("1")),
    place_4 = pmin(value, 1),
  ) %>%
  mutate_all(
    ~ replace_na(., 0)
  ) %>%
  mutate(
    across(
      starts_with("place"),
      ~ case_when(
        str_detect(key, "_1$") ~ . * 6,
        TRUE ~ . * 2
      )
    )
  ) %>%
  group_by(row_index, day, period) %>%
  reframe(
    place_1 = sum(place_1, na.rm = TRUE),
    place_2 = sum(place_2, na.rm = TRUE),
    place_3 = sum(place_3, na.rm = TRUE),
    place_4 = sum(place_4, na.rm = TRUE)
  ) %>%
  gather(
    key = "place",
    value = "hours_period",
    starts_with("place"),
  ) %>%
  mutate(
    place = str_replace(place, "place_", "") %>% as.numeric()
  ) %>%
  group_by(row_index, day, place) %>%
  mutate(
    hours_day = sum(hours_period, na.rm = TRUE)
  ) %>%
  group_by(row_index, place) %>%
  mutate(
    hours_total = sum(hours_period, na.rm = TRUE)
  ) %>%
  gather(
    key = "tag",
    value = "hours_naive",
    starts_with("hours")
  ) %>%
  mutate(
    tag = case_when(
      tag == "hours_total" ~ "total",
      tag == "hours_day" ~ paste("day", day, sep = "_"),
      TRUE ~ paste("day", day, "period", period, sep = "_")
    ),
    tag = case_when(
      place == 4 ~ tag,
      T ~ paste(tag, "place", place, sep = "_")
    )
  ) %>%
  ungroup() %>%
  select(-day, -period, -place) %>%
  distinct() %>%
  pivot_wider(
    names_from = tag,
    values_from = hours_naive,
    names_prefix = "hours_"
  ) %>%
  left_join(
    data
  ) %>%
  mutate(
    naive_total = rowSums(select(., starts_with("C13a_")), na.rm = TRUE),
  )
