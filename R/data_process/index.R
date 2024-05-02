raw_data <- read_sav(
  file.path(
    "..",
    "Dataset",
    "covid19-2023-merged.sav"
  )
)
print(nrow(raw_data))

data <- raw_data %>%
  filter(
    out == 0
  )
print(nrow(data))

source(file.path("data_process", "annex_home_state.R"))
source(file.path("data_process", "basic_filter.R"))
source(file.path("data_process", "recode_work_arrangement_matrices.R"))
source(file.path("data_process", "compute_work_hours.R"))
source(file.path("data_process", "compute_work_days.R"))
source(file.path("ds", "scatterplot_work_hour.R"))
source(file.path("data_process", "adjust_work_hours.R"))
source(file.path("data_process", "factor_analysis.R"))
source(file.path("data_process", "recoding.R"))
source(file.path("data_process", "normalize_weights.R"))

write_sav(
  data,
  file.path(
    "..",
    "Dataset",
    "covid19-2023-merged-processed.sav"
  )
)
