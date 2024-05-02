library(tidyverse)
library(haven)
library(psych)
library(apollo)
library(flextable)
library(R.utils)
library(httpgd)
library(cowplot)

source(file.path("data_process", "index.R"))

source(file.path("utils", "dictionary_export", "index.R"))
source(file.path("utils", "data_export", "index.R"))

# source(file.path("mdcev", "model_10", "index.R"))
# source(file.path("mdcev", "model_11", "index.R"))
source(file.path("mdcev", "model_12", "index.R"))
source(file.path("mdcev", "model_13", "index.R"))

source(file.path("utils", "output_conversion", "index.R"))

data_dsb <- read_sav(
  file.path(
    "..",
    "Dataset",
    "covid19-2023-merged-dsb.sav"
  )
)

data %>%
  inner_join(
    data_dsb,
    by = "row_index"
  ) %>%
  mutate(
    prim =
      DaysPrim == days_place_1,
    temp =
      DaysTempEtc == days_place_2,
    home =
      DaysHomeOnly == days_place_3
  ) %>%
  select(
    home
  ) %>%
  table()
