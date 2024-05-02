header_label_map <- c(
  type = "Variable",
  category = "Type",
  value = "Group",
  "prim_ampk" = "Primary/AM-peak",
  "prim_mddy" = "Primary/Midday",
  "prim_pmpk" = "Primary/PM-peak",
  "prim_offt" = "Primary/Off-time",
  "temp_ampk" = "Temporary/AM-peak",
  "temp_mddy" = "Temporary/Midday",
  "temp_pmpk" = "Temporary/PM-peak",
  "temp_offt" = "Temporary/Off-time",
  "home_ampk" = "Home/AM-peak",
  "home_mddy" = "Home/Midday",
  "home_pmpk" = "Home/PM-peak",
  "home_offt" = "Home/Off-time",
  "prim" = "Primary",
  "temp" = "Temporary",
  "home" = "Home",
  "ampk" = "AM-peak",
  "mddy" = "Midday",
  "pmpk" = "PM-peak",
  "offt" = "Off-time",
  "base" = "Base",
  "outside" = "Outside"
) %>%
  c(
    "1" = "Primary",
    "2" = "Temporary",
    "3" = "Home",
    "4" = "Primary_Home",
    "5" = "Temporary_Home",
    "6" = "All_Mixed"
  )

main_label_map <- c(
  alpha = "Baseline constant (Alpha)",
  gamma = "Satiation parameter",
  delta = "Coefficient",
  sig = "Sigma",
  asc = "Alternative-specific constant",
  b = "Coefficient"
)

sub_label_map <- c(
  genderkids = "I: Gender-Kids",
  agekids = "I: Age-Kids",
  agegender = "I: Age-Gender",
  kids = "C: Kids\nBase: No Kids",
  gender = "C: Gender\nBase: Non-Woman",
  age = "C: Age\nBase: 30-44",
  agk = "C: Age-Gender-Kids\nBase: 30-44 Non-Woman without Kids",
  income = "C: Household income (USD)\nBase: 50-99K",
  impedance = "C: Commuting time between home and workplace\nBase: <20 Mins",
  factor = "N: Factor score",
  education = "C: Education\nBase: Bachelor's Degree",
  commute = "C: Primary commute mode (is car)\nBase: Car",
  capability = "C: Remote Capability of the Occupation\nBase: Low Remote Capability",
  jobtype12 = "C: Job Type\nBase: Physical and Manual Labor",
  jobtype = "C: Job Type\nBase: Professional, Managerial, or Technical",
  employment = "C: Employment type\nBase: Part-Time",
  neighborhood = "C: Neighborhood type\nBase: Urban",
  flexibility = "C: Work Flexibility of Time\nBase: No",
  impgender = "C: Impedance-Gender\nBase: <20 Mins",
  impneighbor = "I: Impedance-Neighborhood",
  homeownership = "C: Home Ownership\nBase: Own"
)

agk_label_map <- c(
  "18_29_woman" = "18-29 Woman",
  "18_29" = "18-29",
  "30_44_woman_nokids" = "30-44 Woman without Kids",
  "30_44_woman_kids" = "30-44 Woman with Kids",
  "30_44_kids" = "30-44 with Kids",
  "45_64_woman_nokids" = "45-64 Woman without Kids",
  "45_64_nokids" = "45-64 without Kids",
  "45_64_woman_kids" = "45-64 Woman with Kids",
  "45_64_kids" = "45-64 with Kids",
  "45_64_woman" = "45-64 Woman",
  "45_64" = "45-64",
  "65plus_woman" = "65+ Woman",
  "65plus" = "65+",
  "18_29" = "18-29",
  "45_64" = "45-64",
  "65plus" = "65+"
)

factor_label_map <- c(
  "score_1" = "In-person communication is important for work",
  "score_2" = "Remote work is beneficial to me",
  "score_3" = "I prefer shop local than online"
)

age_label_map <- c(
  "18_29" = "18-29",
  "30_44" = "30-44",
  "45_64" = "45-64",
  "65plus" = "65+"
)

