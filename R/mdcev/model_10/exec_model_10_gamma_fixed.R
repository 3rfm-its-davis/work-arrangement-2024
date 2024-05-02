exec_model_10_gamma_fixed <- function(day) {
  database <- get("data", envir = globalenv()) %>%
    filter(C5_2a > 0) %>%
    select(
      row_index,
      agk,
      income,
      education,
      impedance,
      capability,
      commute,
      employment,
      flexibility,
      neighborhood,
      factor_1,
      factor_2,
      factor_3,
      matches(
        paste0("hours_day_", day, "_")
      )
    ) %>%
    rename_all(
      ~ str_replace(., paste0("hours_day_", day, "_"), "")
    ) %>%
    filter(
      period_1 + period_2 + period_3 + period_4 > 0 &
        period_1 + period_2 + period_3 + period_4 < 24
    ) %>%
    mutate_all(as.numeric)

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName       = paste0("model_10_gamma_fixed_", day),
    modelDescr      = "
  Budget: 24
  Fixed: Gamma
  I.V.
  - Gender
  - Age
  - Income
  - Education
  - Travel impedance
  - Occupation type
  - Primary commute mode
  - Employment status
  - Factor scores",
    indivID         = "row_index",
    outputDirectory = file.path("output", "mdcev", "model_10")
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    gamma_base = 1,
    alpha_prim_ampk = 1,
    alpha_prim_mddy = 1,
    alpha_prim_pmpk = 1,
    alpha_prim_offt = 1,
    alpha_temp_ampk = 1,
    alpha_temp_mddy = 1,
    alpha_temp_pmpk = 1,
    alpha_temp_offt = 1,
    alpha_home_ampk = 1,
    alpha_home_mddy = 1,
    alpha_home_pmpk = 1,
    alpha_home_offt = 1,
    delta_prim = 0,
    delta_temp = 0,
    delta_home = 0,
    delta_mddy = 0,
    delta_pmpk = 0,
    delta_offt = 0,
    delta_prim_agk_30_44_woman_nokids = 0,
    delta_temp_agk_30_44_woman_nokids = 0,
    delta_home_agk_30_44_woman_nokids = 0,
    delta_mddy_agk_30_44_woman_nokids = 0,
    delta_pmpk_agk_30_44_woman_nokids = 0,
    delta_offt_agk_30_44_woman_nokids = 0,
    delta_prim_agk_30_44_man_kids = 0,
    delta_temp_agk_30_44_man_kids = 0,
    delta_home_agk_30_44_man_kids = 0,
    delta_mddy_agk_30_44_man_kids = 0,
    delta_pmpk_agk_30_44_man_kids = 0,
    delta_offt_agk_30_44_man_kids = 0,
    delta_prim_agk_30_44_man_nokids = 0,
    delta_temp_agk_30_44_man_nokids = 0,
    delta_home_agk_30_44_man_nokids = 0,
    delta_mddy_agk_30_44_man_nokids = 0,
    delta_pmpk_agk_30_44_man_nokids = 0,
    delta_offt_agk_30_44_man_nokids = 0,
    delta_prim_agk_18_29_woman = 0,
    delta_temp_agk_18_29_woman = 0,
    delta_home_agk_18_29_woman = 0,
    delta_mddy_agk_18_29_woman = 0,
    delta_pmpk_agk_18_29_woman = 0,
    delta_offt_agk_18_29_woman = 0,
    delta_prim_agk_18_29_man = 0,
    delta_temp_agk_18_29_man = 0,
    delta_home_agk_18_29_man = 0,
    delta_mddy_agk_18_29_man = 0,
    delta_pmpk_agk_18_29_man = 0,
    delta_offt_agk_18_29_man = 0,
    delta_prim_agk_45_64_woman = 0,
    delta_temp_agk_45_64_woman = 0,
    delta_home_agk_45_64_woman = 0,
    delta_mddy_agk_45_64_woman = 0,
    delta_pmpk_agk_45_64_woman = 0,
    delta_offt_agk_45_64_woman = 0,
    delta_prim_agk_45_64_man = 0,
    delta_temp_agk_45_64_man = 0,
    delta_home_agk_45_64_man = 0,
    delta_mddy_agk_45_64_man = 0,
    delta_pmpk_agk_45_64_man = 0,
    delta_offt_agk_45_64_man = 0,
    delta_prim_agk_65plus_woman = 0,
    delta_temp_agk_65plus_woman = 0,
    delta_home_agk_65plus_woman = 0,
    delta_mddy_agk_65plus_woman = 0,
    delta_pmpk_agk_65plus_woman = 0,
    delta_offt_agk_65plus_woman = 0,
    delta_prim_agk_65plus_man = 0,
    delta_temp_agk_65plus_man = 0,
    delta_home_agk_65plus_man = 0,
    delta_mddy_agk_65plus_man = 0,
    delta_pmpk_agk_65plus_man = 0,
    delta_offt_agk_65plus_man = 0,
    delta_prim_income_50_99 = 0,
    delta_temp_income_50_99 = 0,
    delta_home_income_50_99 = 0,
    delta_mddy_income_50_99 = 0,
    delta_pmpk_income_50_99 = 0,
    delta_offt_income_50_99 = 0,
    delta_prim_income_100_149 = 0,
    delta_temp_income_100_149 = 0,
    delta_home_income_100_149 = 0,
    delta_mddy_income_100_149 = 0,
    delta_pmpk_income_100_149 = 0,
    delta_offt_income_100_149 = 0,
    delta_prim_income_150plus = 0,
    delta_temp_income_150plus = 0,
    delta_home_income_150plus = 0,
    delta_mddy_income_150plus = 0,
    delta_pmpk_income_150plus = 0,
    delta_offt_income_150plus = 0,
    delta_prim_education_college = 0,
    delta_temp_education_college = 0,
    delta_home_education_college = 0,
    delta_mddy_education_college = 0,
    delta_pmpk_education_college = 0,
    delta_offt_education_college = 0,
    delta_prim_education_graduate = 0,
    delta_temp_education_graduate = 0,
    delta_home_education_graduate = 0,
    delta_mddy_education_graduate = 0,
    delta_pmpk_education_graduate = 0,
    delta_offt_education_graduate = 0,
    delta_prim_impedance_20_39 = 0,
    delta_temp_impedance_20_39 = 0,
    delta_home_impedance_20_39 = 0,
    delta_mddy_impedance_20_39 = 0,
    delta_pmpk_impedance_20_39 = 0,
    delta_offt_impedance_20_39 = 0,
    delta_prim_impedance_40_59 = 0,
    delta_temp_impedance_40_59 = 0,
    delta_home_impedance_40_59 = 0,
    delta_mddy_impedance_40_59 = 0,
    delta_pmpk_impedance_40_59 = 0,
    delta_offt_impedance_40_59 = 0,
    delta_prim_impedance_60plus = 0,
    delta_temp_impedance_60plus = 0,
    delta_home_impedance_60plus = 0,
    delta_mddy_impedance_60plus = 0,
    delta_pmpk_impedance_60plus = 0,
    delta_offt_impedance_60plus = 0,
    delta_prim_capability_mid = 0,
    delta_temp_capability_mid = 0,
    delta_home_capability_mid = 0,
    delta_mddy_capability_mid = 0,
    delta_pmpk_capability_mid = 0,
    delta_offt_capability_mid = 0,
    delta_prim_capability_high = 0,
    delta_temp_capability_high = 0,
    delta_home_capability_high = 0,
    delta_mddy_capability_high = 0,
    delta_pmpk_capability_high = 0,
    delta_offt_capability_high = 0,
    delta_prim_commute_car = 0,
    delta_temp_commute_car = 0,
    delta_home_commute_car = 0,
    delta_mddy_commute_car = 0,
    delta_pmpk_commute_car = 0,
    delta_offt_commute_car = 0,
    delta_prim_employment_part_time = 0,
    delta_temp_employment_part_time = 0,
    delta_home_employment_part_time = 0,
    delta_mddy_employment_part_time = 0,
    delta_pmpk_employment_part_time = 0,
    delta_offt_employment_part_time = 0,
    delta_prim_neighborhood_suburban = 0,
    delta_temp_neighborhood_suburban = 0,
    delta_home_neighborhood_suburban = 0,
    delta_mddy_neighborhood_suburban = 0,
    delta_pmpk_neighborhood_suburban = 0,
    delta_offt_neighborhood_suburban = 0,
    delta_prim_neighborhood_town_rural = 0,
    delta_temp_neighborhood_town_rural = 0,
    delta_home_neighborhood_town_rural = 0,
    delta_mddy_neighborhood_town_rural = 0,
    delta_pmpk_neighborhood_town_rural = 0,
    delta_offt_neighborhood_town_rural = 0,
    delta_prim_flexibility_some = 0,
    delta_temp_flexibility_some = 0,
    delta_home_flexibility_some = 0,
    delta_mddy_flexibility_some = 0,
    delta_pmpk_flexibility_some = 0,
    delta_offt_flexibility_some = 0,
    delta_prim_flexibility_absolute = 0,
    delta_temp_flexibility_absolute = 0,
    delta_home_flexibility_absolute = 0,
    delta_mddy_flexibility_absolute = 0,
    delta_pmpk_flexibility_absolute = 0,
    delta_offt_flexibility_absolute = 0,
    delta_prim_factor_score_1 = 0,
    delta_temp_factor_score_1 = 0,
    delta_home_factor_score_1 = 0,
    delta_mddy_factor_score_1 = 0,
    delta_pmpk_factor_score_1 = 0,
    delta_offt_factor_score_1 = 0,
    delta_prim_factor_score_2 = 0,
    delta_temp_factor_score_2 = 0,
    delta_home_factor_score_2 = 0,
    delta_mddy_factor_score_2 = 0,
    delta_pmpk_factor_score_2 = 0,
    delta_offt_factor_score_2 = 0,
    delta_prim_factor_score_3 = 0,
    delta_temp_factor_score_3 = 0,
    delta_home_factor_score_3 = 0,
    delta_mddy_factor_score_3 = 0,
    delta_pmpk_factor_score_3 = 0,
    delta_offt_factor_score_3 = 0,
    sig_base = 1
  )

  assign("apollo_beta", apollo_beta, envir = globalenv())

  apollo_fixed <- c("sig_base", "gamma_base")

  assign("apollo_fixed", apollo_fixed, envir = globalenv())

  apollo_inputs <- apollo_validateInputs()

  assign("apollo_inputs", apollo_inputs, envir = globalenv())

  apollo_probabilities <-
    function(apollo_beta, apollo_inputs, functionality = "estimate") {
      apollo_attach(apollo_beta, apollo_inputs)
      on.exit(apollo_detach(apollo_beta, apollo_inputs))

      P <- list()

      alternatives <- c(
        "outside",
        "prim_ampk",
        "temp_ampk",
        "home_ampk",
        "prim_mddy",
        "temp_mddy",
        "home_mddy",
        "prim_pmpk",
        "temp_pmpk",
        "home_pmpk",
        "prim_offt",
        "temp_offt",
        "home_offt"
      )

      avail <- list(
        outside = 1,
        prim_ampk = 1,
        temp_ampk = 1,
        home_ampk = 1,
        prim_mddy = 1,
        temp_mddy = 1,
        home_mddy = 1,
        prim_pmpk = 1,
        temp_pmpk = 1,
        home_pmpk = 1,
        prim_offt = 1,
        temp_offt = 1,
        home_offt = 1
      )

      continuousChoice <- list(
        outside = 24 - period_1 - period_2 - period_3 - period_4,
        prim_ampk = period_1_place_1,
        temp_ampk = period_1_place_2,
        home_ampk = period_1_place_3,
        prim_mddy = period_2_place_1,
        temp_mddy = period_2_place_2,
        home_mddy = period_2_place_3,
        prim_pmpk = period_3_place_1,
        temp_pmpk = period_3_place_2,
        home_pmpk = period_3_place_3,
        prim_offt = period_4_place_1,
        temp_offt = period_4_place_2,
        home_offt = period_4_place_3
      )

      V <- list()
      V[["outside"]] <- 0
      V[["prim_ampk"]] <- delta_prim +
        delta_prim_agk_30_44_woman_nokids * (agk == 4) +
        delta_prim_agk_30_44_man_kids * (agk == 5) +
        delta_prim_agk_30_44_man_nokids * (agk == 6) +
        delta_prim_agk_18_29_woman * (agk == 1) +
        delta_prim_agk_18_29_man * (agk == 2) +
        delta_prim_agk_45_64_woman * (agk == 7) +
        delta_prim_agk_45_64_man * (agk == 8) +
        delta_prim_agk_65plus_woman * (agk == 9) +
        delta_prim_agk_65plus_man * (agk == 10) +
        delta_prim_income_50_99 * (income == 2) +
        delta_prim_income_100_149 * (income == 3) +
        delta_prim_income_150plus * (income == 4) +
        delta_prim_education_college * (education == 2) +
        delta_prim_education_graduate * (education == 3) +
        delta_prim_impedance_20_39 * (impedance == 2) +
        delta_prim_impedance_40_59 * (impedance == 3) +
        delta_prim_impedance_60plus * (impedance == 4) +
        delta_prim_capability_mid * (capability == 2) +
        delta_prim_capability_high * (capability == 3) +
        delta_prim_commute_car * (commute == 1) +
        delta_prim_employment_part_time * (employment == 0) +
        delta_prim_neighborhood_suburban * (neighborhood == 2) +
        delta_prim_neighborhood_town_rural * (neighborhood == 1) +
        delta_prim_flexibility_some * (flexibility == 1) +
        delta_prim_flexibility_absolute * (flexibility == 2) +
        delta_prim_factor_score_1 * factor_1 +
        delta_prim_factor_score_2 * factor_2 +
        delta_prim_factor_score_3 * factor_3
      V[["prim_mddy"]] <- delta_prim +
        delta_prim_agk_30_44_woman_nokids * (agk == 4) +
        delta_prim_agk_30_44_man_kids * (agk == 5) +
        delta_prim_agk_30_44_man_nokids * (agk == 6) +
        delta_prim_agk_18_29_woman * (agk == 1) +
        delta_prim_agk_18_29_man * (agk == 2) +
        delta_prim_agk_45_64_woman * (agk == 7) +
        delta_prim_agk_45_64_man * (agk == 8) +
        delta_prim_agk_65plus_woman * (agk == 9) +
        delta_prim_agk_65plus_man * (agk == 10) +
        delta_prim_income_50_99 * (income == 2) +
        delta_prim_income_100_149 * (income == 3) +
        delta_prim_income_150plus * (income == 4) +
        delta_prim_education_college * (education == 2) +
        delta_prim_education_graduate * (education == 3) +
        delta_prim_impedance_20_39 * (impedance == 2) +
        delta_prim_impedance_40_59 * (impedance == 3) +
        delta_prim_impedance_60plus * (impedance == 4) +
        delta_prim_capability_mid * (capability == 2) +
        delta_prim_capability_high * (capability == 3) +
        delta_prim_commute_car * (commute == 1) +
        delta_prim_employment_part_time * (employment == 0) +
        delta_prim_neighborhood_suburban * (neighborhood == 2) +
        delta_prim_neighborhood_town_rural * (neighborhood == 1) +
        delta_prim_flexibility_some * (flexibility == 1) +
        delta_prim_flexibility_absolute * (flexibility == 2) +
        delta_prim_factor_score_1 * factor_1 +
        delta_prim_factor_score_2 * factor_2 +
        delta_prim_factor_score_3 * factor_3 +
        delta_mddy +
        delta_mddy_agk_30_44_woman_nokids * (agk == 4) +
        delta_mddy_agk_30_44_man_kids * (agk == 5) +
        delta_mddy_agk_30_44_man_nokids * (agk == 6) +
        delta_mddy_agk_18_29_woman * (agk == 1) +
        delta_mddy_agk_18_29_man * (agk == 2) +
        delta_mddy_agk_45_64_woman * (agk == 7) +
        delta_mddy_agk_45_64_man * (agk == 8) +
        delta_mddy_agk_65plus_woman * (agk == 9) +
        delta_mddy_agk_65plus_man * (agk == 10) +
        delta_mddy_income_50_99 * (income == 2) +
        delta_mddy_income_100_149 * (income == 3) +
        delta_mddy_income_150plus * (income == 4) +
        delta_mddy_education_college * (education == 2) +
        delta_mddy_education_graduate * (education == 3) +
        delta_mddy_impedance_20_39 * (impedance == 2) +
        delta_mddy_impedance_40_59 * (impedance == 3) +
        delta_mddy_impedance_60plus * (impedance == 4) +
        delta_mddy_capability_mid * (capability == 2) +
        delta_mddy_capability_high * (capability == 3) +
        delta_mddy_commute_car * (commute == 1) +
        delta_mddy_employment_part_time * (employment == 0) +
        delta_mddy_neighborhood_suburban * (neighborhood == 2) +
        delta_mddy_neighborhood_town_rural * (neighborhood == 1) +
        delta_mddy_flexibility_some * (flexibility == 1) +
        delta_mddy_flexibility_absolute * (flexibility == 2) +
        delta_mddy_factor_score_1 * factor_1 +
        delta_mddy_factor_score_2 * factor_2 +
        delta_mddy_factor_score_3 * factor_3
      V[["prim_pmpk"]] <- delta_prim +
        delta_prim_agk_30_44_woman_nokids * (agk == 4) +
        delta_prim_agk_30_44_man_kids * (agk == 5) +
        delta_prim_agk_30_44_man_nokids * (agk == 6) +
        delta_prim_agk_18_29_woman * (agk == 1) +
        delta_prim_agk_18_29_man * (agk == 2) +
        delta_prim_agk_45_64_woman * (agk == 7) +
        delta_prim_agk_45_64_man * (agk == 8) +
        delta_prim_agk_65plus_woman * (agk == 9) +
        delta_prim_agk_65plus_man * (agk == 10) +
        delta_prim_income_50_99 * (income == 2) +
        delta_prim_income_100_149 * (income == 3) +
        delta_prim_income_150plus * (income == 4) +
        delta_prim_education_college * (education == 2) +
        delta_prim_education_graduate * (education == 3) +
        delta_prim_impedance_20_39 * (impedance == 2) +
        delta_prim_impedance_40_59 * (impedance == 3) +
        delta_prim_impedance_60plus * (impedance == 4) +
        delta_prim_capability_mid * (capability == 2) +
        delta_prim_capability_high * (capability == 3) +
        delta_prim_commute_car * (commute == 1) +
        delta_prim_employment_part_time * (employment == 0) +
        delta_prim_neighborhood_suburban * (neighborhood == 2) +
        delta_prim_neighborhood_town_rural * (neighborhood == 1) +
        delta_prim_flexibility_some * (flexibility == 1) +
        delta_prim_flexibility_absolute * (flexibility == 2) +
        delta_prim_factor_score_1 * factor_1 +
        delta_prim_factor_score_2 * factor_2 +
        delta_prim_factor_score_3 * factor_3 +
        delta_pmpk +
        delta_pmpk_agk_30_44_woman_nokids * (agk == 4) +
        delta_pmpk_agk_30_44_man_kids * (agk == 5) +
        delta_pmpk_agk_30_44_man_nokids * (agk == 6) +
        delta_pmpk_agk_18_29_woman * (agk == 1) +
        delta_pmpk_agk_18_29_man * (agk == 2) +
        delta_pmpk_agk_45_64_woman * (agk == 7) +
        delta_pmpk_agk_45_64_man * (agk == 8) +
        delta_pmpk_agk_65plus_woman * (agk == 9) +
        delta_pmpk_agk_65plus_man * (agk == 10) +
        delta_pmpk_income_50_99 * (income == 2) +
        delta_pmpk_income_100_149 * (income == 3) +
        delta_pmpk_income_150plus * (income == 4) +
        delta_pmpk_education_college * (education == 2) +
        delta_pmpk_education_graduate * (education == 3) +
        delta_pmpk_impedance_20_39 * (impedance == 2) +
        delta_pmpk_impedance_40_59 * (impedance == 3) +
        delta_pmpk_impedance_60plus * (impedance == 4) +
        delta_pmpk_capability_mid * (capability == 2) +
        delta_pmpk_capability_high * (capability == 3) +
        delta_pmpk_commute_car * (commute == 1) +
        delta_pmpk_employment_part_time * (employment == 0) +
        delta_pmpk_neighborhood_suburban * (neighborhood == 2) +
        delta_pmpk_neighborhood_town_rural * (neighborhood == 1) +
        delta_pmpk_flexibility_some * (flexibility == 1) +
        delta_pmpk_flexibility_absolute * (flexibility == 2) +
        delta_pmpk_factor_score_1 * factor_1 +
        delta_pmpk_factor_score_2 * factor_2 +
        delta_pmpk_factor_score_3 * factor_3
      V[["prim_offt"]] <- delta_prim +
        delta_prim_agk_30_44_woman_nokids * (agk == 4) +
        delta_prim_agk_30_44_man_kids * (agk == 5) +
        delta_prim_agk_30_44_man_nokids * (agk == 6) +
        delta_prim_agk_18_29_woman * (agk == 1) +
        delta_prim_agk_18_29_man * (agk == 2) +
        delta_prim_agk_45_64_woman * (agk == 7) +
        delta_prim_agk_45_64_man * (agk == 8) +
        delta_prim_agk_65plus_woman * (agk == 9) +
        delta_prim_agk_65plus_man * (agk == 10) +
        delta_prim_income_50_99 * (income == 2) +
        delta_prim_income_100_149 * (income == 3) +
        delta_prim_income_150plus * (income == 4) +
        delta_prim_education_college * (education == 2) +
        delta_prim_education_graduate * (education == 3) +
        delta_prim_impedance_20_39 * (impedance == 2) +
        delta_prim_impedance_40_59 * (impedance == 3) +
        delta_prim_impedance_60plus * (impedance == 4) +
        delta_prim_capability_mid * (capability == 2) +
        delta_prim_capability_high * (capability == 3) +
        delta_prim_commute_car * (commute == 1) +
        delta_prim_employment_part_time * (employment == 0) +
        delta_prim_neighborhood_suburban * (neighborhood == 2) +
        delta_prim_neighborhood_town_rural * (neighborhood == 1) +
        delta_prim_flexibility_some * (flexibility == 1) +
        delta_prim_flexibility_absolute * (flexibility == 2) +
        delta_prim_factor_score_1 * factor_1 +
        delta_prim_factor_score_2 * factor_2 +
        delta_prim_factor_score_3 * factor_3 +
        delta_offt +
        delta_offt_agk_30_44_woman_nokids * (agk == 4) +
        delta_offt_agk_30_44_man_kids * (agk == 5) +
        delta_offt_agk_30_44_man_nokids * (agk == 6) +
        delta_offt_agk_18_29_woman * (agk == 1) +
        delta_offt_agk_18_29_man * (agk == 2) +
        delta_offt_agk_45_64_woman * (agk == 7) +
        delta_offt_agk_45_64_man * (agk == 8) +
        delta_offt_agk_65plus_woman * (agk == 9) +
        delta_offt_agk_65plus_man * (agk == 10) +
        delta_offt_income_50_99 * (income == 2) +
        delta_offt_income_100_149 * (income == 3) +
        delta_offt_income_150plus * (income == 4) +
        delta_offt_education_college * (education == 2) +
        delta_offt_education_graduate * (education == 3) +
        delta_offt_impedance_20_39 * (impedance == 2) +
        delta_offt_impedance_40_59 * (impedance == 3) +
        delta_offt_impedance_60plus * (impedance == 4) +
        delta_offt_capability_mid * (capability == 2) +
        delta_offt_capability_high * (capability == 3) +
        delta_offt_commute_car * (commute == 1) +
        delta_offt_employment_part_time * (employment == 0) +
        delta_offt_neighborhood_suburban * (neighborhood == 2) +
        delta_offt_neighborhood_town_rural * (neighborhood == 1) +
        delta_offt_flexibility_some * (flexibility == 1) +
        delta_offt_flexibility_absolute * (flexibility == 2) +
        delta_offt_factor_score_1 * factor_1 +
        delta_offt_factor_score_2 * factor_2 +
        delta_offt_factor_score_3 * factor_3
      V[["temp_ampk"]] <- delta_temp +
        delta_temp_agk_30_44_woman_nokids * (agk == 4) +
        delta_temp_agk_30_44_man_kids * (agk == 5) +
        delta_temp_agk_30_44_man_nokids * (agk == 6) +
        delta_temp_agk_18_29_woman * (agk == 1) +
        delta_temp_agk_18_29_man * (agk == 2) +
        delta_temp_agk_45_64_woman * (agk == 7) +
        delta_temp_agk_45_64_man * (agk == 8) +
        delta_temp_agk_65plus_woman * (agk == 9) +
        delta_temp_agk_65plus_man * (agk == 10) +
        delta_temp_income_50_99 * (income == 2) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_college * (education == 2) +
        delta_temp_education_graduate * (education == 3) +
        delta_temp_impedance_20_39 * (impedance == 2) +
        delta_temp_impedance_40_59 * (impedance == 3) +
        delta_temp_impedance_60plus * (impedance == 4) +
        delta_temp_capability_mid * (capability == 2) +
        delta_temp_capability_high * (capability == 3) +
        delta_temp_commute_car * (commute == 1) +
        delta_temp_employment_part_time * (employment == 0) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town_rural * (neighborhood == 1) +
        delta_temp_flexibility_some * (flexibility == 1) +
        delta_temp_flexibility_absolute * (flexibility == 2) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3
      V[["temp_mddy"]] <- delta_temp +
        delta_temp_agk_30_44_woman_nokids * (agk == 4) +
        delta_temp_agk_30_44_man_kids * (agk == 5) +
        delta_temp_agk_30_44_man_nokids * (agk == 6) +
        delta_temp_agk_18_29_woman * (agk == 1) +
        delta_temp_agk_18_29_man * (agk == 2) +
        delta_temp_agk_45_64_woman * (agk == 7) +
        delta_temp_agk_45_64_man * (agk == 8) +
        delta_temp_agk_65plus_woman * (agk == 9) +
        delta_temp_agk_65plus_man * (agk == 10) +
        delta_temp_income_50_99 * (income == 2) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_college * (education == 2) +
        delta_temp_education_graduate * (education == 3) +
        delta_temp_impedance_20_39 * (impedance == 2) +
        delta_temp_impedance_40_59 * (impedance == 3) +
        delta_temp_impedance_60plus * (impedance == 4) +
        delta_temp_capability_mid * (capability == 2) +
        delta_temp_capability_high * (capability == 3) +
        delta_temp_commute_car * (commute == 1) +
        delta_temp_employment_part_time * (employment == 0) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town_rural * (neighborhood == 1) +
        delta_temp_flexibility_some * (flexibility == 1) +
        delta_temp_flexibility_absolute * (flexibility == 2) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3 +
        delta_mddy +
        delta_mddy_agk_30_44_woman_nokids * (agk == 4) +
        delta_mddy_agk_30_44_man_kids * (agk == 5) +
        delta_mddy_agk_30_44_man_nokids * (agk == 6) +
        delta_mddy_agk_18_29_woman * (agk == 1) +
        delta_mddy_agk_18_29_man * (agk == 2) +
        delta_mddy_agk_45_64_woman * (agk == 7) +
        delta_mddy_agk_45_64_man * (agk == 8) +
        delta_mddy_agk_65plus_woman * (agk == 9) +
        delta_mddy_agk_65plus_man * (agk == 10) +
        delta_mddy_income_50_99 * (income == 2) +
        delta_mddy_income_100_149 * (income == 3) +
        delta_mddy_income_150plus * (income == 4) +
        delta_mddy_education_college * (education == 2) +
        delta_mddy_education_graduate * (education == 3) +
        delta_mddy_impedance_20_39 * (impedance == 2) +
        delta_mddy_impedance_40_59 * (impedance == 3) +
        delta_mddy_impedance_60plus * (impedance == 4) +
        delta_mddy_capability_mid * (capability == 2) +
        delta_mddy_capability_high * (capability == 3) +
        delta_mddy_commute_car * (commute == 1) +
        delta_mddy_employment_part_time * (employment == 0) +
        delta_mddy_neighborhood_suburban * (neighborhood == 2) +
        delta_mddy_neighborhood_town_rural * (neighborhood == 1) +
        delta_mddy_flexibility_some * (flexibility == 1) +
        delta_mddy_flexibility_absolute * (flexibility == 2) +
        delta_mddy_factor_score_1 * factor_1 +
        delta_mddy_factor_score_2 * factor_2 +
        delta_mddy_factor_score_3 * factor_3
      V[["temp_pmpk"]] <- delta_temp +
        delta_temp_agk_30_44_woman_nokids * (agk == 4) +
        delta_temp_agk_30_44_man_kids * (agk == 5) +
        delta_temp_agk_30_44_man_nokids * (agk == 6) +
        delta_temp_agk_18_29_woman * (agk == 1) +
        delta_temp_agk_18_29_man * (agk == 2) +
        delta_temp_agk_45_64_woman * (agk == 7) +
        delta_temp_agk_45_64_man * (agk == 8) +
        delta_temp_agk_65plus_woman * (agk == 9) +
        delta_temp_agk_65plus_man * (agk == 10) +
        delta_temp_income_50_99 * (income == 2) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_college * (education == 2) +
        delta_temp_education_graduate * (education == 3) +
        delta_temp_impedance_20_39 * (impedance == 2) +
        delta_temp_impedance_40_59 * (impedance == 3) +
        delta_temp_impedance_60plus * (impedance == 4) +
        delta_temp_capability_mid * (capability == 2) +
        delta_temp_capability_high * (capability == 3) +
        delta_temp_commute_car * (commute == 1) +
        delta_temp_employment_part_time * (employment == 0) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town_rural * (neighborhood == 1) +
        delta_temp_flexibility_some * (flexibility == 1) +
        delta_temp_flexibility_absolute * (flexibility == 2) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3 +
        delta_pmpk +
        delta_pmpk_agk_30_44_woman_nokids * (agk == 4) +
        delta_pmpk_agk_30_44_man_kids * (agk == 5) +
        delta_pmpk_agk_30_44_man_nokids * (agk == 6) +
        delta_pmpk_agk_18_29_woman * (agk == 1) +
        delta_pmpk_agk_18_29_man * (agk == 2) +
        delta_pmpk_agk_45_64_woman * (agk == 7) +
        delta_pmpk_agk_45_64_man * (agk == 8) +
        delta_pmpk_agk_65plus_woman * (agk == 9) +
        delta_pmpk_agk_65plus_man * (agk == 10) +
        delta_pmpk_income_50_99 * (income == 2) +
        delta_pmpk_income_100_149 * (income == 3) +
        delta_pmpk_income_150plus * (income == 4) +
        delta_pmpk_education_college * (education == 2) +
        delta_pmpk_education_graduate * (education == 3) +
        delta_pmpk_impedance_20_39 * (impedance == 2) +
        delta_pmpk_impedance_40_59 * (impedance == 3) +
        delta_pmpk_impedance_60plus * (impedance == 4) +
        delta_pmpk_capability_mid * (capability == 2) +
        delta_pmpk_capability_high * (capability == 3) +
        delta_pmpk_commute_car * (commute == 1) +
        delta_pmpk_employment_part_time * (employment == 0) +
        delta_pmpk_neighborhood_suburban * (neighborhood == 2) +
        delta_pmpk_neighborhood_town_rural * (neighborhood == 1) +
        delta_pmpk_flexibility_some * (flexibility == 1) +
        delta_pmpk_flexibility_absolute * (flexibility == 2) +
        delta_pmpk_factor_score_1 * factor_1 +
        delta_pmpk_factor_score_2 * factor_2 +
        delta_pmpk_factor_score_3 * factor_3
      V[["temp_offt"]] <- delta_temp +
        delta_temp_agk_30_44_woman_nokids * (agk == 4) +
        delta_temp_agk_30_44_man_kids * (agk == 5) +
        delta_temp_agk_30_44_man_nokids * (agk == 6) +
        delta_temp_agk_18_29_woman * (agk == 1) +
        delta_temp_agk_18_29_man * (agk == 2) +
        delta_temp_agk_45_64_woman * (agk == 7) +
        delta_temp_agk_45_64_man * (agk == 8) +
        delta_temp_agk_65plus_woman * (agk == 9) +
        delta_temp_agk_65plus_man * (agk == 10) +
        delta_temp_income_50_99 * (income == 2) +
        delta_temp_income_100_149 * (income == 3) +
        delta_temp_income_150plus * (income == 4) +
        delta_temp_education_college * (education == 2) +
        delta_temp_education_graduate * (education == 3) +
        delta_temp_impedance_20_39 * (impedance == 2) +
        delta_temp_impedance_40_59 * (impedance == 3) +
        delta_temp_impedance_60plus * (impedance == 4) +
        delta_temp_capability_mid * (capability == 2) +
        delta_temp_capability_high * (capability == 3) +
        delta_temp_commute_car * (commute == 1) +
        delta_temp_employment_part_time * (employment == 0) +
        delta_temp_neighborhood_suburban * (neighborhood == 2) +
        delta_temp_neighborhood_town_rural * (neighborhood == 1) +
        delta_temp_flexibility_some * (flexibility == 1) +
        delta_temp_flexibility_absolute * (flexibility == 2) +
        delta_temp_factor_score_1 * factor_1 +
        delta_temp_factor_score_2 * factor_2 +
        delta_temp_factor_score_3 * factor_3 +
        delta_offt +
        delta_offt_agk_30_44_woman_nokids * (agk == 4) +
        delta_offt_agk_30_44_man_kids * (agk == 5) +
        delta_offt_agk_30_44_man_nokids * (agk == 6) +
        delta_offt_agk_18_29_woman * (agk == 1) +
        delta_offt_agk_18_29_man * (agk == 2) +
        delta_offt_agk_45_64_woman * (agk == 7) +
        delta_offt_agk_45_64_man * (agk == 8) +
        delta_offt_agk_65plus_woman * (agk == 9) +
        delta_offt_agk_65plus_man * (agk == 10) +
        delta_offt_income_50_99 * (income == 2) +
        delta_offt_income_100_149 * (income == 3) +
        delta_offt_income_150plus * (income == 4) +
        delta_offt_education_college * (education == 2) +
        delta_offt_education_graduate * (education == 3) +
        delta_offt_impedance_20_39 * (impedance == 2) +
        delta_offt_impedance_40_59 * (impedance == 3) +
        delta_offt_impedance_60plus * (impedance == 4) +
        delta_offt_capability_mid * (capability == 2) +
        delta_offt_capability_high * (capability == 3) +
        delta_offt_commute_car * (commute == 1) +
        delta_offt_employment_part_time * (employment == 0) +
        delta_offt_neighborhood_suburban * (neighborhood == 2) +
        delta_offt_neighborhood_town_rural * (neighborhood == 1) +
        delta_offt_flexibility_some * (flexibility == 1) +
        delta_offt_flexibility_absolute * (flexibility == 2) +
        delta_offt_factor_score_1 * factor_1 +
        delta_offt_factor_score_2 * factor_2 +
        delta_offt_factor_score_3 * factor_3
      V[["home_ampk"]] <- delta_home +
        delta_home_agk_30_44_woman_nokids * (agk == 4) +
        delta_home_agk_30_44_man_kids * (agk == 5) +
        delta_home_agk_30_44_man_nokids * (agk == 6) +
        delta_home_agk_18_29_woman * (agk == 1) +
        delta_home_agk_18_29_man * (agk == 2) +
        delta_home_agk_45_64_woman * (agk == 7) +
        delta_home_agk_45_64_man * (agk == 8) +
        delta_home_agk_65plus_woman * (agk == 9) +
        delta_home_agk_65plus_man * (agk == 10) +
        delta_home_income_50_99 * (income == 2) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_college * (education == 2) +
        delta_home_education_graduate * (education == 3) +
        delta_home_impedance_20_39 * (impedance == 2) +
        delta_home_impedance_40_59 * (impedance == 3) +
        delta_home_impedance_60plus * (impedance == 4) +
        delta_home_capability_mid * (capability == 2) +
        delta_home_capability_high * (capability == 3) +
        delta_home_commute_car * (commute == 1) +
        delta_home_employment_part_time * (employment == 0) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town_rural * (neighborhood == 1) +
        delta_home_flexibility_some * (flexibility == 1) +
        delta_home_flexibility_absolute * (flexibility == 2) +
        delta_home_factor_score_1 * factor_1 +
        delta_home_factor_score_2 * factor_2 +
        delta_home_factor_score_3 * factor_3
      V[["home_mddy"]] <- delta_home +
        delta_home_agk_30_44_woman_nokids * (agk == 4) +
        delta_home_agk_30_44_man_kids * (agk == 5) +
        delta_home_agk_30_44_man_nokids * (agk == 6) +
        delta_home_agk_18_29_woman * (agk == 1) +
        delta_home_agk_18_29_man * (agk == 2) +
        delta_home_agk_45_64_woman * (agk == 7) +
        delta_home_agk_45_64_man * (agk == 8) +
        delta_home_agk_65plus_woman * (agk == 9) +
        delta_home_agk_65plus_man * (agk == 10) +
        delta_home_income_50_99 * (income == 2) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_college * (education == 2) +
        delta_home_education_graduate * (education == 3) +
        delta_home_impedance_20_39 * (impedance == 2) +
        delta_home_impedance_40_59 * (impedance == 3) +
        delta_home_impedance_60plus * (impedance == 4) +
        delta_home_capability_mid * (capability == 2) +
        delta_home_capability_high * (capability == 3) +
        delta_home_commute_car * (commute == 1) +
        delta_home_employment_part_time * (employment == 0) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town_rural * (neighborhood == 1) +
        delta_home_flexibility_some * (flexibility == 1) +
        delta_home_flexibility_absolute * (flexibility == 2) +
        delta_home_factor_score_1 * factor_1 +
        delta_home_factor_score_2 * factor_2 +
        delta_home_factor_score_3 * factor_3 +
        delta_mddy +
        delta_mddy_agk_30_44_woman_nokids * (agk == 4) +
        delta_mddy_agk_30_44_man_kids * (agk == 5) +
        delta_mddy_agk_30_44_man_nokids * (agk == 6) +
        delta_mddy_agk_18_29_woman * (agk == 1) +
        delta_mddy_agk_18_29_man * (agk == 2) +
        delta_mddy_agk_45_64_woman * (agk == 7) +
        delta_mddy_agk_45_64_man * (agk == 8) +
        delta_mddy_agk_65plus_woman * (agk == 9) +
        delta_mddy_agk_65plus_man * (agk == 10) +
        delta_mddy_income_50_99 * (income == 2) +
        delta_mddy_income_100_149 * (income == 3) +
        delta_mddy_income_150plus * (income == 4) +
        delta_mddy_education_college * (education == 2) +
        delta_mddy_education_graduate * (education == 3) +
        delta_mddy_impedance_20_39 * (impedance == 2) +
        delta_mddy_impedance_40_59 * (impedance == 3) +
        delta_mddy_impedance_60plus * (impedance == 4) +
        delta_mddy_capability_mid * (capability == 2) +
        delta_mddy_capability_high * (capability == 3) +
        delta_mddy_commute_car * (commute == 1) +
        delta_mddy_employment_part_time * (employment == 0) +
        delta_mddy_neighborhood_suburban * (neighborhood == 2) +
        delta_mddy_neighborhood_town_rural * (neighborhood == 1) +
        delta_mddy_flexibility_some * (flexibility == 1) +
        delta_mddy_flexibility_absolute * (flexibility == 2) +
        delta_mddy_factor_score_1 * factor_1 +
        delta_mddy_factor_score_2 * factor_2 +
        delta_mddy_factor_score_3 * factor_3
      V[["home_pmpk"]] <- delta_home +
        delta_home_agk_30_44_woman_nokids * (agk == 4) +
        delta_home_agk_30_44_man_kids * (agk == 5) +
        delta_home_agk_30_44_man_nokids * (agk == 6) +
        delta_home_agk_18_29_woman * (agk == 1) +
        delta_home_agk_18_29_man * (agk == 2) +
        delta_home_agk_45_64_woman * (agk == 7) +
        delta_home_agk_45_64_man * (agk == 8) +
        delta_home_agk_65plus_woman * (agk == 9) +
        delta_home_agk_65plus_man * (agk == 10) +
        delta_home_income_50_99 * (income == 2) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_college * (education == 2) +
        delta_home_education_graduate * (education == 3) +
        delta_home_impedance_20_39 * (impedance == 2) +
        delta_home_impedance_40_59 * (impedance == 3) +
        delta_home_impedance_60plus * (impedance == 4) +
        delta_home_capability_mid * (capability == 2) +
        delta_home_capability_high * (capability == 3) +
        delta_home_commute_car * (commute == 1) +
        delta_home_employment_part_time * (employment == 0) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town_rural * (neighborhood == 1) +
        delta_home_flexibility_some * (flexibility == 1) +
        delta_home_flexibility_absolute * (flexibility == 2) +
        delta_home_factor_score_1 * factor_1 +
        delta_home_factor_score_2 * factor_2 +
        delta_home_factor_score_3 * factor_3 +
        delta_pmpk +
        delta_pmpk_agk_30_44_woman_nokids * (agk == 4) +
        delta_pmpk_agk_30_44_man_kids * (agk == 5) +
        delta_pmpk_agk_30_44_man_nokids * (agk == 6) +
        delta_pmpk_agk_18_29_woman * (agk == 1) +
        delta_pmpk_agk_18_29_man * (agk == 2) +
        delta_pmpk_agk_45_64_woman * (agk == 7) +
        delta_pmpk_agk_45_64_man * (agk == 8) +
        delta_pmpk_agk_65plus_woman * (agk == 9) +
        delta_pmpk_agk_65plus_man * (agk == 10) +
        delta_pmpk_income_50_99 * (income == 2) +
        delta_pmpk_income_100_149 * (income == 3) +
        delta_pmpk_income_150plus * (income == 4) +
        delta_pmpk_education_college * (education == 2) +
        delta_pmpk_education_graduate * (education == 3) +
        delta_pmpk_impedance_20_39 * (impedance == 2) +
        delta_pmpk_impedance_40_59 * (impedance == 3) +
        delta_pmpk_impedance_60plus * (impedance == 4) +
        delta_pmpk_capability_mid * (capability == 2) +
        delta_pmpk_capability_high * (capability == 3) +
        delta_pmpk_commute_car * (commute == 1) +
        delta_pmpk_employment_part_time * (employment == 0) +
        delta_pmpk_neighborhood_suburban * (neighborhood == 2) +
        delta_pmpk_neighborhood_town_rural * (neighborhood == 1) +
        delta_pmpk_flexibility_some * (flexibility == 1) +
        delta_pmpk_flexibility_absolute * (flexibility == 2) +
        delta_pmpk_factor_score_1 * factor_1 +
        delta_pmpk_factor_score_2 * factor_2 +
        delta_pmpk_factor_score_3 * factor_3
      V[["home_offt"]] <- delta_home +
        delta_home_agk_30_44_woman_nokids * (agk == 4) +
        delta_home_agk_30_44_man_kids * (agk == 5) +
        delta_home_agk_30_44_man_nokids * (agk == 6) +
        delta_home_agk_18_29_woman * (agk == 1) +
        delta_home_agk_18_29_man * (agk == 2) +
        delta_home_agk_45_64_woman * (agk == 7) +
        delta_home_agk_45_64_man * (agk == 8) +
        delta_home_agk_65plus_woman * (agk == 9) +
        delta_home_agk_65plus_man * (agk == 10) +
        delta_home_income_50_99 * (income == 2) +
        delta_home_income_100_149 * (income == 3) +
        delta_home_income_150plus * (income == 4) +
        delta_home_education_college * (education == 2) +
        delta_home_education_graduate * (education == 3) +
        delta_home_impedance_20_39 * (impedance == 2) +
        delta_home_impedance_40_59 * (impedance == 3) +
        delta_home_impedance_60plus * (impedance == 4) +
        delta_home_capability_mid * (capability == 2) +
        delta_home_capability_high * (capability == 3) +
        delta_home_commute_car * (commute == 1) +
        delta_home_employment_part_time * (employment == 0) +
        delta_home_neighborhood_suburban * (neighborhood == 2) +
        delta_home_neighborhood_town_rural * (neighborhood == 1) +
        delta_home_flexibility_some * (flexibility == 1) +
        delta_home_flexibility_absolute * (flexibility == 2) +
        delta_home_factor_score_1 * factor_1 +
        delta_home_factor_score_2 * factor_2 +
        delta_home_factor_score_3 * factor_3 +
        delta_offt +
        delta_offt_agk_30_44_woman_nokids * (agk == 4) +
        delta_offt_agk_30_44_man_kids * (agk == 5) +
        delta_offt_agk_30_44_man_nokids * (agk == 6) +
        delta_offt_agk_18_29_woman * (agk == 1) +
        delta_offt_agk_18_29_man * (agk == 2) +
        delta_offt_agk_45_64_woman * (agk == 7) +
        delta_offt_agk_45_64_man * (agk == 8) +
        delta_offt_agk_65plus_woman * (agk == 9) +
        delta_offt_agk_65plus_man * (agk == 10) +
        delta_offt_income_50_99 * (income == 2) +
        delta_offt_income_100_149 * (income == 3) +
        delta_offt_income_150plus * (income == 4) +
        delta_offt_education_college * (education == 2) +
        delta_offt_education_graduate * (education == 3) +
        delta_offt_impedance_20_39 * (impedance == 2) +
        delta_offt_impedance_40_59 * (impedance == 3) +
        delta_offt_impedance_60plus * (impedance == 4) +
        delta_offt_capability_mid * (capability == 2) +
        delta_offt_capability_high * (capability == 3) +
        delta_offt_commute_car * (commute == 1) +
        delta_offt_employment_part_time * (employment == 0) +
        delta_offt_neighborhood_suburban * (neighborhood == 2) +
        delta_offt_neighborhood_town_rural * (neighborhood == 1) +
        delta_offt_flexibility_some * (flexibility == 1) +
        delta_offt_flexibility_absolute * (flexibility == 2) +
        delta_offt_factor_score_1 * factor_1 +
        delta_offt_factor_score_2 * factor_2 +
        delta_offt_factor_score_3 * factor_3

      alpha <- list(
        outside = 1 / (1 + exp(5)),
        prim_ampk = 1 / (1 + exp(-alpha_prim_ampk)),
        temp_ampk = 1 / (1 + exp(-alpha_temp_ampk)),
        home_ampk = 1 / (1 + exp(-alpha_home_ampk)),
        prim_mddy = 1 / (1 + exp(-alpha_prim_mddy)),
        temp_mddy = 1 / (1 + exp(-alpha_temp_mddy)),
        home_mddy = 1 / (1 + exp(-alpha_home_mddy)),
        prim_pmpk = 1 / (1 + exp(-alpha_prim_pmpk)),
        temp_pmpk = 1 / (1 + exp(-alpha_temp_pmpk)),
        home_pmpk = 1 / (1 + exp(-alpha_home_pmpk)),
        prim_offt = 1 / (1 + exp(-alpha_prim_offt)),
        temp_offt = 1 / (1 + exp(-alpha_temp_offt)),
        home_offt = 1 / (1 + exp(-alpha_home_offt))
      )

      gamma <- list(
        prim_ampk = alpha_prim_ampk,
        temp_ampk = alpha_temp_ampk,
        home_ampk = alpha_home_ampk,
        prim_mddy = alpha_prim_mddy,
        temp_mddy = alpha_temp_mddy,
        home_mddy = alpha_home_mddy,
        prim_pmpk = alpha_prim_pmpk,
        temp_pmpk = alpha_temp_pmpk,
        home_pmpk = alpha_home_pmpk,
        prim_offt = alpha_prim_offt,
        temp_offt = alpha_temp_offt,
        home_offt = alpha_home_offt
      )

      cost <- list(
        prim_ampk = 1,
        temp_ampk = 1,
        home_ampk = 1,
        prim_mddy = 1,
        temp_mddy = 1,
        home_mddy = 1,
        prim_pmpk = 1,
        temp_pmpk = 1,
        home_pmpk = 1,
        prim_offt = 1,
        temp_offt = 1,
        home_offt = 1
      )

      mdcev_settings <- list(
        alternatives = alternatives,
        avail = avail,
        continuousChoice = continuousChoice,
        utilities = V,
        alpha = alpha,
        gamma = gamma,
        sigma = sig_base,
        cost = cost,
        budget = 24
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

for (i in 1:7) {
  exec_model_10_gamma_fixed(i)
}
