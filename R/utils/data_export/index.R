data %>%
  mutate_all(~ {
    if (is.character(.)) {
      .
    } else {
      as.numeric(.)
    }
  }) %>%
  select(
    -c(
      "C10_2",
      "C10_4",
      "C10_5",
      "C10_6",
      "C10_7",
      "C10_1_1",
      "D7_2",
      "D7_4",
      "D7_5",
      "D7_6",
      "D7_7",
      "D7_1_1",
      "EN3"
    )
  ) %>%
  jsonlite::write_json(
    path = file.path(
      "..",
      "ts",
      "src",
      "data",
      "data.json"
    ),
    pretty = TRUE,
    auto_unbox = TRUE
  )
