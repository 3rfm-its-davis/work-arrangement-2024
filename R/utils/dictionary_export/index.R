source("utils/dictionary_export/get_dictionary_by_target.R")

data <- data %>%
  mutate(
    for_crosstab = 1 %>%
      labelled(label = "For Crosstab", labels = c("Count" = 1))
  ) %>%
  select(
    for_crosstab,
    everything()
  )

names <- names(data)

dictionary <- list()

for (i in 1:length(names)) {
  class <- class(data %>% pull(names[i]))[1]
  question <- data %>%
    pull(names[[i]]) %>%
    attr("label")

  if (class == "haven_labelled") {
    dictionary[[names[i]]] <-
      list(
        type = "haven_labelled",
        question = question,
        labels = get_dictionary_by_target(data, names[i])
      )
  } else {
    dictionary[[names[i]]] <-
      list(
        type = data %>%
          pull(names[[i]]) %>%
          class() %>% paste0(collapse = ","),
        question = question
      )
  }
}

dictionary %>%
  jsonlite::write_json(
    path = file.path(
      "..",
      "ts",
      "src",
      "data",
      "dictionary.json"
    ),
    pretty = TRUE,
    auto_unbox = TRUE,
    null = "null"
  )
