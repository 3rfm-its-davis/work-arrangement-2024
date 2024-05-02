data <- data %>%
  mutate(
    age = 2024 - as.numeric(B1_1),
    age = case_when(
      age < 30 ~ 1,
      age < 45 ~ 2,
      age < 65 ~ 3,
      TRUE ~ 4
    ) %>%
      labelled(
        label = "Age group",
        labels = c(
          "Under 30" = 1,
          "30-44" = 2,
          "45-64" = 3,
          "65+" = 4
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
    agk = case_when(
      age == 1 & gender == 1 ~
        1,
      age == 1 & gender == 2 ~
        2,
      age == 2 &
        kids == 1 &
        gender == 1 ~
        3,
      age == 2 &
        kids == 0 &
        gender == 1 ~
        4,
      age == 2 &
        kids == 1 &
        gender == 2 ~
        5,
      age == 2 &
        kids == 0 &
        gender == 2 ~
        6,
      age == 3 & gender == 1 ~
        7,
      age == 3 & gender == 2 ~
        8,
      age == 4 & gender == 1 ~
        9,
      age == 4 & gender == 2 ~
        10,
      TRUE ~ 0
    ) %>%
      labelled(
        label = "Age, Gender, and Kids",
        labels = c(
          "18-29 Woman" = 1,
          "18-29 Non-Woman" = 2,
          "30-44 Woman with Kids" = 3,
          "30-44 Woman without Kids" = 4,
          "30-44 Non-Woman with Kids" = 5,
          "30-44 Non-Woman without Kids" = 6,
          "45-64 Woman" = 7,
          "45-64 Non-Woman" = 8,
          "65+ Woman" = 9,
          "65+ Non-Woman" = 10,
          "Unknown" = 0
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
    education = case_when(
      B7 < 3 ~ 1,
      B7 < 5 ~ 2,
      TRUE ~ 3
    ) %>%
      labelled(
        label = "Education level",
        labels = c(
          "High School or Less" = 1,
          "Some College or Bachelor's" = 2,
          "Graduate or Professional Degree" = 3
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
    occupation = C4 %>%
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
      ),
    employment = case_when(
      C1_1_1 == 1 |
        C1_3_1 == 1 |
        C1_4_1 == 1 ~ 1,
      TRUE ~ 0,
    ) %>%
      labelled(
        label = "Employment status",
        labels = c(
          "Full-time" = 1,
          "Part-time" = 0
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
    work_freq_on_site = pmax(C5_1a, C5_1b, na.rm = T),
    work_freq_remote = pmax(C5_1c, C5_1d, na.rm = T),
    work_practice = case_when(
      work_freq_on_site > 2 &
        work_freq_remote > 2 ~ 1,
      work_freq_on_site > 2 ~ 2,
      work_freq_remote > 2 ~ 3,
      TRUE ~ 4
    ) %>%
      labelled(
        label = "Work practice type",
        labels = c(
          "On-Site" = 1,
          "Remote" = 2,
          "Hybrid" = 3,
          "Infrequent" = 4
        )
      ),
    impedance = case_when(
      C9_a_1 < 19 ~ 1,
      C9_a_1 < 39 ~ 2,
      C9_a_1 < 59 ~ 3,
      T ~ 4,
    ) %>% labelled(
      label = "Commute time between home and work",
      labels = c(
        "0-19 Mins" = 1,
        "20-39 Mins" = 2,
        "40-59 Mins" = 3,
        "60+ Mins" = 4
      )
    ),
    commute = case_when(
      pmax(
        E2_a,
        E2_b
      ) > pmax(
        E2_c,
        E2_d,
        E2_e,
        E2_f,
        E2_g,
        E2_h,
        E2_i
      ) ~ 1,
      TRUE ~ 0
    ) %>%
      labelled(
        label = "Commute Mode",
        labels = c(
          "Car" = 1,
          "Non-Car" = 0
        )
      ),
    capability = case_when(
      occupation == 5 |
        occupation == 6 |
        occupation == 7 |
        occupation == 8 |
        occupation == 10 |
        occupation == 12 ~ 3,
      occupation == 3 |
        occupation == 9 |
        occupation == 11 |
        occupation == 14 |
        occupation == 15 ~ 2,
      T ~ 1
    ) %>%
      labelled(
        label = "Remote-work capability of the occupation",
        labels = c(
          "High-remote" = 3,
          "Mid-remote" = 2,
          "Low-remote" = 1
        )
      ),
    jobtype = case_when(
      occupation == 2 |
        occupation == 7 |
        occupation == 8 ~ 1,
      occupation == 11 |
        occupation == 14 ~ 2,
      occupation == 3 |
        occupation == 13 ~ 3,
      occupation == 10 |
        occupation == 15 ~ 4,
      occupation == 1 |
        occupation == 4 |
        occupation == 9 |
        occupation == 16 ~ 5,
      T ~ 6
    ) %>%
      labelled(
        label = "Job Type",
        labels = c(
          "Professional, Managerial, or Technical" = 1,
          "Health and Personal Care" = 2,
          "Retail sales/Food services" = 3,
          "Education/Social service" = 4,
          "Public Administration" = 5,
          "Information/Finance" = 6
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
    flexibility = C8 %>%
      as.numeric() %>%
      labelled(
        label = "Work time flexibility",
        labels = c(
          "Absolute" = 2,
          "Some" = 1,
          "No" = 0
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
