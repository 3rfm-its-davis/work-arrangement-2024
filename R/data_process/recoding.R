data <- data %>%
  mutate(
    age = 2024 - as.numeric(B1_1),
    age = case_when(
      age < 35 ~ 1,
      age < 55 ~ 2,
      TRUE ~ 3
    ) %>%
      labelled(
        label = "Age group",
        labels = c(
          "Under 35" = 1,
          "35-54" = 2,
          "55+" = 4
        )
      ),
    gender = case_when(
      B5 == 1 ~ 1,
      TRUE ~ 2
    ) %>%
      labelled(
        label = "Gender",
        labels = c(
          "Woman" = 1,
          "Non-Woman" = 2
        )
      ),
    kids = case_when(
      D2_b > 0 ~ 1,
      TRUE ~ 0
    ) %>%
      labelled(
        label = "Kids",
        labels = c(
          "Yes" = 1,
          "No" = 0
        )
      ),
    income = case_when(
      B8 < 3 ~ 1,
      B8 < 5 ~ 2,
      B8 < 6 ~ 3,
      TRUE ~ 4
    ) %>%
      labelled(
        label = "Household income level",
        labels = c(
          "Less than $50,000" = 1,
          "$50,000 - $99,999" = 2,
          "$100,000 - $149,999" = 3,
          "$150,000+" = 4
        )
      ),
    education12 = case_when(
      B7 < 4 ~ 1,
      B7 < 5 ~ 2,
      TRUE ~ 3
    ) %>%
      labelled(
        label = "Education level",
        labels = c(
          "Associate or Less" = 1,
          "Bachelor's" = 2,
          "Graduate or Professional Degree" = 3
        )
      ),
    occupation = case_when(
      T ~ C4 %>%
        labelled(
          label = "Occupation",
          labels = c(
            "Farming, Fishing, Forestry, and Extraction" = 1,
            "Construction, Installation, Maintenance, Repair, and Production" = 2,
            "Sales and Related" = 3,
            "Transportation and Material Moving" = 4,
            "Business and Financial Operations" = 5,
            "Computer and Mathematical, Architecture and Engineering, Life, Physical, and Social Science" = 6,
            "Management and Legal" = 7,
            "Office and Administrative Support" = 8,
            "Protective Service, Building and Grounds Cleaning and Maintenance" = 9,
            "Educational Instruction and Library" = 10,
            "Healthcare Practitioners and Technical, Healthcare Support" = 11,
            "Arts, Design, Entertainment, Sports, and Media" = 12,
            "Food Preparation and Serving Related" = 13,
            "Personal Care and Service" = 14,
            "Community and Social Service" = 15,
            "Military Specific" = 16
          )
        )
    ),
    neighborhood = case_when(
      D3 == 1 ~ 1,
      D3 == 2 ~ 2,
      TRUE ~ 3
    ) %>%
      labelled(
        label = "Neighborhood type",
        labels = c(
          "Urban" = 1,
          "Suburban" = 2,
          "Small Town or Rural" = 3
        )
      ),
    work_freq_primary = C5_1a,
    impedance = case_when(
      is.na(C9_a_1) ~ 0,
      C9_a_1 < 19 ~ 1,
      C9_a_1 < 39 ~ 2,
      C9_a_1 < 59 ~ 3,
      T ~ 4,
    ) %>% labelled(
      label = "Commute time between home and work",
      labels = c(
        "Unknown" = 0,
        "0-19 Mins" = 1,
        "20-39 Mins" = 2,
        "40-59 Mins" = 3,
        "60+ Mins" = 4
      )
    ),
    jobtype12 = case_when(
      occupation == 1 |
        occupation == 2 |
        occupation == 4 |
        occupation == 9 |
        occupation == 13 ~ 1,
      occupation == 5 |
        occupation == 6 |
        occupation == 7 |
        occupation == 10 |
        occupation == 11 |
        occupation == 12 ~ 2,
      T ~ 3
    ) %>%
      labelled(
        label = "Job Type",
        labels = c(
          "Physical and Manual Labor" = 1,
          "Professional and Technical Services" = 2,
          "Administrative, Sales, and Community Services" = 3
        )
      ),
    homeownership = case_when(
      D6 == 2 ~ 2,
      T ~ 1,
    ) %>%
      as.numeric() %>%
      labelled(
        label = "Work time flexibility",
        labels = c(
          "Own" = 2,
          "Non-Own" = 1
        )
      ),
  )
