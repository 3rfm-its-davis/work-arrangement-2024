names <- tibble(
  files = list.files(
    file.path("output", "mnl")
  )
) %>%
  filter(
    str_detect(files, "model.rds") &
      !str_detect(files, "OLD")
  ) %>%
  pull(files)

for (i in 1:length(names)) {
  model <- readRDS(
    file.path("output", "mnl", names[i])
  )

  base_table <- tibble(
    label = names(model$estimate),
    estimate = model$estimate,
    p = apollo_modelOutput(model, modelOutput_settings = list(
      printPVal = TRUE
    ))[, 4],
  ) %>%
    mutate(
      # add signs for significance
      estimate = case_when(
        abs(estimate) < 0.01 ~ format(estimate, scientific = TRUE, digits = 3),
        TRUE ~ round(estimate, 2) %>% format(nsmall = 2)
      ) %>%
        paste0(
          .,
          case_when(
            p < 0.01 ~ " **",
            p < 0.05 ~ " *",
            TRUE ~ ""
          )
        )
    ) %>%
    select(-p) %>%
    separate_wider_delim(
      cols = label,
      names = c("type", "choice", "category", "value"),
      delim = "_",
      too_few = "align_start",
      too_many = "merge"
    ) %>%
    mutate(
      type = str_replace_all(
        type,
        main_label_map
      )
    )

  table_asc <- base_table %>%
    filter(type == "Alternative-specific constant") %>%
    pivot_wider(
      names_from = choice,
      values_from = estimate
    ) %>%
    rename_all(
      ~ str_replace_all(., header_label_map)
    )

  table_b <- base_table %>%
    filter(type == "Coefficient") %>%
    spread(
      choice,
      estimate
    ) %>%
    arrange(
      category %>%
        factor(
          levels =
            c(
              "ASC",
              "age",
              "gender",
              "kids",
              "agegender",
              "agekids",
              "genderkids",
              "income",
              "education",
              "jobtype12",
              "impedance",
              "neighborhood",
              "impneighbor",
              "homeownership",
              "factor"
            )
        )
    ) %>%
    mutate(
      value = case_when(
        str_detect(category, "agekids") ~ str_replace_all(value, agekids_label_map),
        str_detect(category, "genderkids") ~ str_replace_all(value, genderkids_label_map),
        str_detect(category, "agegender") ~ str_replace_all(value, agegender_label_map),
        str_detect(category, "age") ~ str_replace_all(value, age_label_map),
        str_detect(category, "gender") ~ str_replace_all(value, gender_label_map),
        str_detect(category, "kids") ~ str_replace_all(value, kids_label_map),
        str_detect(category, "income") ~ str_replace_all(value, income_label_map),
        str_detect(category, "capability") ~ str_replace_all(value, occupation_label_map),
        str_detect(category, "jobtype12") ~ str_replace_all(value, jobtype12_label_map),
        str_detect(category, "jobtype") ~ str_replace_all(value, jobtype_label_map),
        str_detect(category, "flexibility") ~ str_replace_all(value, flexibility_label_map),
        str_detect(category, "neighborhood") ~ str_replace_all(value, neighborhood_label_map),
        str_detect(category, "impedance") ~ str_replace_all(value, travel_label_map),
        str_detect(category, "factor") ~ str_replace_all(value, factor_label_map),
        str_detect(category, "education") ~ str_replace_all(value, education_label_map),
        str_detect(category, "commute") ~ str_replace_all(value, commute_label_map),
        str_detect(category, "employment") ~ str_replace_all(value, employment_label_map),
        str_detect(category, "impneighbor") ~ str_replace_all(value, impneighbor_label_map),
        str_detect(category, "impgender") ~ str_replace_all(value, impgender_label_map),
        str_detect(category, "homeownership") ~ str_replace_all(value, homeownership_label_map),
        TRUE ~ ""
      ),
      category = str_replace_all(category, sub_label_map)
    ) %>%
    rename_all(
      ~ str_replace_all(., header_label_map)
    )

  flextable(
    bind_rows(
      table_asc,
      table_b
    )
  ) %>%
    add_header_row(
      values = c(
        "BIC",
        model$BIC
      ),
      colwidths = c(2, 6),
    ) %>%
    add_header_row(
      values = c(
        "AIC",
        model$AIC
      ),
      colwidths = c(2, 6),
    ) %>%
    add_header_row(
      values = c(
        "LL(Final)",
        model$finalLL
      ),
      colwidths = c(2, 6),
    ) %>%
    add_header_row(
      values = c(
        "Paramters",
        model$numParams
      ),
      colwidths = c(2, 6),
    ) %>%
    add_header_row(
      values = c(
        "Sample size",
        model$nObsTot
      ),
      colwidths = c(2, 6),
    ) %>%
    add_header_row(
      values = c(
        "Singular Convergence",
        all(is.na(model$se))
      ),
      colwidths = c(2, 6),
    ) %>%
    merge_v(j = 1:2) %>%
    set_table_properties(layout = "autofit") %>%
    hline() %>%
    vline() %>%
    save_as_html(
      path = file.path(
        "output",
        "mnl",
        str_replace(names[i], "model.rds", "estimates.html")
      )
    )
}
