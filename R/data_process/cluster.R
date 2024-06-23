set.seed(100)

km <- kmeans(
  data %>%
    select(
      share_main_1,
      share_main_2,
      share_main_3
    ),
  6,
  iter.max = 1000
)

forward_mapper <- c(
  2,
  4,
  1,
  6,
  3,
  5
)

reverse_mapper <- c(
  3,
  1,
  5,
  2,
  6,
  4
)

data <- data %>%
  mutate(cluster = km$cluster) %>%
  mutate(
    cluster = forward_mapper[cluster]
  ) %>%
  mutate(
    cluster = labelled(
      cluster,
      c(
        "Primary" = 1,
        "Temporary" = 2,
        "Home" = 3,
        "Primary_Home" = 4,
        "Temporary_Home" = 5,
        "All_Mixed" = 6
      )
    )
  )
