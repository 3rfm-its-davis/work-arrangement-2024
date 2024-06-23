exec_mnl_model_1 <- function() {
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
      factor_c_1,
      factor_c_2,
      factor_c_3,
      cluster
    ) %>%
    mutate_if(
      is.numeric,
      as.numeric
    )

  model_name <- "mnl_cluster"

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
  - Primary commute mode
  - Neighborhood type
  - Home ownership
  - Factor scores",
    indivID         = "row_index",
    outputDirectory = file.path("output", "mnl")
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    asc_2 = 0,
    asc_3 = 0,
    asc_4 = 0,
    asc_5 = 0,
    asc_6 = 0,
    b_2_age_18_29 = 0,
    b_3_age_18_29 = 0,
    b_4_age_18_29 = 0,
    b_5_age_18_29 = 0,
    b_6_age_18_29 = 0,
    b_2_age_45_64 = 0,
    b_3_age_45_64 = 0,
    b_4_age_45_64 = 0,
    b_5_age_45_64 = 0,
    b_6_age_45_64 = 0,
    b_2_age_65plus = 0,
    b_3_age_65plus = 0,
    b_4_age_65plus = 0,
    b_5_age_65plus = 0,
    b_6_age_65plus = 0,
    b_2_gender_women = 0,
    b_3_gender_women = 0,
    b_4_gender_women = 0,
    b_5_gender_women = 0,
    b_6_gender_women = 0,
    b_2_kids_kids = 0,
    b_3_kids_kids = 0,
    b_4_kids_kids = 0,
    b_5_kids_kids = 0,
    b_6_kids_kids = 0,
    b_2_genderkids_women_kids = 0,
    b_3_genderkids_women_kids = 0,
    b_4_genderkids_women_kids = 0,
    b_5_genderkids_women_kids = 0,
    b_6_genderkids_women_kids = 0,
    b_2_income_50minus = 0,
    b_3_income_50minus = 0,
    b_4_income_50minus = 0,
    b_5_income_50minus = 0,
    b_6_income_50minus = 0,
    b_2_income_100_149 = 0,
    b_3_income_100_149 = 0,
    b_4_income_100_149 = 0,
    b_5_income_100_149 = 0,
    b_6_income_100_149 = 0,
    b_2_income_150plus = 0,
    b_3_income_150plus = 0,
    b_4_income_150plus = 0,
    b_5_income_150plus = 0,
    b_6_income_150plus = 0,
    b_2_education_highschool = 0,
    b_3_education_highschool = 0,
    b_4_education_highschool = 0,
    b_5_education_highschool = 0,
    b_6_education_highschool = 0,
    b_2_education_graduate = 0,
    b_3_education_graduate = 0,
    b_4_education_graduate = 0,
    b_5_education_graduate = 0,
    b_6_education_graduate = 0,
    b_2_impedance_20_39 = 0,
    b_3_impedance_20_39 = 0,
    b_4_impedance_20_39 = 0,
    b_5_impedance_20_39 = 0,
    b_6_impedance_20_39 = 0,
    b_2_impedance_40_59 = 0,
    b_3_impedance_40_59 = 0,
    b_4_impedance_40_59 = 0,
    b_5_impedance_40_59 = 0,
    b_6_impedance_40_59 = 0,
    b_2_impedance_60plus = 0,
    b_3_impedance_60plus = 0,
    b_4_impedance_60plus = 0,
    b_5_impedance_60plus = 0,
    b_6_impedance_60plus = 0,
    b_2_neighborhood_suburban = 0,
    b_3_neighborhood_suburban = 0,
    b_4_neighborhood_suburban = 0,
    b_5_neighborhood_suburban = 0,
    b_6_neighborhood_suburban = 0,
    b_2_neighborhood_town = 0,
    b_3_neighborhood_town = 0,
    b_4_neighborhood_town = 0,
    b_5_neighborhood_town = 0,
    b_6_neighborhood_town = 0,
    b_2_jobtype12_professional = 0,
    b_3_jobtype12_professional = 0,
    b_4_jobtype12_professional = 0,
    b_5_jobtype12_professional = 0,
    b_6_jobtype12_professional = 0,
    b_2_jobtype12_administrative = 0,
    b_3_jobtype12_administrative = 0,
    b_4_jobtype12_administrative = 0,
    b_5_jobtype12_administrative = 0,
    b_6_jobtype12_administrative = 0,
    b_2_homeownership_nonown = 0,
    b_3_homeownership_nonown = 0,
    b_4_homeownership_nonown = 0,
    b_5_homeownership_nonown = 0,
    b_6_homeownership_nonown = 0,
    b_2_factor_c_score_1 = 0,
    b_3_factor_c_score_1 = 0,
    b_4_factor_c_score_1 = 0,
    b_5_factor_c_score_1 = 0,
    b_6_factor_c_score_1 = 0,
    b_2_factor_c_score_2 = 0,
    b_3_factor_c_score_2 = 0,
    b_4_factor_c_score_2 = 0,
    b_5_factor_c_score_2 = 0,
    b_6_factor_c_score_2 = 0,
    b_2_factor_c_score_3 = 0,
    b_3_factor_c_score_3 = 0,
    b_4_factor_c_score_3 = 0,
    b_5_factor_c_score_3 = 0,
    b_6_factor_c_score_3 = 0
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
      V[["cluster1"]] <- 0
      V[["cluster2"]] <- asc_2 +
        b_2_age_18_29 * (age == 1) +
        b_2_age_45_64 * (age == 3) +
        b_2_age_65plus * (age == 4) +
        b_2_gender_women * (gender == 1) +
        b_2_kids_kids * (kids == 1) +
        b_2_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_2_income_50minus * (income == 1) +
        b_2_income_100_149 * (income == 3) +
        b_2_income_150plus * (income == 4) +
        b_2_education_highschool * (education12 == 1) +
        b_2_education_graduate * (education12 == 3) +
        b_2_impedance_20_39 * (impedance == 2) +
        b_2_impedance_40_59 * (impedance == 3) +
        b_2_impedance_60plus * (impedance == 4) +
        b_2_neighborhood_suburban * (neighborhood == 2) +
        b_2_neighborhood_town * (neighborhood == 3) +
        b_2_jobtype12_professional * (jobtype12 == 2) +
        b_2_jobtype12_administrative * (jobtype12 == 3) +
        b_2_homeownership_nonown * (homeownership == 1) +
        b_2_factor_c_score_1 * factor_c_1 +
        b_2_factor_c_score_2 * factor_c_2 +
        b_2_factor_c_score_3 * factor_c_3
      V[["cluster3"]] <- asc_3 +
        b_3_age_18_29 * (age == 1) +
        b_3_age_45_64 * (age == 3) +
        b_3_age_65plus * (age == 4) +
        b_3_gender_women * (gender == 1) +
        b_3_kids_kids * (kids == 1) +
        b_3_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_3_income_50minus * (income == 1) +
        b_3_income_100_149 * (income == 3) +
        b_3_income_150plus * (income == 4) +
        b_3_education_highschool * (education12 == 1) +
        b_3_education_graduate * (education12 == 3) +
        b_3_impedance_20_39 * (impedance == 2) +
        b_3_impedance_40_59 * (impedance == 3) +
        b_3_impedance_60plus * (impedance == 4) +
        b_3_neighborhood_suburban * (neighborhood == 2) +
        b_3_neighborhood_town * (neighborhood == 3) +
        b_3_jobtype12_professional * (jobtype12 == 2) +
        b_3_jobtype12_administrative * (jobtype12 == 3) +
        b_3_homeownership_nonown * (homeownership == 1) +
        b_3_factor_c_score_1 * factor_c_1 +
        b_3_factor_c_score_2 * factor_c_2 +
        b_3_factor_c_score_3 * factor_c_3
      V[["cluster4"]] <- asc_4 +
        b_4_age_18_29 * (age == 1) +
        b_4_age_45_64 * (age == 3) +
        b_4_age_65plus * (age == 4) +
        b_4_gender_women * (gender == 1) +
        b_4_kids_kids * (kids == 1) +
        b_4_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_4_income_50minus * (income == 1) +
        b_4_income_100_149 * (income == 3) +
        b_4_income_150plus * (income == 4) +
        b_4_education_highschool * (education12 == 1) +
        b_4_education_graduate * (education12 == 3) +
        b_4_impedance_20_39 * (impedance == 2) +
        b_4_impedance_40_59 * (impedance == 3) +
        b_4_impedance_60plus * (impedance == 4) +
        b_4_neighborhood_suburban * (neighborhood == 2) +
        b_4_neighborhood_town * (neighborhood == 3) +
        b_4_jobtype12_professional * (jobtype12 == 2) +
        b_4_jobtype12_administrative * (jobtype12 == 3) +
        b_4_homeownership_nonown * (homeownership == 1) +
        b_4_factor_c_score_1 * factor_c_1 +
        b_4_factor_c_score_2 * factor_c_2 +
        b_4_factor_c_score_3 * factor_c_3
      V[["cluster5"]] <- asc_5 +
        b_5_age_18_29 * (age == 1) +
        b_5_age_45_64 * (age == 3) +
        b_5_age_65plus * (age == 4) +
        b_5_gender_women * (gender == 1) +
        b_5_kids_kids * (kids == 1) +
        b_5_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_5_income_50minus * (income == 1) +
        b_5_income_100_149 * (income == 3) +
        b_5_income_150plus * (income == 4) +
        b_5_education_highschool * (education12 == 1) +
        b_5_education_graduate * (education12 == 3) +
        b_5_impedance_20_39 * (impedance == 2) +
        b_5_impedance_40_59 * (impedance == 3) +
        b_5_impedance_60plus * (impedance == 4) +
        b_5_neighborhood_suburban * (neighborhood == 2) +
        b_5_neighborhood_town * (neighborhood == 3) +
        b_5_jobtype12_professional * (jobtype12 == 2) +
        b_5_jobtype12_administrative * (jobtype12 == 3) +
        b_5_homeownership_nonown * (homeownership == 1) +
        b_5_factor_c_score_1 * factor_c_1 +
        b_5_factor_c_score_2 * factor_c_2 +
        b_5_factor_c_score_3 * factor_c_3
      V[["cluster6"]] <- asc_6 +
        b_6_age_18_29 * (age == 1) +
        b_6_age_45_64 * (age == 3) +
        b_6_age_65plus * (age == 4) +
        b_6_gender_women * (gender == 1) +
        b_6_kids_kids * (kids == 1) +
        b_6_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_6_income_50minus * (income == 1) +
        b_6_income_100_149 * (income == 3) +
        b_6_income_150plus * (income == 4) +
        b_6_education_highschool * (education12 == 1) +
        b_6_education_graduate * (education12 == 3) +
        b_6_impedance_20_39 * (impedance == 2) +
        b_6_impedance_40_59 * (impedance == 3) +
        b_6_impedance_60plus * (impedance == 4) +
        b_6_neighborhood_suburban * (neighborhood == 2) +
        b_6_neighborhood_town * (neighborhood == 3) +
        b_6_jobtype12_professional * (jobtype12 == 2) +
        b_6_jobtype12_administrative * (jobtype12 == 3) +
        b_6_homeownership_nonown * (homeownership == 1) +
        b_6_factor_c_score_1 * factor_c_1 +
        b_6_factor_c_score_2 * factor_c_2 +
        b_6_factor_c_score_3 * factor_c_3

      mnl_settings <- list(
        alternatives = c(
          cluster1 = 1,
          cluster2 = 2,
          cluster3 = 3,
          cluster4 = 4,
          cluster5 = 5,
          cluster6 = 6
        ),
        avail = list(
          cluster1 = 1,
          cluster2 = 1,
          cluster3 = 1,
          cluster4 = 1,
          cluster5 = 1,
          cluster6 = 1
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

exec_mnl_model_1()
apollo_sink()
