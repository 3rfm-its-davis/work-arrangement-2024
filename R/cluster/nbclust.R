data %>%
  select(
    share_main_1,
    share_main_2,
    share_main_3
  ) %>%
  NbClust(
    distance = "euclidean",
    min.nc = 3,
    max.nc = 7,
    method = "kmeans",
    index = "all"
  )
