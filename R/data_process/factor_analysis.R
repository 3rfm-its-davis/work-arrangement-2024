f <- fa(
  data %>%
    select(
      starts_with("C14_")
    ) %>%
    mutate_all(~ replace_na(., 3)),
  3,
  rotate = "cluster",
  scores = "tenBerge"
)

labels <- c(
  "I perform better when I interact with colleagues in person on site.",
  "Working from home makes me less disciplined/self-controlled.",
  "Working from home helps me spend more meaningful time with other members in my household.",
  "I experience substantial gains in efficiency when working from home.",
  "We should raise taxes to provide health insurance for all.",
  "Working from home helps me save large costs on commuting and parking.",
  "I am satisfied with the online shopping and delivery options available to me.",
  "The quality of interaction during online meetings is disappointing.",
  "Working from home is not practical for me (e.g., due to lack of office devices, distractions from family members).",
  "I can efficiently replace some of my business trips with virtual meetings.",
  "Videoconferencing enables me to better maintain meaningful contact with friends and family outside of my household.",
  "I enjoy not always/everyday having to physically commute to work.",
  "I live on a tighter budget now than before the pandemic.",
  "I prefer to shop in a store rather than online."
)

f$loadings[] %>%
  as_tibble() %>%
  mutate(statement = labels) %>%
  select(statement, everything()) %>%
  write_csv(file.path("output", "factor_analysis", "loadings.csv"))

data <- data %>%
  left_join(
    f$scores %>%
      as_tibble() %>%
      rename_at(
        vars(starts_with("MR")),
        ~ {
          paste0("factor_", .x %>% str_remove("MR"))
        }
      ) %>%
      mutate(
        row_index = data$row_index
      )
  )
