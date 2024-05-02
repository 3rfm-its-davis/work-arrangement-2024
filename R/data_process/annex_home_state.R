home_state <- read_csv(
  file.path(
    "..",
    "Dataset",
    "home_state.csv"
  ),
  show_col_types = FALSE
)
print(nrow(home_state))

data <- raw_data %>%
  left_join(
    home_state,
    "row_index"
  ) %>%
  filter(
    Home_Google_state == "CA"
  )
print(nrow(data))
