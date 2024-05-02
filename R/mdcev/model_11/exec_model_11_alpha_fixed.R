exec_model_11_alpha_fixed <- function(range = NULL) {
  database <- get("data", envir = globalenv()) %>%
    select(
      row_index,
      agk,
      gender,
      income,
      education,
      impedance,
      jobtype,
      commute,
      neighborhood,
      homeownership,
      factor_1,
      factor_2,
      factor_3,
      matches("hours_total")
    ) %>%
    mutate_all(as.numeric)

  model_name <- "model_11_alpha_fixed"

  if (!is.null(range)) {
    database <- database %>%
      filter(hours_total >= range[1] & hours_total < range[2])
    model_name <- paste0(model_name, "_", range[1], "_", range[2])
  }

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName       = model_name,
    modelDescr      = "
  Budget: Variable
  Fixed: Alpha
  I.V.
  - Age x Gender x Kids
  - Income
  - Education
  - Travel impedance x Gender
  - Job type
  - Primary commute mode
  - Neighborhood type
  - Home ownership
  - Factor scores",
    indivID         = "row_index",
    outputDirectory = file.path("output", "mdcev", "model_11")
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    gamma_prim = 1,
    gamma_temp = 1,
    gamma_home = 1,
    # delta_prim = 0,
    delta_temp = 0,
    delta_home = 0,
    # delta_prim_agk_18_29_woman = 0,
    delta_temp_agk_18_29_woman = 0,
    delta_home_agk_18_29_woman = 0,
    # delta_prim_agk_18_29_nonwoman = 0,
    delta_temp_agk_18_29_nonwoman = 0,
    delta_home_agk_18_29_nonwoman = 0,
    # delta_prim_agk_30_44_woman_kids = 0,
    delta_temp_agk_30_44_woman_kids = 0,
    delta_home_agk_30_44_woman_kids = 0,
    # delta_prim_agk_30_44_woman_nokids = 0,
    delta_temp_agk_30_44_woman_nokids = 0,
    delta_home_agk_30_44_woman_nokids = 0,
    # delta_prim_agk_30_44_nonwoman_kids = 0,
    delta_temp_agk_30_44_nonwoman_kids = 0,
    delta_home_agk_30_44_nonwoman_kids = 0,
    # delta_prim_agk_30_44_nonwoman_nokids = 0,
    # delta_temp_agk_30_44_nonwoman_nokids = 0,
    # delta_home_agk_30_44_nonwoman_nokids = 0,
    # delta_prim_agk_45_64_woman = 0,
    delta_temp_agk_45_64_woman = 0,
    delta_home_agk_45_64_woman = 0,
    # delta_prim_agk_45_64_nonwoman = 0,
    delta_temp_agk_45_64_nonwoman = 0,
    delta_home_agk_45_64_nonwoman = 0,
    # delta_prim_agk_65plus_woman = 0,
    delta_temp_agk_65plus_woman = 0,
    delta_home_agk_65plus_woman = 0,
    # delta_prim_agk_65plus_nonwoman = 0,
    delta_temp_agk_65plus_nonwoman = 0,
    delta_home_agk_65plus_nonwoman = 0,
    # delta_prim_income_50minus = 0,
    delta_temp_income_50minus = 0,
    delta_home_income_50minus = 0,
    # delta_prim_income_100_149 = 0,
    delta_temp_income_100_149 = 0,
    delta_home_income_100_149 = 0,
    # delta_prim_income_150plus = 0,
    delta_temp_income_150plus = 0,
    delta_home_income_150plus = 0,
    # delta_prim_education_highschool = 0,
    delta_temp_education_highschool = 0,
    delta_home_education_highschool = 0,
    # delta_prim_education_graduate = 0,
    delta_temp_education_graduate = 0,
    delta_home_education_graduate = 0,
    # delta_prim_impgender_20minus = 0,
    delta_temp_impgender_20minus_nonwoman = 0,
    delta_home_impgender_20minus_nonwoman = 0,
    # delta_prim_impgender_40_59_nonwoman = 0,
    delta_temp_impgender_40_59_nonwoman = 0,
    delta_home_impgender_40_59_nonwoman = 0,
    # delta_prim_impgender_60plus_nonwoman = 0,
    delta_temp_impgender_60plus_nonwoman = 0,
    delta_home_impgender_60plus_nonwoman = 0,
    # delta_prim_impgender_20minus_woman = 0,
    delta_temp_impgender_20minus_woman = 0,
    delta_home_impgender_20minus_woman = 0,
    # delta_prim_impgender_40_59_woman = 0,
    delta_temp_impgender_40_59_woman = 0,
    delta_home_impgender_40_59_woman = 0,
    # delta_prim_impgender_60plus_woman = 0,
    delta_temp_impgender_60plus_woman = 0,
    delta_home_impgender_60plus_woman = 0,
    # delta_prim_jobtype_health = 0,
    delta_temp_jobtype_health = 0,
    delta_home_jobtype_health = 0,
    # delta_prim_jobtype_retail = 0,
    delta_temp_jobtype_retail = 0,
    delta_home_jobtype_retail = 0,
    # delta_prim_jobtype_education = 0,
    delta_temp_jobtype_education = 0,
    delta_home_jobtype_education = 0,
    # delta_prim_jobtype_public = 0,
    delta_temp_jobtype_public = 0,
    delta_home_jobtype_public = 0,
    # delta_prim_jobtype_information = 0,
    delta_temp_jobtype_information = 0,
    delta_home_jobtype_information = 0,
    # delta_prim_commute_noncar = 0,
    delta_temp_commute_noncar = 0,
    delta_home_commute_noncar = 0,
    # delta_prim_neighborhood_suburban = 0,
    delta_temp_neighborhood_suburban = 0,
    delta_home_neighborhood_suburban = 0,
    # delta_prim_neighborhood_town_rural = 0,
    delta_temp_neighborhood_town_rural = 0,
    delta_home_neighborhood_town_rural = 0,
    # delta_prim_homeownership_nonown = 0,
    delta_temp_homeownership_nonown = 0,
    delta_home_homeownership_nonown = 0,
    # delta_prim_factor_score_1 = 0,
    delta_temp_factor_score_1 = 0,
    delta_home_factor_score_1 = 0,
    # delta_prim_factor_score_2 = 0,
    delta_temp_factor_score_2 = 0,
    delta_home_factor_score_2 = 0,
    # delta_prim_factor_score_3 = 0,
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
        delta_temp_agk_18_29_woman * (agk == 1) +
        delta_temp_agk_18_29_nonwoman * (agk == 2) +
        delta_temp_agk_30_44_woman_kids * (agk == 3) +
        delta_temp_agk_30_44_woman_nokids * (agk == 4) +
        delta_temp_agk_30_44_nonwoman_kids * (agk == 5) +
        delta_temp_agk_45_64_woman * (agk == 7) +
        delta_temp_agk_45_64_nonwoman * (agk == 8) +
        delta_temp_agk_65plus_woman * (agk == 9) +
        delta_temp_agk_65plus_nonwoman * (agk == 10) +
        delta_temp_income_50minus * (income == 2) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_highschool * (education == 1) +
        delta_temp_education_graduate * (education == 3) +
        delta_temp_impgender_20minus_nonwoman * (impedance == 1 & gender == 2) +
        delta_temp_impgender_40_59_nonwoman * (impedance == 3 & gender == 2) +
        delta_temp_impgender_60plus_nonwoman * (impedance == 4 & gender == 2) +
        delta_temp_impgender_20minus_woman * (impedance == 1 & gender == 1) +
        delta_temp_impgender_40_59_woman * (impedance == 3 & gender == 1) +
        delta_temp_impgender_60plus_woman * (impedance == 4 & gender == 1) +
        delta_temp_jobtype_health * (jobtype == 2) +
        delta_temp_jobtype_retail * (jobtype == 3) +
        delta_temp_jobtype_education * (jobtype == 4) +
        delta_temp_jobtype_public * (jobtype == 5) +
        delta_temp_jobtype_information * (jobtype == 6) +
        delta_temp_commute_noncar * (commute == 0) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town_rural * (neighborhood == 1) +
        delta_temp_homeownership_nonown * (homeownership == 1) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3
      V[["home"]] <- delta_home +
        delta_home_agk_18_29_woman * (agk == 1) +
        delta_home_agk_18_29_nonwoman * (agk == 2) +
        delta_home_agk_30_44_woman_kids * (agk == 3) +
        delta_home_agk_30_44_woman_nokids * (agk == 4) +
        delta_home_agk_30_44_nonwoman_kids * (agk == 5) +
        delta_home_agk_45_64_woman * (agk == 7) +
        delta_home_agk_45_64_nonwoman * (agk == 8) +
        delta_home_agk_65plus_woman * (agk == 9) +
        delta_home_agk_65plus_nonwoman * (agk == 10) +
        delta_home_income_50minus * (income == 1) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_highschool * (education == 1) +
        delta_home_education_graduate * (education == 3) +
        delta_home_impgender_20minus_nonwoman * (impedance == 1 & gender == 2) +
        delta_home_impgender_40_59_nonwoman * (impedance == 3 & gender == 2) +
        delta_home_impgender_60plus_nonwoman * (impedance == 4 & gender == 2) +
        delta_home_impgender_20minus_woman * (impedance == 1 & gender == 1) +
        delta_home_impgender_40_59_woman * (impedance == 3 & gender == 1) +
        delta_home_impgender_60plus_woman * (impedance == 4 & gender == 1) +
        delta_home_jobtype_health * (jobtype == 2) +
        delta_home_jobtype_retail * (jobtype == 3) +
        delta_home_jobtype_education * (jobtype == 4) +
        delta_home_jobtype_public * (jobtype == 5) +
        delta_home_jobtype_information * (jobtype == 6) +
        delta_home_commute_noncar * (commute == 0) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town_rural * (neighborhood == 1) +
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

exec_model_11_alpha_fixed()
exec_model_11_alpha_fixed(c(30, 60))
apollo_sink()
