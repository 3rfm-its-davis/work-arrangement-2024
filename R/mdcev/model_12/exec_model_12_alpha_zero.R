exec_model_12_alpha_zero <- function(range = NULL, only_mix = FALSE) {
  database <- get("data", envir = globalenv()) %>%
    select(
      row_index,
      age,
      gender,
      income,
      kids,
      education12,
      impedance,
      jobtype12,
      commute,
      neighborhood,
      homeownership,
      factor_1,
      factor_2,
      factor_3,
      matches("hours_total")
    ) %>%
    mutate_all(as.numeric)

  model_name <- "model_12_alpha_zero"

  if (!is.null(range)) {
    database <- database %>%
      filter(hours_total >= range[1] & hours_total < range[2])
    model_name <- paste0(model_name, "_", range[1], "_", range[2])
  }

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName       = model_name,
    modelDescr      = model_name,
    indivID         = "row_index",
    outputDirectory = file.path("output", "mdcev", "model_12")
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    gamma_prim = 1,
    gamma_temp = 1,
    gamma_home = 1,
    delta_temp = 0,
    delta_home = 0,
    delta_temp_age_18_29 = 0,
    delta_home_age_18_29 = 0,
    delta_temp_age_45_64 = 0,
    delta_home_age_45_64 = 0,
    delta_temp_age_65plus = 0,
    delta_home_age_65plus = 0,
    delta_temp_gender_women = 0,
    delta_home_gender_women = 0,
    delta_temp_kids_kids = 0,
    delta_home_kids_kids = 0,
    delta_temp_genderkids_women_kids = 0,
    delta_home_genderkids_women_kids = 0,
    delta_temp_income_50minus = 0,
    delta_home_income_50minus = 0,
    delta_temp_income_100_149 = 0,
    delta_home_income_100_149 = 0,
    delta_temp_income_150plus = 0,
    delta_home_income_150plus = 0,
    delta_temp_education_highschool = 0,
    delta_home_education_highschool = 0,
    delta_temp_education_graduate = 0,
    delta_home_education_graduate = 0,
    delta_temp_impedance_20_39 = 0,
    delta_home_impedance_20_39 = 0,
    delta_temp_impedance_40_59 = 0,
    delta_home_impedance_40_59 = 0,
    delta_temp_impedance_60plus = 0,
    delta_home_impedance_60plus = 0,
    delta_temp_neighborhood_suburban = 0,
    delta_home_neighborhood_suburban = 0,
    delta_temp_neighborhood_town = 0,
    delta_home_neighborhood_town = 0,
    delta_temp_impneighbor_20_39_suburban = 0,
    delta_home_impneighbor_20_39_suburban = 0,
    delta_temp_impneighbor_40_59_suburban = 0,
    delta_home_impneighbor_40_59_suburban = 0,
    delta_temp_impneighbor_60plus_suburban = 0,
    delta_home_impneighbor_60plus_suburban = 0,
    delta_temp_impneighbor_20_39_town = 0,
    delta_home_impneighbor_20_39_town = 0,
    delta_temp_impneighbor_40_59_town = 0,
    delta_home_impneighbor_40_59_town = 0,
    delta_temp_impneighbor_60plus_town = 0,
    delta_home_impneighbor_60plus_town = 0,
    delta_temp_jobtype12_professional = 0,
    delta_home_jobtype12_professional = 0,
    delta_temp_jobtype12_administrative = 0,
    delta_home_jobtype12_administrative = 0,
    delta_temp_homeownership_nonown = 0,
    delta_home_homeownership_nonown = 0,
    delta_temp_factor_score_1 = 0,
    delta_home_factor_score_1 = 0,
    delta_temp_factor_score_2 = 0,
    delta_home_factor_score_2 = 0,
    delta_temp_factor_score_3 = 0,
    delta_home_factor_score_3 = 0
  )

  assign("apollo_beta", apollo_beta, envir = globalenv())

  apollo_fixed <- c()

  assign("apollo_fixed", apollo_fixed, envir = globalenv())

  apollo_inputs <- apollo_validateInputs()

  assign("apollo_inputs", apollo_inputs, envir = globalenv())

  apollo_probabilities <-
    function(apollo_beta, apollo_inputs, functionality = "estimate") {
      apollo_attach(apollo_beta, apollo_inputs)
      on.exit(apollo_detach(apollo_beta, apollo_inputs))

      P <- list()

      alternatives <- c(
        "prim",
        "temp",
        "home"
      )

      avail <- list(
        prim = 1,
        temp = 1,
        home = 1
      )

      continuousChoice <- list(
        prim =  hours_total_place_1,
        temp =  hours_total_place_2,
        home =  hours_total_place_3
      )

      V <- list()
      V[["prim"]] <- 0
      V[["temp"]] <- delta_temp +
        delta_temp_age_18_29 * (age == 1) +
        delta_temp_age_45_64 * (age == 3) +
        delta_temp_age_65plus * (age == 4) +
        delta_temp_gender_women * (gender == 1) +
        delta_temp_kids_kids * (kids == 1) +
        delta_temp_genderkids_women_kids * (gender == 1 & kids == 1) +
        delta_temp_income_50minus * (income == 1) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_highschool * (education12 == 1) +
        delta_temp_education_graduate * (education12 == 3) +
        delta_temp_impedance_20_39 * (impedance == 2) +
        delta_temp_impedance_40_59 * (impedance == 3) +
        delta_temp_impedance_60plus * (impedance == 4) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town * (neighborhood == 3) +
        delta_temp_impneighbor_20_39_suburban * (impedance == 2 & neighborhood == 2) +
        delta_temp_impneighbor_40_59_suburban * (impedance == 3 & neighborhood == 2) +
        delta_temp_impneighbor_60plus_suburban * (impedance == 4 & neighborhood == 2) +
        delta_temp_impneighbor_20_39_town * (impedance == 2 & neighborhood == 3) +
        delta_temp_impneighbor_40_59_town * (impedance == 3 & neighborhood == 3) +
        delta_temp_impneighbor_60plus_town * (impedance == 4 & neighborhood == 3) +
        delta_temp_jobtype12_professional * (jobtype12 == 2) +
        delta_temp_jobtype12_administrative * (jobtype12 == 3) +
        delta_temp_homeownership_nonown * (homeownership == 1) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3
      V[["home"]] <- delta_home +
        delta_home_age_18_29 * (age == 1) +
        delta_home_age_45_64 * (age == 3) +
        delta_home_age_65plus * (age == 4) +
        delta_home_gender_women * (gender == 1) +
        delta_home_kids_kids * (kids == 1) +
        delta_home_genderkids_women_kids * (gender == 1 & kids == 1) +
        delta_home_income_50minus * (income == 1) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_highschool * (education12 == 1) +
        delta_home_education_graduate * (education12 == 3) +
        delta_home_impedance_20_39 * (impedance == 2) +
        delta_home_impedance_40_59 * (impedance == 3) +
        delta_home_impedance_60plus * (impedance == 4) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town * (neighborhood == 3) +
        delta_home_impneighbor_20_39_suburban * (impedance == 2 & neighborhood == 2) +
        delta_home_impneighbor_40_59_suburban * (impedance == 3 & neighborhood == 2) +
        delta_home_impneighbor_60plus_suburban * (impedance == 4 & neighborhood == 2) +
        delta_home_impneighbor_20_39_town * (impedance == 2 & neighborhood == 3) +
        delta_home_impneighbor_40_59_town * (impedance == 3 & neighborhood == 3) +
        delta_home_impneighbor_60plus_town * (impedance == 4 & neighborhood == 3) +
        delta_home_jobtype12_professional * (jobtype12 == 2) +
        delta_home_jobtype12_administrative * (jobtype12 == 3) +
        delta_home_homeownership_nonown * (homeownership == 1) +
        delta_home_factor_score_1 * factor_1 +
        delta_home_factor_score_2 * factor_2 +
        delta_home_factor_score_3 * factor_3

      alpha <- list(
        prim = 1 / (1 + exp(5)),
        temp = 1 / (1 + exp(5)),
        home = 1 / (1 + exp(5))
      )

      gamma <- list(
        prim = gamma_prim,
        temp = gamma_temp,
        home = gamma_home
      )

      cost <- list(
        prim = 1,
        temp = 1,
        home = 1
      )

      mdcev_settings <- list(
        alternatives = alternatives,
        avail = avail,
        continuousChoice = continuousChoice,
        utilities = V,
        alpha = alpha,
        gamma = gamma,
        sigma = 1,
        cost = cost,
        budget = hours_total
      )

      P[["model"]] <- apollo_mdcev(mdcev_settings, functionality)

      P <- apollo_prepareProb(P, apollo_inputs, functionality)
      return(P)
    }

  assign("apollo_probabilities", apollo_probabilities, envir = globalenv())

  model <- apollo_estimate(
    apollo_beta,
    apollo_fixed,
    apollo_probabilities,
    apollo_inputs
  )

  apollo_modelOutput(model)

  apollo_saveOutput(model)

  apollo_sink()

  # predictions_base <-
  #   apollo_prediction(model, apollo_probabilities, apollo_inputs)

  # apollo_sink()
}

exec_model_12_alpha_zero()
apollo_sink()
