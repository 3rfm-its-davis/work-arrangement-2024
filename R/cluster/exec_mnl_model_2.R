exec_mnl_model_2 <- function() {
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
      neighborhood,
      homeownership,
      cluster
    ) %>%
    mutate_if(
      is.numeric,
      as.numeric
    )

  model_name <- "mnl_model_2"

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName       = model_name,
    modelDescr      = "
  I.V.
  - Age x Gender x Kids
  - Income
  - Education (3-level)
  - Travel impedance x Gender
  - Job type (3-level)
  - Neighborhood type
  - Home ownership",
    indivID         = "row_index",
    outputDirectory = file.path("output", "mnl")
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    asc_temp = 0,
    asc_home = 0,
    asc_prho = 0,
    asc_tmho = 0,
    asc_allm = 0,
    b_temp_age_18_29 = 0,
    b_home_age_18_29 = 0,
    b_prho_age_18_29 = 0,
    b_tmho_age_18_29 = 0,
    b_allm_age_18_29 = 0,
    b_temp_age_45_64 = 0,
    b_home_age_45_64 = 0,
    b_prho_age_45_64 = 0,
    b_tmho_age_45_64 = 0,
    b_allm_age_45_64 = 0,
    b_temp_age_65plus = 0,
    b_home_age_65plus = 0,
    b_prho_age_65plus = 0,
    b_tmho_age_65plus = 0,
    b_allm_age_65plus = 0,
    b_temp_gender_women = 0,
    b_home_gender_women = 0,
    b_prho_gender_women = 0,
    b_tmho_gender_women = 0,
    b_allm_gender_women = 0,
    b_temp_kids_kids = 0,
    b_home_kids_kids = 0,
    b_prho_kids_kids = 0,
    b_tmho_kids_kids = 0,
    b_allm_kids_kids = 0,
    b_temp_genderkids_women_kids = 0,
    b_home_genderkids_women_kids = 0,
    b_prho_genderkids_women_kids = 0,
    b_tmho_genderkids_women_kids = 0,
    b_allm_genderkids_women_kids = 0,
    b_temp_income_50minus = 0,
    b_home_income_50minus = 0,
    b_prho_income_50minus = 0,
    b_tmho_income_50minus = 0,
    b_allm_income_50minus = 0,
    b_temp_income_100_149 = 0,
    b_home_income_100_149 = 0,
    b_prho_income_100_149 = 0,
    b_tmho_income_100_149 = 0,
    b_allm_income_100_149 = 0,
    b_temp_income_150plus = 0,
    b_home_income_150plus = 0,
    b_prho_income_150plus = 0,
    b_tmho_income_150plus = 0,
    b_allm_income_150plus = 0,
    b_temp_education_highschool = 0,
    b_home_education_highschool = 0,
    b_prho_education_highschool = 0,
    b_tmho_education_highschool = 0,
    b_allm_education_highschool = 0,
    b_temp_education_graduate = 0,
    b_home_education_graduate = 0,
    b_prho_education_graduate = 0,
    b_tmho_education_graduate = 0,
    b_allm_education_graduate = 0,
    b_temp_impedance_20_39 = 0,
    b_home_impedance_20_39 = 0,
    b_prho_impedance_20_39 = 0,
    b_tmho_impedance_20_39 = 0,
    b_allm_impedance_20_39 = 0,
    b_temp_impedance_40_59 = 0,
    b_home_impedance_40_59 = 0,
    b_prho_impedance_40_59 = 0,
    b_tmho_impedance_40_59 = 0,
    b_allm_impedance_40_59 = 0,
    b_temp_impedance_60plus = 0,
    b_home_impedance_60plus = 0,
    b_prho_impedance_60plus = 0,
    b_tmho_impedance_60plus = 0,
    b_allm_impedance_60plus = 0,
    b_temp_neighborhood_suburban = 0,
    b_home_neighborhood_suburban = 0,
    b_prho_neighborhood_suburban = 0,
    b_tmho_neighborhood_suburban = 0,
    b_allm_neighborhood_suburban = 0,
    b_temp_neighborhood_town = 0,
    b_home_neighborhood_town = 0,
    b_prho_neighborhood_town = 0,
    b_tmho_neighborhood_town = 0,
    b_allm_neighborhood_town = 0,
    b_temp_jobtype12_professional = 0,
    b_home_jobtype12_professional = 0,
    b_prho_jobtype12_professional = 0,
    b_tmho_jobtype12_professional = 0,
    b_allm_jobtype12_professional = 0,
    b_temp_jobtype12_administrative = 0,
    b_home_jobtype12_administrative = 0,
    b_prho_jobtype12_administrative = 0,
    b_tmho_jobtype12_administrative = 0,
    b_allm_jobtype12_administrative = 0,
    b_temp_homeownership_nonown = 0,
    b_home_homeownership_nonown = 0,
    b_prho_homeownership_nonown = 0,
    b_tmho_homeownership_nonown = 0,
    b_allm_homeownership_nonown = 0
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

      V <- list()
      V[["prim"]] <- 0
      V[["temp"]] <- asc_temp +
        b_temp_age_18_29 * (age == 1) +
        b_temp_age_45_64 * (age == 3) +
        b_temp_age_65plus * (age == 4) +
        b_temp_gender_women * (gender == 1) +
        b_temp_kids_kids * (kids == 1) +
        b_temp_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_temp_income_50minus * (income == 1) +
        b_temp_income_100_149 * (income == 3) +
        b_temp_income_150plus * (income == 4) +
        b_temp_education_highschool * (education12 == 1) +
        b_temp_education_graduate * (education12 == 3) +
        b_temp_impedance_20_39 * (impedance == 2) +
        b_temp_impedance_40_59 * (impedance == 3) +
        b_temp_impedance_60plus * (impedance == 4) +
        b_temp_neighborhood_suburban * (neighborhood == 2) +
        b_temp_neighborhood_town * (neighborhood == 3) +
        b_temp_jobtype12_professional * (jobtype12 == 2) +
        b_temp_jobtype12_administrative * (jobtype12 == 3) +
        b_temp_homeownership_nonown * (homeownership == 1)
      V[["home"]] <- asc_home +
        b_home_age_18_29 * (age == 1) +
        b_home_age_45_64 * (age == 3) +
        b_home_age_65plus * (age == 4) +
        b_home_gender_women * (gender == 1) +
        b_home_kids_kids * (kids == 1) +
        b_home_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_home_income_50minus * (income == 1) +
        b_home_income_100_149 * (income == 3) +
        b_home_income_150plus * (income == 4) +
        b_home_education_highschool * (education12 == 1) +
        b_home_education_graduate * (education12 == 3) +
        b_home_impedance_20_39 * (impedance == 2) +
        b_home_impedance_40_59 * (impedance == 3) +
        b_home_impedance_60plus * (impedance == 4) +
        b_home_neighborhood_suburban * (neighborhood == 2) +
        b_home_neighborhood_town * (neighborhood == 3) +
        b_home_jobtype12_professional * (jobtype12 == 2) +
        b_home_jobtype12_administrative * (jobtype12 == 3) +
        b_home_homeownership_nonown * (homeownership == 1)
      V[["prho"]] <- asc_prho +
        b_prho_age_18_29 * (age == 1) +
        b_prho_age_45_64 * (age == 3) +
        b_prho_age_65plus * (age == 4) +
        b_prho_gender_women * (gender == 1) +
        b_prho_kids_kids * (kids == 1) +
        b_prho_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_prho_income_50minus * (income == 1) +
        b_prho_income_100_149 * (income == 3) +
        b_prho_income_150plus * (income == 4) +
        b_prho_education_highschool * (education12 == 1) +
        b_prho_education_graduate * (education12 == 3) +
        b_prho_impedance_20_39 * (impedance == 2) +
        b_prho_impedance_40_59 * (impedance == 3) +
        b_prho_impedance_60plus * (impedance == 4) +
        b_prho_neighborhood_suburban * (neighborhood == 2) +
        b_prho_neighborhood_town * (neighborhood == 3) +
        b_prho_jobtype12_professional * (jobtype12 == 2) +
        b_prho_jobtype12_administrative * (jobtype12 == 3) +
        b_prho_homeownership_nonown * (homeownership == 1)
      V[["tmho"]] <- asc_tmho +
        b_tmho_age_18_29 * (age == 1) +
        b_tmho_age_45_64 * (age == 3) +
        b_tmho_age_65plus * (age == 4) +
        b_tmho_gender_women * (gender == 1) +
        b_tmho_kids_kids * (kids == 1) +
        b_tmho_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_tmho_income_50minus * (income == 1) +
        b_tmho_income_100_149 * (income == 3) +
        b_tmho_income_150plus * (income == 4) +
        b_tmho_education_highschool * (education12 == 1) +
        b_tmho_education_graduate * (education12 == 3) +
        b_tmho_impedance_20_39 * (impedance == 2) +
        b_tmho_impedance_40_59 * (impedance == 3) +
        b_tmho_impedance_60plus * (impedance == 4) +
        b_tmho_neighborhood_suburban * (neighborhood == 2) +
        b_tmho_neighborhood_town * (neighborhood == 3) +
        b_tmho_jobtype12_professional * (jobtype12 == 2) +
        b_tmho_jobtype12_administrative * (jobtype12 == 3) +
        b_tmho_homeownership_nonown * (homeownership == 1)
      V[["allm"]] <- asc_allm +
        b_allm_age_18_29 * (age == 1) +
        b_allm_age_45_64 * (age == 3) +
        b_allm_age_65plus * (age == 4) +
        b_allm_gender_women * (gender == 1) +
        b_allm_kids_kids * (kids == 1) +
        b_allm_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_allm_income_50minus * (income == 1) +
        b_allm_income_100_149 * (income == 3) +
        b_allm_income_150plus * (income == 4) +
        b_allm_education_highschool * (education12 == 1) +
        b_allm_education_graduate * (education12 == 3) +
        b_allm_impedance_20_39 * (impedance == 2) +
        b_allm_impedance_40_59 * (impedance == 3) +
        b_allm_impedance_60plus * (impedance == 4) +
        b_allm_neighborhood_suburban * (neighborhood == 2) +
        b_allm_neighborhood_town * (neighborhood == 3) +
        b_allm_jobtype12_professional * (jobtype12 == 2) +
        b_allm_jobtype12_administrative * (jobtype12 == 3) +
        b_allm_homeownership_nonown * (homeownership == 1)

      mnl_settings <- list(
        alternatives = c(
          prim = 1,
          temp = 2,
          home = 3,
          prho = 4,
          tmho = 5,
          allm = 6
        ),
        avail = list(
          prim = 1,
          temp = 1,
          home = 1,
          prho = 1,
          tmho = 1,
          allm = 1
        ),
        choiceVar = cluster,
        utilities = V
      )

      P[["model"]] <- apollo_mnl(mnl_settings, functionality)

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

exec_mnl_model_2()
apollo_sink()
