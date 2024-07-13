exec_mdcev <- function() {
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
      pop_density,
      ret_svc_density,
      transit_freq_index,
      factor_a_1,
      factor_a_2,
      factor_a_3,
      factor_a_4,
      factor_a_5,
      cluster
    ) %>%
    mutate_if(
      is.numeric,
      as.numeric
    ) %>%
    mutate_at(
      vars(starts_with("att_")),
      function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
    )

  model_name <- "mdcev_1"

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName = model_name,
    modelDescr = "
  I.V.
  - Age",
    indivID = "row_index",
    outputDirectory = file.path("output", "iclv"),
    nCores = 8
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    gamma_prim_sun = 1,
    gamma_prim_mon = 1,
    gamma_prim_tue = 1,
    gamma_prim_wed = 1,
    gamma_prim_thu = 1,
    gamma_prim_fri = 1,
    gamma_prim_sat = 1,
    gamma_temp_sun = 1,
    gamma_temp_mon = 1,
    gamma_temp_tue = 1,
    gamma_temp_wed = 1,
    gamma_temp_thu = 1,
    gamma_temp_fri = 1,
    gamma_temp_sat = 1,
    gamma_home_sun = 1,
    gamma_home_mon = 1,
    gamma_home_tue = 1,
    gamma_home_wed = 1,
    gamma_home_thu = 1,
    gamma_home_fri = 1,
    gamma_home_sat = 1,
    delta_prim_sun_age_18_34 = 0,
    delta_prim_mon_age_18_34 = 0,
    delta_prim_tue_age_18_34 = 0,
    delta_prim_wed_age_18_34 = 0,
    delta_prim_thu_age_18_34 = 0,
    delta_prim_fri_age_18_34 = 0,
    delta_prim_sat_age_18_34 = 0,
    delta_prim_sun_age_55plus = 0,
    delta_prim_mon_age_55plus = 0,
    delta_prim_tue_age_55plus = 0,
    delta_prim_wed_age_55plus = 0,
    delta_prim_thu_age_55plus = 0,
    delta_prim_fri_age_55plus = 0,
    delta_prim_sat_age_55plus = 0,
    delta_temp_sun_age_18_34 = 0,
    delta_temp_mon_age_18_34 = 0,
    delta_temp_tue_age_18_34 = 0,
    delta_temp_wed_age_18_34 = 0,
    delta_temp_thu_age_18_34 = 0,
    delta_temp_fri_age_18_34 = 0,
    delta_temp_sat_age_18_34 = 0,
    delta_temp_sun_age_55plus = 0,
    delta_temp_mon_age_55plus = 0,
    delta_temp_tue_age_55plus = 0,
    delta_temp_wed_age_55plus = 0,
    delta_temp_thu_age_55plus = 0,
    delta_temp_fri_age_55plus = 0,
    delta_temp_sat_age_55plus = 0,
    delta_home_sun_age_18_34 = 0,
    delta_home_mon_age_18_34 = 0,
    delta_home_tue_age_18_34 = 0,
    delta_home_wed_age_18_34 = 0,
    delta_home_thu_age_18_34 = 0,
    delta_home_fri_age_18_34 = 0,
    delta_home_sat_age_18_34 = 0,
    delta_home_sun_age_55plus = 0,
    delta_home_mon_age_55plus = 0,
    delta_home_tue_age_55plus = 0,
    delta_home_wed_age_55plus = 0,
    delta_home_thu_age_55plus = 0,
    delta_home_fri_age_55plus = 0,
    delta_home_sat_age_55plus = 0,
    delta_prim_sun_gender_women = 0,
    delta_prim_mon_gender_women = 0,
    delta_prim_tue_gender_women = 0,
    delta_prim_wed_gender_women = 0,
    delta_prim_thu_gender_women = 0,
    delta_prim_fri_gender_women = 0,
    delta_prim_sat_gender_women = 0,
    delta_temp_sun_gender_women = 0,
    delta_temp_mon_gender_women = 0,
    delta_temp_tue_gender_women = 0,
    delta_temp_wed_gender_women = 0,
    delta_temp_thu_gender_women = 0,
    delta_temp_fri_gender_women = 0,
    delta_temp_sat_gender_women = 0,
    delta_home_sun_gender_women = 0,
    delta_home_mon_gender_women = 0,
    delta_home_tue_gender_women = 0,
    delta_home_wed_gender_women = 0,
    delta_home_thu_gender_women = 0,
    delta_home_fri_gender_women = 0,
    delta_home_sat_gender_women = 0,
    delta_prim_sun_kids_kids = 0,
    delta_prim_mon_kids_kids = 0,
    delta_prim_tue_kids_kids = 0,
    delta_prim_wed_kids_kids = 0,
    delta_prim_thu_kids_kids = 0,
    delta_prim_fri_kids_kids = 0,
    delta_prim_sat_kids_kids = 0,
    delta_temp_sun_kids_kids = 0,
    delta_temp_mon_kids_kids = 0,
    delta_temp_tue_kids_kids = 0,
    delta_temp_wed_kids_kids = 0,
    delta_temp_thu_kids_kids = 0,
    delta_temp_fri_kids_kids = 0,
    delta_temp_sat_kids_kids = 0,
    delta_home_sun_kids_kids = 0,
    delta_home_mon_kids_kids = 0,
    delta_home_tue_kids_kids = 0,
    delta_home_wed_kids_kids = 0,
    delta_home_thu_kids_kids = 0,
    delta_home_fri_kids_kids = 0,
    delta_home_sat_kids_kids = 0,
    delta_prim_sun_genderkids_women_kids = 0,
    delta_prim_mon_genderkids_women_kids = 0,
    delta_prim_tue_genderkids_women_kids = 0,
    delta_prim_wed_genderkids_women_kids = 0,
    delta_prim_thu_genderkids_women_kids = 0,
    delta_prim_fri_genderkids_women_kids = 0,
    delta_prim_sat_genderkids_women_kids = 0,
    delta_temp_sun_genderkids_women_kids = 0,
    delta_temp_mon_genderkids_women_kids = 0,
    delta_temp_tue_genderkids_women_kids = 0,
    delta_temp_wed_genderkids_women_kids = 0,
    delta_temp_thu_genderkids_women_kids = 0,
    delta_temp_fri_genderkids_women_kids = 0,
    delta_temp_sat_genderkids_women_kids = 0,
    delta_home_sun_genderkids_women_kids = 0,
    delta_home_mon_genderkids_women_kids = 0,
    delta_home_tue_genderkids_women_kids = 0,
    delta_home_wed_genderkids_women_kids = 0,
    delta_home_thu_genderkids_women_kids = 0,
    delta_home_fri_genderkids_women_kids = 0,
    delta_home_sat_genderkids_women_kids = 0,
    delta_prim_sun_income_50minus = 0,
    delta_prim_mon_income_50minus = 0,
    delta_prim_tue_income_50minus = 0,
    delta_prim_wed_income_50minus = 0,
    delta_prim_thu_income_50minus = 0,
    delta_prim_fri_income_50minus = 0,
    delta_prim_sat_income_50minus = 0,
    delta_temp_sun_income_50minus = 0,
    delta_temp_mon_income_50minus = 0,
    delta_temp_tue_income_50minus = 0,
    delta_temp_wed_income_50minus = 0,
    delta_temp_thu_income_50minus = 0,
    delta_temp_fri_income_50minus = 0,
    delta_temp_sat_income_50minus = 0,
    delta_home_sun_income_50minus = 0,
    delta_home_mon_income_50minus = 0,
    delta_home_tue_income_50minus = 0,
    delta_home_wed_income_50minus = 0,
    delta_home_thu_income_50minus = 0,
    delta_home_fri_income_50minus = 0,
    delta_home_sat_income_50minus = 0,
    delta_prim_sun_income_100_149 = 0,
    delta_prim_mon_income_100_149 = 0,
    delta_prim_tue_income_100_149 = 0,
    delta_prim_wed_income_100_149 = 0,
    delta_prim_thu_income_100_149 = 0,
    delta_prim_fri_income_100_149 = 0,
    delta_prim_sat_income_100_149 = 0,
    delta_temp_sun_income_100_149 = 0,
    delta_temp_mon_income_100_149 = 0,
    delta_temp_tue_income_100_149 = 0,
    delta_temp_wed_income_100_149 = 0,
    delta_temp_thu_income_100_149 = 0,
    delta_temp_fri_income_100_149 = 0,
    delta_temp_sat_income_100_149 = 0,
    delta_home_sun_income_100_149 = 0,
    delta_home_mon_income_100_149 = 0,
    delta_home_tue_income_100_149 = 0,
    delta_home_wed_income_100_149 = 0,
    delta_home_thu_income_100_149 = 0,
    delta_home_fri_income_100_149 = 0,
    delta_home_sat_income_100_149 = 0,
    delta_prim_sun_income_150plus = 0,
    delta_prim_mon_income_150plus = 0,
    delta_prim_tue_income_150plus = 0,
    delta_prim_wed_income_150plus = 0,
    delta_prim_thu_income_150plus = 0,
    delta_prim_fri_income_150plus = 0,
    delta_prim_sat_income_150plus = 0,
    delta_temp_sun_income_150plus = 0,
    delta_temp_mon_income_150plus = 0,
    delta_temp_tue_income_150plus = 0,
    delta_temp_wed_income_150plus = 0,
    delta_temp_thu_income_150plus = 0,
    delta_temp_fri_income_150plus = 0,
    delta_temp_sat_income_150plus = 0,
    delta_home_sun_income_150plus = 0,
    delta_home_mon_income_150plus = 0,
    delta_home_tue_income_150plus = 0,
    delta_home_wed_income_150plus = 0,
    delta_home_thu_income_150plus = 0,
    delta_home_fri_income_150plus = 0,
    delta_home_sat_income_150plus = 0,
    delta_prim_sun_education_highschool = 0,
    delta_prim_mon_education_highschool = 0,
    delta_prim_tue_education_highschool = 0,
    delta_prim_wed_education_highschool = 0,
    delta_prim_thu_education_highschool = 0,
    delta_prim_fri_education_highschool = 0,
    delta_prim_sat_education_highschool = 0,
    delta_temp_sun_education_highschool = 0,
    delta_temp_mon_education_highschool = 0,
    delta_temp_tue_education_highschool = 0,
    delta_temp_wed_education_highschool = 0,
    delta_temp_thu_education_highschool = 0,
    delta_temp_fri_education_highschool = 0,
    delta_temp_sat_education_highschool = 0,
    delta_home_sun_education_highschool = 0,
    delta_home_mon_education_highschool = 0,
    delta_home_tue_education_highschool = 0,
    delta_home_wed_education_highschool = 0,
    delta_home_thu_education_highschool = 0,
    delta_home_fri_education_highschool = 0,
    delta_home_sat_education_highschool = 0,
    delta_prim_sun_education_graduate = 0,
    delta_prim_mon_education_graduate = 0,
    delta_prim_tue_education_graduate = 0,
    delta_prim_wed_education_graduate = 0,
    delta_prim_thu_education_graduate = 0,
    delta_prim_fri_education_graduate = 0,
    delta_prim_sat_education_graduate = 0,
    delta_temp_sun_education_graduate = 0,
    delta_temp_mon_education_graduate = 0,
    delta_temp_tue_education_graduate = 0,
    delta_temp_wed_education_graduate = 0,
    delta_temp_thu_education_graduate = 0,
    delta_temp_fri_education_graduate = 0,
    delta_temp_sat_education_graduate = 0,
    delta_home_sun_education_graduate = 0,
    delta_home_mon_education_graduate = 0,
    delta_home_tue_education_graduate = 0,
    delta_home_wed_education_graduate = 0,
    delta_home_thu_education_graduate = 0,
    delta_home_fri_education_graduate = 0,
    delta_home_sat_education_graduate = 0,
    delta_prim_sun_neighborhood_suburban = 0,
    delta_prim_mon_neighborhood_suburban = 0,
    delta_prim_tue_neighborhood_suburban = 0,
    delta_prim_wed_neighborhood_suburban = 0,
    delta_prim_thu_neighborhood_suburban = 0,
    delta_prim_fri_neighborhood_suburban = 0,
    delta_prim_sat_neighborhood_suburban = 0,
    delta_temp_sun_neighborhood_suburban = 0,
    delta_temp_mon_neighborhood_suburban = 0,
    delta_temp_tue_neighborhood_suburban = 0,
    delta_temp_wed_neighborhood_suburban = 0,
    delta_temp_thu_neighborhood_suburban = 0,
    delta_temp_fri_neighborhood_suburban = 0,
    delta_temp_sat_neighborhood_suburban = 0,
    delta_home_sun_neighborhood_suburban = 0,
    delta_home_mon_neighborhood_suburban = 0,
    delta_home_tue_neighborhood_suburban = 0,
    delta_home_wed_neighborhood_suburban = 0,
    delta_home_thu_neighborhood_suburban = 0,
    delta_home_fri_neighborhood_suburban = 0,
    delta_home_sat_neighborhood_suburban = 0,
    delta_prim_sun_neighborhood_town = 0,
    delta_prim_mon_neighborhood_town = 0,
    delta_prim_tue_neighborhood_town = 0,
    delta_prim_wed_neighborhood_town = 0,
    delta_prim_thu_neighborhood_town = 0,
    delta_prim_fri_neighborhood_town = 0,
    delta_prim_sat_neighborhood_town = 0,
    delta_temp_sun_neighborhood_town = 0,
    delta_temp_mon_neighborhood_town = 0,
    delta_temp_tue_neighborhood_town = 0,
    delta_temp_wed_neighborhood_town = 0,
    delta_temp_thu_neighborhood_town = 0,
    delta_temp_fri_neighborhood_town = 0,
    delta_temp_sat_neighborhood_town = 0,
    delta_home_sun_neighborhood_town = 0,
    delta_home_mon_neighborhood_town = 0,
    delta_home_tue_neighborhood_town = 0,
    delta_home_wed_neighborhood_town = 0,
    delta_home_thu_neighborhood_town = 0,
    delta_home_fri_neighborhood_town = 0,
    delta_home_sat_neighborhood_town = 0,
    delta_prim_sun_jobtype12_professional = 0,
    delta_prim_mon_jobtype12_professional = 0,
    delta_prim_tue_jobtype12_professional = 0,
    delta_prim_wed_jobtype12_professional = 0,
    delta_prim_thu_jobtype12_professional = 0,
    delta_prim_fri_jobtype12_professional = 0,
    delta_prim_sat_jobtype12_professional = 0,
    delta_temp_sun_jobtype12_professional = 0,
    delta_temp_mon_jobtype12_professional = 0,
    delta_temp_tue_jobtype12_professional = 0,
    delta_temp_wed_jobtype12_professional = 0,
    delta_temp_thu_jobtype12_professional = 0,
    delta_temp_fri_jobtype12_professional = 0,
    delta_temp_sat_jobtype12_professional = 0,
    delta_home_sun_jobtype12_professional = 0,
    delta_home_mon_jobtype12_professional = 0,
    delta_home_tue_jobtype12_professional = 0,
    delta_home_wed_jobtype12_professional = 0,
    delta_home_thu_jobtype12_professional = 0,
    delta_home_fri_jobtype12_professional = 0,
    delta_home_sat_jobtype12_professional = 0,
    delta_prim_sun_jobtype12_administrative = 0,
    delta_prim_mon_jobtype12_administrative = 0,
    delta_prim_tue_jobtype12_administrative = 0,
    delta_prim_wed_jobtype12_administrative = 0,
    delta_prim_thu_jobtype12_administrative = 0,
    delta_prim_fri_jobtype12_administrative = 0,
    delta_prim_sat_jobtype12_administrative = 0,
    delta_temp_sun_jobtype12_administrative = 0,
    delta_temp_mon_jobtype12_administrative = 0,
    delta_temp_tue_jobtype12_administrative = 0,
    delta_temp_wed_jobtype12_administrative = 0,
    delta_temp_thu_jobtype12_administrative = 0,
    delta_temp_fri_jobtype12_administrative = 0,
    delta_temp_sat_jobtype12_administrative = 0,
    delta_home_sun_jobtype12_administrative = 0,
    delta_home_mon_jobtype12_administrative = 0,
    delta_home_tue_jobtype12_administrative = 0,
    delta_home_wed_jobtype12_administrative = 0,
    delta_home_thu_jobtype12_administrative = 0,
    delta_home_fri_jobtype12_administrative = 0,
    delta_home_sat_jobtype12_administrative = 0,
    delta_prim_sun_homeownership_nonown = 0,
    delta_prim_mon_homeownership_nonown = 0,
    delta_prim_tue_homeownership_nonown = 0,
    delta_prim_wed_homeownership_nonown = 0,
    delta_prim_thu_homeownership_nonown = 0,
    delta_prim_fri_homeownership_nonown = 0,
    delta_prim_sat_homeownership_nonown = 0,
    delta_temp_sun_homeownership_nonown = 0,
    delta_temp_mon_homeownership_nonown = 0,
    delta_temp_tue_homeownership_nonown = 0,
    delta_temp_wed_homeownership_nonown = 0,
    delta_temp_thu_homeownership_nonown = 0,
    delta_temp_fri_homeownership_nonown = 0,
    delta_temp_sat_homeownership_nonown = 0,
    delta_home_sun_homeownership_nonown = 0,
    delta_home_mon_homeownership_nonown = 0,
    delta_home_tue_homeownership_nonown = 0,
    delta_home_wed_homeownership_nonown = 0,
    delta_home_thu_homeownership_nonown = 0,
    delta_home_fri_homeownership_nonown = 0,
    delta_home_sat_homeownership_nonown = 0,
    delta_prim_sun_pop_density = 0,
    delta_prim_mon_pop_density = 0,
    delta_prim_tue_pop_density = 0,
    delta_prim_wed_pop_density = 0,
    delta_prim_thu_pop_density = 0,
    delta_prim_fri_pop_density = 0,
    delta_prim_sat_pop_density = 0,
    delta_temp_sun_pop_density = 0,
    delta_temp_mon_pop_density = 0,
    delta_temp_tue_pop_density = 0,
    delta_temp_wed_pop_density = 0,
    delta_temp_thu_pop_density = 0,
    delta_temp_fri_pop_density = 0,
    delta_temp_sat_pop_density = 0,
    delta_home_sun_pop_density = 0,
    delta_home_mon_pop_density = 0,
    delta_home_tue_pop_density = 0,
    delta_home_wed_pop_density = 0,
    delta_home_thu_pop_density = 0,
    delta_home_fri_pop_density = 0,
    delta_home_sat_pop_density = 0,
    delta_prim_sun_ret_svc_density = 0,
    delta_prim_mon_ret_svc_density = 0,
    delta_prim_tue_ret_svc_density = 0,
    delta_prim_wed_ret_svc_density = 0,
    delta_prim_thu_ret_svc_density = 0,
    delta_prim_fri_ret_svc_density = 0,
    delta_prim_sat_ret_svc_density = 0,
    delta_temp_sun_ret_svc_density = 0,
    delta_temp_mon_ret_svc_density = 0,
    delta_temp_tue_ret_svc_density = 0,
    delta_temp_wed_ret_svc_density = 0,
    delta_temp_thu_ret_svc_density = 0,
    delta_temp_fri_ret_svc_density = 0,
    delta_temp_sat_ret_svc_density = 0,
    delta_home_sun_ret_svc_density = 0,
    delta_home_mon_ret_svc_density = 0,
    delta_home_tue_ret_svc_density = 0,
    delta_home_wed_ret_svc_density = 0,
    delta_home_thu_ret_svc_density = 0,
    delta_home_fri_ret_svc_density = 0,
    delta_home_sat_ret_svc_density = 0,
    delta_prim_sun_transit_freq = 0,
    delta_prim_mon_transit_freq = 0,
    delta_prim_tue_transit_freq = 0,
    delta_prim_wed_transit_freq = 0,
    delta_prim_thu_transit_freq = 0,
    delta_prim_fri_transit_freq = 0,
    delta_prim_sat_transit_freq = 0,
    delta_temp_sun_transit_freq = 0,
    delta_temp_mon_transit_freq = 0,
    delta_temp_tue_transit_freq = 0,
    delta_temp_wed_transit_freq = 0,
    delta_temp_thu_transit_freq = 0,
    delta_temp_fri_transit_freq = 0,
    delta_temp_sat_transit_freq = 0,
    delta_home_sun_transit_freq = 0,
    delta_home_mon_transit_freq = 0,
    delta_home_tue_transit_freq = 0,
    delta_home_wed_transit_freq = 0,
    delta_home_thu_transit_freq = 0,
    delta_home_fri_transit_freq = 0,
    delta_home_sat_transit_freq = 0
  )

  assign("apollo_beta", apollo_beta, envir = globalenv())

  apollo_fixed <- c()

  assign("apollo_fixed", apollo_fixed, envir = globalenv())

  apollo_draws <- list(
    interDrawsType = "halton",
    interNDraws = 100,
    interUnifDraws = c(),
    interNormDraws = c("n_1", "n_2", "n_3", "n_4", "n_5"),
    intraDrawsType = "",
    intraNDraws = 0,
    intraUnifDraws = c(),
    intraNormDraws = c()
  )

  assign("apollo_draws", apollo_draws, envir = globalenv())

  apollo_randCoeff <- function(apollo_beta, apollo_inputs) {
    randcoeff <- list()

    randcoeff[["lv_1"]] <- n_1 +
      a_1_age_18_34 * (age == 1) +
      a_1_age_55plus * (age == 3) +
      a_1_income_150plus * (income == 4) +
      a_1_kids_kids * (kids == 1) +
      a_1_education_bachelorplus * (education12 >= 2) +
      a_1_jobtype12_administrative * (jobtype12 == 3) +
      a_1_neighborhood_nonurban * (neighborhood >= 2) +
      a_1_homeownership_nonown * (homeownership == 1)
    randcoeff[["lv_2"]] <- n_2 +
      a_2_age_18_34 * (age == 1) +
      a_2_age_55plus * (age == 3) +
      a_2_gender_women * (gender == 1) +
      a_2_kids_kids * (kids == 1) +
      a_2_neighborhood_suburban * (neighborhood == 2) +
      a_2_homeownership_nonown * (homeownership == 1)
    randcoeff[["lv_3"]] <- n_3 +
      a_3_age_18_34 * (age == 1) +
      a_3_income_150plus * (income == 4) +
      a_3_kids_kids * (kids == 1) +
      a_3_genderkids_women_kids * (gender == 1 & kids == 1) +
      a_3_education_bachelorplus * (education12 >= 2) +
      a_3_neighborhood_suburban * (neighborhood == 2)
    randcoeff[["lv_4"]] <- n_4 +
      a_4_jobtype12_administrative * (jobtype12 == 3) +
      a_4_neighborhood_nonurban * (neighborhood >= 2) +
      a_4_homeownership_nonown * (homeownership == 1)
    randcoeff[["lv_5"]] <- n_5 +
      a_5_age_18_34 * (age == 1) +
      a_5_age_55plus * (age == 3) +
      a_5_gender_women * (gender == 1) +
      a_5_income_150plus * (income == 4) +
      a_5_education_bachelorplus * (education12 >= 2) +
      a_5_jobtype12_nonmanual * (jobtype12 >= 2) +
      a_5_neighborhood_nonurban * (neighborhood >= 2)
    return(randcoeff)
  }

  assign("apollo_randCoeff", apollo_randCoeff, envir = globalenv())

  apollo_inputs <- apollo_validateInputs()

  assign("apollo_inputs", apollo_inputs, envir = globalenv())

  apollo_probabilities <-
    function(apollo_beta, apollo_inputs, functionality = "estimate") {
      apollo_attach(apollo_beta, apollo_inputs)
      on.exit(apollo_detach(apollo_beta, apollo_inputs))

      P <- list()

      normalDensity_settings01 <- list(outcomeNormal = att_01, xNormal = d_01_2 * lv_2, mu = 0, sigma = s_01_2)
      normalDensity_settings02 <- list(outcomeNormal = att_02, xNormal = d_02_4 * lv_4, mu = 0, sigma = s_02_4)
      normalDensity_settings03 <- list(outcomeNormal = att_03, xNormal = d_03_3 * lv_3, mu = 0, sigma = s_03_3)
      normalDensity_settings04 <- list(outcomeNormal = att_04, xNormal = d_04_1 * lv_1, mu = 0, sigma = s_04_1)
      normalDensity_settings05 <- list(outcomeNormal = att_05, xNormal = d_05_3 * lv_3, mu = 0, sigma = s_05_3)
      normalDensity_settings06 <- list(outcomeNormal = att_06, xNormal = d_06_5 * lv_5, mu = 0, sigma = s_06_5)
      normalDensity_settings07 <- list(outcomeNormal = att_07, xNormal = d_07_1 * lv_1, mu = 0, sigma = s_07_1)
      normalDensity_settings08 <- list(outcomeNormal = att_08, xNormal = d_08_3 * lv_3, mu = 0, sigma = s_08_3)
      normalDensity_settings09 <- list(outcomeNormal = att_09, xNormal = d_09_1 * lv_1, mu = 0, sigma = s_09_1)
      normalDensity_settings10 <- list(outcomeNormal = att_10, xNormal = d_10_3 * lv_3, mu = 0, sigma = s_10_3)
      normalDensity_settings11 <- list(outcomeNormal = att_11, xNormal = d_11_1 * lv_1, mu = 0, sigma = s_11_1)
      normalDensity_settings12 <- list(outcomeNormal = att_12, xNormal = d_12_1 * lv_1, mu = 0, sigma = s_12_1)
      normalDensity_settings13 <- list(outcomeNormal = att_13, xNormal = d_13_4 * lv_4, mu = 0, sigma = s_13_4)
      normalDensity_settings14 <- list(outcomeNormal = att_14, xNormal = d_14_1 * lv_1, mu = 0, sigma = s_14_1)
      normalDensity_settings15 <- list(outcomeNormal = att_15, xNormal = d_15_2 * lv_2, mu = 0, sigma = s_15_2)
      normalDensity_settings16 <- list(outcomeNormal = att_16, xNormal = d_16_1 * lv_1, mu = 0, sigma = s_16_1)
      normalDensity_settings17 <- list(outcomeNormal = att_17, xNormal = d_17_2 * lv_2, mu = 0, sigma = s_17_2)
      normalDensity_settings18 <- list(outcomeNormal = att_18, xNormal = d_18_2 * lv_2, mu = 0, sigma = s_18_2)
      normalDensity_settings19 <- list(outcomeNormal = att_19, xNormal = d_19_2 * lv_2, mu = 0, sigma = s_19_2)
      normalDensity_settings20 <- list(outcomeNormal = att_20, xNormal = d_20_5 * lv_5, mu = 0, sigma = s_20_5)
      normalDensity_settings21 <- list(outcomeNormal = att_21, xNormal = d_21_3 * lv_3, mu = 0, sigma = s_21_3)
      normalDensity_settings22 <- list(outcomeNormal = att_22, xNormal = d_22_1 * lv_1, mu = 0, sigma = s_22_1)
      normalDensity_settings23 <- list(outcomeNormal = att_23, xNormal = d_23_3 * lv_3, mu = 0, sigma = s_23_3)

      P[["att_01"]] <- apollo_normalDensity(normalDensity_settings01, functionality)
      P[["att_02"]] <- apollo_normalDensity(normalDensity_settings02, functionality)
      P[["att_03"]] <- apollo_normalDensity(normalDensity_settings03, functionality)
      P[["att_04"]] <- apollo_normalDensity(normalDensity_settings04, functionality)
      P[["att_05"]] <- apollo_normalDensity(normalDensity_settings05, functionality)
      P[["att_06"]] <- apollo_normalDensity(normalDensity_settings06, functionality)
      P[["att_07"]] <- apollo_normalDensity(normalDensity_settings07, functionality)
      P[["att_08"]] <- apollo_normalDensity(normalDensity_settings08, functionality)
      P[["att_09"]] <- apollo_normalDensity(normalDensity_settings09, functionality)
      P[["att_10"]] <- apollo_normalDensity(normalDensity_settings10, functionality)
      P[["att_11"]] <- apollo_normalDensity(normalDensity_settings11, functionality)
      P[["att_12"]] <- apollo_normalDensity(normalDensity_settings12, functionality)
      P[["att_13"]] <- apollo_normalDensity(normalDensity_settings13, functionality)
      P[["att_14"]] <- apollo_normalDensity(normalDensity_settings14, functionality)
      P[["att_15"]] <- apollo_normalDensity(normalDensity_settings15, functionality)
      P[["att_16"]] <- apollo_normalDensity(normalDensity_settings16, functionality)
      P[["att_17"]] <- apollo_normalDensity(normalDensity_settings17, functionality)
      P[["att_18"]] <- apollo_normalDensity(normalDensity_settings18, functionality)
      P[["att_19"]] <- apollo_normalDensity(normalDensity_settings19, functionality)
      P[["att_20"]] <- apollo_normalDensity(normalDensity_settings20, functionality)
      P[["att_21"]] <- apollo_normalDensity(normalDensity_settings21, functionality)
      P[["att_22"]] <- apollo_normalDensity(normalDensity_settings22, functionality)
      P[["att_23"]] <- apollo_normalDensity(normalDensity_settings23, functionality)

      V <- list()
      V[["cluster1"]] <- 0
      V[["cluster2"]] <- asc_2 +
        b_2_age_18_34 * (age == 1) +
        b_2_age_55plus * (age == 3) +
        b_2_gender_women * (gender == 1) +
        b_2_kids_kids * (kids == 1) +
        b_2_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_2_income_50minus * (income == 1) +
        b_2_income_100_149 * (income == 3) +
        b_2_income_150plus * (income == 4) +
        b_2_education_highschool * (education12 == 1) +
        b_2_education_graduate * (education12 == 3) +
        b_2_neighborhood_suburban * (neighborhood == 2) +
        b_2_neighborhood_town * (neighborhood == 3) +
        b_2_jobtype12_professional * (jobtype12 == 2) +
        b_2_jobtype12_administrative * (jobtype12 == 3) +
        b_2_homeownership_nonown * (homeownership == 1) +
        b_2_pop_density * pop_density +
        b_2_ret_svc_density * ret_svc_density +
        b_2_transit_freq * transit_freq_index +
        l_2_1 * lv_1 +
        l_2_2 * lv_2 +
        l_2_3 * lv_3 +
        l_2_4 * lv_4 +
        l_2_5 * lv_5
      V[["cluster3"]] <- asc_3 +
        b_3_age_18_34 * (age == 1) +
        b_3_age_55plus * (age == 3) +
        b_3_gender_women * (gender == 1) +
        b_3_kids_kids * (kids == 1) +
        b_3_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_3_income_50minus * (income == 1) +
        b_3_income_100_149 * (income == 3) +
        b_3_income_150plus * (income == 4) +
        b_3_education_highschool * (education12 == 1) +
        b_3_education_graduate * (education12 == 3) +
        b_3_neighborhood_suburban * (neighborhood == 2) +
        b_3_neighborhood_town * (neighborhood == 3) +
        b_3_jobtype12_professional * (jobtype12 == 2) +
        b_3_jobtype12_administrative * (jobtype12 == 3) +
        b_3_homeownership_nonown * (homeownership == 1) +
        b_3_pop_density * pop_density +
        b_3_ret_svc_density * ret_svc_density +
        b_3_transit_freq * transit_freq_index +
        l_3_1 * lv_1 +
        l_3_2 * lv_2 +
        l_3_3 * lv_3 +
        l_3_4 * lv_4 +
        l_3_5 * lv_5
      V[["cluster4"]] <- asc_4 +
        b_4_age_18_34 * (age == 1) +
        b_4_age_55plus * (age == 3) +
        b_4_gender_women * (gender == 1) +
        b_4_kids_kids * (kids == 1) +
        b_4_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_4_income_50minus * (income == 1) +
        b_4_income_100_149 * (income == 3) +
        b_4_income_150plus * (income == 4) +
        b_4_education_highschool * (education12 == 1) +
        b_4_education_graduate * (education12 == 3) +
        b_4_neighborhood_suburban * (neighborhood == 2) +
        b_4_neighborhood_town * (neighborhood == 3) +
        b_4_jobtype12_professional * (jobtype12 == 2) +
        b_4_jobtype12_administrative * (jobtype12 == 3) +
        b_4_homeownership_nonown * (homeownership == 1) +
        b_4_pop_density * pop_density +
        b_4_ret_svc_density * ret_svc_density +
        b_4_transit_freq * transit_freq_index +
        l_4_1 * lv_1 +
        l_4_2 * lv_2 +
        l_4_3 * lv_3 +
        l_4_4 * lv_4 +
        l_4_5 * lv_5
      V[["cluster5"]] <- asc_5 +
        b_5_age_18_34 * (age == 1) +
        b_5_age_55plus * (age == 3) +
        b_5_gender_women * (gender == 1) +
        b_5_kids_kids * (kids == 1) +
        b_5_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_5_income_50minus * (income == 1) +
        b_5_income_100_149 * (income == 3) +
        b_5_income_150plus * (income == 4) +
        b_5_education_highschool * (education12 == 1) +
        b_5_education_graduate * (education12 == 3) +
        b_5_neighborhood_suburban * (neighborhood == 2) +
        b_5_neighborhood_town * (neighborhood == 3) +
        b_5_jobtype12_professional * (jobtype12 == 2) +
        b_5_jobtype12_administrative * (jobtype12 == 3) +
        b_5_homeownership_nonown * (homeownership == 1) +
        b_5_pop_density * pop_density +
        b_5_ret_svc_density * ret_svc_density +
        b_5_transit_freq * transit_freq_index +
        l_5_1 * lv_1 +
        l_5_2 * lv_2 +
        l_5_3 * lv_3 +
        l_5_4 * lv_4 +
        l_5_5 * lv_5
      V[["cluster6"]] <- asc_6 +
        b_6_age_18_34 * (age == 1) +
        b_6_age_55plus * (age == 3) +
        b_6_gender_women * (gender == 1) +
        b_6_kids_kids * (kids == 1) +
        b_6_genderkids_women_kids * (gender == 1 & kids == 1) +
        b_6_income_50minus * (income == 1) +
        b_6_income_100_149 * (income == 3) +
        b_6_income_150plus * (income == 4) +
        b_6_education_highschool * (education12 == 1) +
        b_6_education_graduate * (education12 == 3) +
        b_6_neighborhood_suburban * (neighborhood == 2) +
        b_6_neighborhood_town * (neighborhood == 3) +
        b_6_jobtype12_professional * (jobtype12 == 2) +
        b_6_jobtype12_administrative * (jobtype12 == 3) +
        b_6_homeownership_nonown * (homeownership == 1) +
        b_6_pop_density * pop_density +
        b_6_ret_svc_density * ret_svc_density +
        b_6_transit_freq * transit_freq_index +
        l_6_1 * lv_1 +
        l_6_2 * lv_2 +
        l_6_3 * lv_3 +
        l_6_4 * lv_4 +
        l_6_5 * lv_5

      mnl_settings <- list(
        alternatives = c(
          cluster1 = 1,
          cluster2 = 2,
          cluster3 = 3,
          cluster4 = 4,
          cluster5 = 5,
          cluster6 = 6
        ),
        avail = 1,
        choiceVar = cluster,
        utilities = V
      )

      P[["choice"]] <- apollo_mnl(mnl_settings, functionality)

      P <- apollo_combineModels(P, apollo_inputs, functionality)
      P <- apollo_avgInterDraws(P, apollo_inputs, functionality)
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

data <- read_sav(
  file.path(
    "..",
    "Dataset",
    "covid19-2023-merged-processed.sav"
  )
)

exec_mdcev()
apollo_sink()

model <- readRDS(
  file.path("output", "iclv", "iclv_cluster_1_model.rds")
)

output_df <- apollo_modelOutput(
  model,
  modelOutput_settings = list(
    printPVal = TRUE
  )
)

write_csv(
  output_df %>%
    as.data.frame() %>%
    .[, c(1, 7)] %>%
    tibble() %>%
    mutate(
      row_names = rownames(output_df)
    ) %>%
    select(
      row_names,
      everything()
    ) %>%
    as.data.frame(),
  file = file.path("output", "iclv", "iclv_cluster_1_model.csv"),
)
