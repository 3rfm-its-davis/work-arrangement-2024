exec_iclv_cluster <- function() {
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
      att_01 = A_a,
      att_02 = A_b,
      att_03 = A_c,
      att_04 = A_d,
      att_05 = A_e,
      att_06 = A_f,
      att_07 = A_g,
      att_08 = A_h,
      att_09 = A_k,
      att_10 = A_l,
      att_11 = A_n,
      att_12 = A_p,
      att_13 = A_q,
      att_14 = A_r,
      att_15 = A_s,
      att_16 = A_u,
      att_17 = A_w,
      att_18 = A_x,
      att_19 = A_y,
      att_20 = A_z,
      att_21 = A_ab,
      att_22 = A_ac,
      att_23 = A_ad,
      cluster
    ) %>%
    mutate_if(
      is.numeric,
      as.numeric
    )

  model_name <- "iclv_cluster_1"

  assign("database", database, envir = globalenv())

  apollo_initialise()

  apollo_control <- list(
    modelName = model_name,
    modelDescr = "
  I.V.
  - Age",
    indivID = "row_index",
    outputDirectory = file.path("output", "iclv"),
    nCores = 16
  )

  assign("apollo_control", apollo_control, envir = globalenv())

  apollo_beta <- c(
    asc_2 = 0,
    asc_3 = 0,
    asc_4 = 0,
    asc_5 = 0,
    asc_6 = 0,
    l_2_1 = 0,
    l_2_2 = 0,
    l_2_3 = 0,
    l_2_4 = 0,
    l_2_5 = 0,
    l_3_1 = 0,
    l_3_2 = 0,
    l_3_3 = 0,
    l_3_4 = 0,
    l_3_5 = 0,
    l_4_1 = 0,
    l_4_2 = 0,
    l_4_3 = 0,
    l_4_4 = 0,
    l_4_5 = 0,
    l_5_1 = 0,
    l_5_2 = 0,
    l_5_3 = 0,
    l_5_4 = 0,
    l_5_5 = 0,
    l_6_1 = 0,
    l_6_2 = 0,
    l_6_3 = 0,
    l_6_4 = 0,
    l_6_5 = 0,
    d_01_2 = 1,
    d_02_4 = 1,
    d_03_3 = 1,
    d_04_1 = 1,
    d_05_3 = 1,
    d_06_5 = 1,
    d_07_1 = 1,
    d_08_3 = 1,
    d_09_1 = 1,
    d_10_3 = 1,
    d_11_1 = 1,
    d_12_1 = 1,
    d_13_4 = 1,
    d_14_1 = 1,
    d_15_2 = 1,
    d_16_1 = 1,
    d_17_2 = 1,
    d_18_2 = 1,
    d_19_2 = 1,
    d_20_5 = 1,
    d_21_3 = 1,
    d_22_1 = 1,
    d_23_3 = 1,
    s_01_2 = 1,
    s_02_4 = 1,
    s_03_3 = 1,
    s_04_1 = 1,
    s_05_3 = 1,
    s_06_5 = 1,
    s_07_1 = 1,
    s_08_3 = 1,
    s_09_1 = 1,
    s_10_3 = 1,
    s_11_1 = 1,
    s_12_1 = 1,
    s_13_4 = 1,
    s_14_1 = 1,
    s_15_2 = 1,
    s_16_1 = 1,
    s_17_2 = 1,
    s_18_2 = 1,
    s_19_2 = 1,
    s_20_5 = 1,
    s_21_3 = 1,
    s_22_1 = 1,
    s_23_3 = 1
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

    randcoeff[["lv_1"]] <- n_1
    randcoeff[["lv_2"]] <- n_2
    randcoeff[["lv_3"]] <- n_3
    randcoeff[["lv_4"]] <- n_4
    randcoeff[["lv_5"]] <- n_5
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
        l_2_1 * lv_1 +
        l_2_2 * lv_2 +
        l_2_3 * lv_3 +
        l_2_4 * lv_4 +
        l_2_5 * lv_5
      V[["cluster3"]] <- asc_3 +
        l_3_1 * lv_1 +
        l_3_2 * lv_2 +
        l_3_3 * lv_3 +
        l_3_4 * lv_4 +
        l_3_5 * lv_5
      V[["cluster4"]] <- asc_4 +
        l_4_1 * lv_1 +
        l_4_2 * lv_2 +
        l_4_3 * lv_3 +
        l_4_4 * lv_4 +
        l_4_5 * lv_5
      V[["cluster5"]] <- asc_5 +
        l_5_1 * lv_1 +
        l_5_2 * lv_2 +
        l_5_3 * lv_3 +
        l_5_4 * lv_4 +
        l_5_5 * lv_5
      V[["cluster6"]] <- asc_6 +
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

exec_iclv_cluster()
apollo_sink()
