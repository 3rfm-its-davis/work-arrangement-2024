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
  filter(!is.na(C3_1))
print(nrow(data))

data <- data %>%
  filter(
    C5_2a != 0
  )
print(nrow(data))

data <- data %>%
  filter(
    C9_a_1 <= 180
  )
print(nrow(data))
