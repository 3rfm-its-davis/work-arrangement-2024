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

data <- data %>%
  mutate(cluster = km$cluster) %>%
  mutate(
    cluster = case_when(
      cluster == 1 ~ 1,
      cluster == 2 ~ 4,
      cluster == 3 ~ 2,
      cluster == 4 ~ 6,
      cluster == 5 ~ 3,
      cluster == 6 ~ 5
    )
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

center_table <- km$centers %>%
  round(3)

center_table_rows <- c("Primary", "Temporary", "Home", "Primary_Home", "Temporary_Home", "All_Mixed")
center_table_cols <- c("Primary", "Temporary", "Home")

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
