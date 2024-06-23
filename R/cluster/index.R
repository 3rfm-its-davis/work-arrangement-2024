hc <- hclust(
  data %>%
    select(
      share_main_1,
      share_main_2,
      share_main_3
    ) %>%
    dist()
)

memb <- cutree(hc, k = 6)

png(
  filename = file.path(
    "output",
    "cluster",
    "dendrogram.png"
  ),
  width = 8,
  height = 4.5,
  units = "in",
  res = 300
)
plot(
  as.dendrogram(hc),
  leaflab = "none",
  xlab = "Responses",
  ylab = "Height"
)
dev.off()

png(
  filename = file.path(
    "output",
    "cluster",
    "dendrogram_2.png"
  ),
  width = 8,
  height = 4.5,
  units = "in",
  res = 300
)
plot(
  as.dendrogram(hc),
  leaflab = "none",
  xlab = "Responses",
  ylab = "Height",
  ylim = c(0.5, 1.5)
)
dev.off()


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

center_table <- km$centers[reverse_mapper[1:6], ] %>%
  round(3) %>%
  tibble() %>%
  mutate(
    size = km$size[reverse_mapper[1:6]],
    share = km$size[reverse_mapper[1:6]] / nrow(data)
  )

center_table_rows <- c("Primary", "Temporary", "Home", "Primary_Home", "Temporary_Home", "All_Mixed")
center_table_cols <- c("Primary", "Temporary", "Home", "Size")

rownames(center_table) <- center_table_rows
colnames(center_table) <- center_table_cols

center_table %>%
  write.csv(
    file.path(
      "output",
      "mnl",
      "center_table.csv"
    )
  )