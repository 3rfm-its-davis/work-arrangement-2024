is_done <- FALSE

labels <- c(
  "I like trying things that are new and different.",
  "My schedule makes it hard or impossible for me to use public transportation.",
  "I like walking.",
  "I definitely want to own a car.",
  "Getting regular exercise is very important to me.",
  "We should raise the cost of driving to reduce the negative impacts of driving on the environment.",
  "I like driving a car.",
  "I always think about ways in which I can reduce my impact on the environment.",
  "Traffic congestion is a major problem in the region where I live.",
  "I am fine with not owning a car, as long as I can use/rent one any time I need it.",
  "I like riding a bike.",
  "I prefer to live in a spacious home, even if it is farther from public transportation and many places I go.",
  "To me, a car is just a way to get from place to place.",
  "I am against giving more space to pedestrians and cyclists on the road network if it implies less space for cars.",
  "I prefer to be a driver rather than a passenger.",
  "Most of the time, I have no reasonable alternative to driving.",
  "I like the idea of public transit as a means of transportation for me.",
  "I like to be among the first people to have the latest technology.",
  "I make efforts to adjust my schedule (e.g., leave earlier/later than needed) to avoid traffic congestion.",
  "I am generally satisfied with my transportation options.",
  "I like the idea of having stores, restaurants, and offices mixed among the homes in my neighborhood.",
  "Having Wi-Fi and/or good internet access on my mobile phone everywhere I go is essential to me.",
  "I am willing to pay more money to have a quicker trip.",
  "I'll stretch my budget to buy something new and exciting.",
  "We should raise the cost of driving to provide funding for better public transportation.",
  "If I felt protected from car traffic, I would ride a bicycle more often.",
  "I am less likely to drive if parking is difficult or expensive.",
  "I am generally satisfied with my life."
)

rows <- 1:28

while (!is_done) {
  factor <- fa(
    data %>%
      select(
        starts_with("A_"),
        -ends_with("_aa"),
        -ends_with("_i"),
      ) %>%
      select(all_of(rows)) %>%
      mutate_all(~ replace_na(., 3)),
    5,
    rotate = "cluster",
    scores = "tenBerge"
  )

  print(
    factor$Vaccounted %>%
      round(3) %>%
      .[1, ]
  )

  check_significance <- factor$loadings[] %>%
    tibble() %>%
    rowwise() %>%
    summarize(
      n = any(abs(.) > 0.3)
    ) %>%
    deframe()


  if (all(check_significance)) {
    is_done <- T
  }

  rows <- rows[check_significance %>% which()]
}

factor$loadings[] %>%
  as_tibble() %>%
  mutate(statement = labels[rows]) %>%
  select(statement, everything()) %>%
  write_csv(file.path("output", "factor_analysis", "loadings_a.csv"))

# 5 factor names
factor_a_names <- c(
  "pro-driver",
  "pro-environment",
  "pro-active-mode",
  "tech-savvy",
  "busy-driver"
)

data <- data %>%
  left_join(
    factor$scores %>%
      as_tibble() %>%
      rename_at(
        vars(starts_with("MR")),
        ~ {
          paste0("factor_a_", .x %>% str_remove("MR"))
        }
      ) %>%
      mutate(
        row_index = data$row_index
      )
  )