kids_label_map <- c(
  "kids" = "Have Kids"
)

gender_label_map <- c(
  "women" = "Woman"
)

agegender_label_map <- c(
  "30_44_women" = "30-44 Woman"
)

agekids_label_map <- c(
  "30_44_kids" = "30-44 with Kids"
)

genderkids_label_map <- c(
  "women_kids" = "Woman with Kids"
)

income_label_map <- c(
  base = "50-99K",
  "50minus" = "<50K",
  "50_99" = "50-99K",
  "100_149" = "100-149K",
  "150plus" = ">=150K"
)

occupation_label_map <- c(
  base = "Low-remote",
  mid = "Mid-remote",
  high = "High-remote"
)

jobtype_label_map <- c(
  base = "Professional, Managerial, or Technical",
  "health" = "Health and Personal Care",
  "retail" = "Retail sales/Food services",
  "education" = "Education/Social service",
  "public" = "Public Administration",
  "information" = "Information/Finance"
)

jobtype12_label_map <- c(
  base = "Physical and Manual Labor",
  physical = "Physical and Manual Labor",
  professional = "Professional and Technical Services",
  administrative = "Administrative, Sales, and Community Services"
)

travel_label_map <- c(
  base = "0-19 Mins",
  "20_39" = "20-39 Mins",
  "40_59" = "40-59 Mins",
  "60plus" = "60+ Mins"
)

education_label_map <- c(
  base = "Some College or Bachelor's",
  highschool = "Associate or less",
  associate = "Associate or less",
  college = "Bachelor's",
  graduate = "Graduate or Professional Degree"
)

neighborhood_label_map <- c(
  base = "Urban",
  suburban = "Suburban",
  town = "Small Town or Rural"
)

flexibility_label_map <- c(
  base = "No",
  some = "Some",
  absolute = "Absolute"
)

commute_label_map <- c(
  base = "Not car",
  noncar = "Not Car",
  car = "Car"
)

employment_label_map <- c(
  base = "Full-Time",
  part_time = "Part-Time"
)

impedance_label_map <- c(
  "20_39" = "20-39 Mins",
  "40_59" = "40-59 Mins",
  "60plus" = "60+ Mins"
)

impgender_label_map <- c(
  "20_39_nonwoman" = "20-39 Mins (Non-Woman)",
  "40_59_nonwoman" = "40-59 Mins (Non-Woman)",
  "60plus_nonwoman" = "60+ Mins (Non-Woman)",
  "20_39_woman" = "20-39 Mins (Woman)",
  "40_59_woman" = "40-59 Mins (Woman)",
  "60plus_woman" = "60+ Mins (Woman)",
  "20_39" = "20-39 Mins",
  "40_59" = "40-59 Mins",
  "60plus" = "60+ Mins"
)


impneighbor_label_map <- c(
  "20minus_suburban" = "-19 Mins (Suburban)",
  "20_39_suburban" = "20-39 Mins (Suburban)",
  "40_59_suburban" = "40-59 Mins (Suburban)",
  "60plus_suburban" = "60+ Mins (Suburban)",
  "20minus_town" = "-19 Mins (Town/Rural)",
  "20_39_town" = "20-39 Mins (Town/Rural)",
  "40_59_town" = "40-59 Mins (Town/Rural)",
  "60plus_town" = "60+ Mins (Town/Rural)",
  "20_39_urban" = "20-39 Mins (Urban)",
  "40_59_urban" = "40-59 Mins (Urban)",
  "60plus_urban" = "60+ Mins (Urban)",
  "20_39" = "20-39 Mins",
  "40_59" = "40-59 Mins",
  "60plus" = "60+ Mins"
)

homeownership_label_map <- c(
  base = "Own",
  nonown = "Non-Own"
)

source(file.path("utils", "output_conversion", "model_12.R"))
source(file.path("utils", "output_conversion", "model_13.R"))
