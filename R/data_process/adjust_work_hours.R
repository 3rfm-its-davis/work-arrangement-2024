data <- data %>%
  mutate(
    ratio_total = case_when(hours_total == 0 ~ 0, T ~ (
      naive_total / hours_total
    )),
    ratio_day_1 = case_when(hours_day_1 == 0 ~ 0, T ~ C13a_1_4 / hours_day_1),
    ratio_day_2 = case_when(hours_day_2 == 0 ~ 0, T ~ C13a_2_4 / hours_day_2),
    ratio_day_3 = case_when(hours_day_3 == 0 ~ 0, T ~ C13a_3_4 / hours_day_3),
    ratio_day_4 = case_when(hours_day_4 == 0 ~ 0, T ~ C13a_4_4 / hours_day_4),
    ratio_day_5 = case_when(hours_day_5 == 0 ~ 0, T ~ C13a_5_4 / hours_day_5),
    ratio_day_6 = case_when(hours_day_6 == 0 ~ 0, T ~ C13a_6_4 / hours_day_6),
    ratio_day_7 = case_when(hours_day_7 == 0 ~ 0, T ~ C13a_7_4 / hours_day_7),
    diff_day_1 = C13a_1_4 - hours_day_1,
    diff_day_2 = C13a_2_4 - hours_day_2,
    diff_day_3 = C13a_3_4 - hours_day_3,
    diff_day_4 = C13a_4_4 - hours_day_4,
    diff_day_5 = C13a_5_4 - hours_day_5,
    diff_day_6 = C13a_6_4 - hours_day_6,
    diff_day_7 = C13a_7_4 - hours_day_7,
  ) %>%
  filter(ratio_total >= 0.75 & ratio_total <= 1.33) %>%
  filter(
    ((ratio_day_1 == 0 & abs(diff_day_1) <= 2) | (ratio_day_1 >= 0.5 & ratio_day_1 <= 2)) &
      ((ratio_day_2 == 0 & abs(diff_day_2) <= 2) | (ratio_day_2 >= 0.5 & ratio_day_2 <= 2)) &
      ((ratio_day_3 == 0 & abs(diff_day_3) <= 2) | (ratio_day_3 >= 0.5 & ratio_day_3 <= 2)) &
      ((ratio_day_4 == 0 & abs(diff_day_4) <= 2) | (ratio_day_4 >= 0.5 & ratio_day_4 <= 2)) &
      ((ratio_day_5 == 0 & abs(diff_day_5) <= 2) | (ratio_day_5 >= 0.5 & ratio_day_5 <= 2)) &
      ((ratio_day_6 == 0 & abs(diff_day_6) <= 2) | (ratio_day_6 >= 0.5 & ratio_day_6 <= 2)) &
      ((ratio_day_7 == 0 & abs(diff_day_7) <= 2) | (ratio_day_7 >= 0.5 & ratio_day_7 <= 2))
  ) %>%
  mutate(
    hours_total_place_1 = hours_total_place_1 * ratio_total,
    hours_total_place_2 = hours_total_place_2 * ratio_total,
    hours_total_place_3 = hours_total_place_3 * ratio_total,
    hours_total = hours_total * ratio_total
  )
print(nrow(data))

for (i in 1:7) {
  for (j in 1:4) {
    data <- data %>%
      mutate(
        !!paste("hours_day_", i, "_period_", j, sep = "") :=
          !!sym(paste("hours_day_", i, "_period_", j, sep = "")) *
            !!sym(paste("ratio_day_", i, sep = "")),
        !!paste("hours_day_", i, "_period_", j, "_place_1", sep = "") :=
          !!sym(paste("hours_day_", i, "_period_", j, "_place_1", sep = "")) *
            !!sym(paste("ratio_day_", i, sep = "")),
        !!paste("hours_day_", i, "_period_", j, "_place_2", sep = "") :=
          !!sym(paste("hours_day_", i, "_period_", j, "_place_2", sep = "")) *
            !!sym(paste("ratio_day_", i, sep = "")),
        !!paste("hours_day_", i, "_period_", j, "_place_3", sep = "") :=
          !!sym(paste("hours_day_", i, "_period_", j, "_place_3", sep = "")) *
            !!sym(paste("ratio_day_", i, sep = "")),
      )
  }
  data <- data %>%
    mutate(
      !!paste("hours_day_", i, sep = "") :=
        !!sym(paste("hours_day_", i, sep = "")) *
          !!sym(paste("ratio_day_", i, sep = ""))
    )
}

data <- data %>%
  filter(
    !if_any(
      matches("hours_day_\\d"),
      ~ . > 16
    )
  )
print(nrow(data))
