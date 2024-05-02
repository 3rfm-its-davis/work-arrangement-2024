data <- data %>%
  filter(B8 != 0)
print(nrow(data))

data <- data %>%
  filter(
    (
      C1_1_1 == 1 |
        C1_2_1 == 1 |
        C1_3_1 == 1 |
        C1_4_1 == 1
    )
  )
print(nrow(data))

data <- data %>%
  filter(!is.na(final_weights))
print(nrow(data))

data <- data %>%
  filter(!is.na(C3_1))
print(nrow(data))

data <- data %>%
  filter(flag_discrepancy_work_hours == 0)
print(nrow(data))

data <- data %>%
  filter(flag_high_low_workplace == 0)
print(nrow(data))

data <- data %>%
  filter(flag_too_many_work_hour_by_matrix == 0)
print(nrow(data))

data <- data %>%
  filter(
    C5_2a != 0
  )
print(nrow(data))
