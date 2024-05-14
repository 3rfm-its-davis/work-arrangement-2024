# Data Processing Flow

## Data Import and Initial Filter

1. The dataset is imported as a .sav file via `read_sav` function. (n=6,469)
1. Those who are determined to be `out` are excluded. (n=6,110)
1. The remaining data is annexed with the geocoding file showing the home state by `left_join`. Then, those living outside `CA` are excluded. (n=4,369)

## Basic Filters

The first set of filters excluded the cases with any of the following criteria:

- Did not report their income level (n=4,182)
- Was not a paid worker in Fall 2023 (n=2,516)
- Did not have a weight (n=2,493)
- Did not report weekly work hours (n=2,490)
- Had one or more flags within the work section
  - `flag_discrepancy_work_hours` (n=2,434)
    - Reported work hours in C3 and C13a (sum) are different by 1/3 or 3.
  - `flag_high_low_workplace` (n=2,404)
    - Flatlined at 0, 1, 4, or 5 throughout C5_1a to C5_1d.
  - `flag_too_many_work_hour_by_matrix` (n=2,275)
    - Selected every row of any matrix questions.
- Reported that they were not permitted by the supervisor to remote work (n=1,531)

## Recoding of Work Arrangement Matrices

The original work arrangement matrices have the variable name in the format of `C13b_{day}_{time}_{workplace}`.

- Day varies from `1 (Sunday)` to `7 (Saturday)`.
- Time varies from `1 (0-6)`, `2 (6-8)`, `3 (8-10)`... to `10 (22-24)`.
- Workplace is one of `1 (Primary)`, `2 (Temporary)`, `3 (Home)`.

The recoding will convert the 3-element array for each date/time into an integer, represented by the variable `C13b_{day}_{time}`, in a binary-decodable format.

## Computation of Work Hours

The total work hours for each workplace and any workplace is computed for four periods of each of the days.

- Period is one of `1 (6-10)`, `2 (10-16)`, `3 (16-20)`, `4 (0-6/20-24)`.

Therefore, the variable `hours_day_{day}_period_{period}_place_{workplace}` stands for the total work hours in the specific context. At this point, if someone has selected multiple workplaces for a given time, the total work time is evenly split up into the workplaces.

Several additional variables; `hours_day_{day}_period_{period}`, `hours_day_{day}_place_{workplace}`, `hours_day_{day}`, `hours_total_place_{workplace}`, and `hours_total` respectively represent the aggregated work hours in the corresponding context.

## Adjustment of Work Hours

In the dataset, variables `C13a_{day}` stand for the reported aggregated work hours for the specific day.

Firstly, if the ratio between the two metrics; `C13a` and `hours_total` are out of the range `c(0.75, 1.33)` (for now), the cases are excluded.

Also, if any day-level aggregated hours are

1. Hours from C13b == 0 and hours from C13a > 0
2. Hours from C13a / Hours from C13b <= 0.5
3. Hours from C13a / Hours from C13b >= 2

(n=1,219)

If it passes the validation, the previously computed work hours for the entire week and the day were adjusted in proportion to the two differently reported work hours (i.e., no adjustment for the period of the day).

Then, cases are excluded if the work hours exceed 16 for any day of the week. (n=1,215)

## Factor Analysis

A factor analysis is performed on the individual attitudes toward work-related statements (variable `C14_{index}`). The number of factors is 3.

## Recoding of Social Demographic Factors

The following social demographic factors have been recoded:

- Age (`age`)
  - `"Under 30" = 1`
  - `"30-44" = 2`
  - `"45-64" = 3`
  - `"65+" = 4`
- Gender (`gender`)
  - `"Woman" = 1`
  - `"Non-Woman" = 2`
- Age-Gender-Kids (combination of three factors) (`agk`)
  - `"18-29 Woman" = 1`
  - `"18-29 Non-Woman" = 2`
  - `"30-44 Woman with Kids" = 3`
  - `"30-44 Woman without Kids" = 4`
  - `"30-44 Non-Woman with Kids" = 5`
  - `"30-44 Non-Woman without Kids" = 6`
  - `"45-64 Woman" = 7`
  - `"45-64 Non-Woman" = 8`
  - `"65+ Woman" = 9`
  - `"65+ Non-Woman "= 10`
- Income (`income`)
  - `"Less than $50,000" = 1`
  - `"$50,000 - $99,999" = 2`
  - `"$100,000 - $149,999" = 3`
  - `"$150,000+" = 4`
- Education (`education`)
  - `"High School or Less" = 1`
  - `"Some College or Bachelor's" = 2`
  - `"Graduate or Professional Degree" = 3`
- Occupation Type (`occupation`)
  - `"Farming, Fishing, Forestry, and Extraction" = 1`
  - `"Construction, Installation, Maintenance, Repair, and Production" = 2`
  - `"Sales and Related" = 3`
  - `"Transportation and Material Moving" = 4`
  - `"Business and Financial Operations" = 5`
  - `"Computer and Mathematical, Architecture and Engineering, Life, Physical, and Social Science" = 6`
  - `"Management and Legal" = 7`
  - `"Office and Administrative Support" = 8`
  - `"Protective Service, Building and Grounds Cleaning and Maintenance" = 9`
  - `"Educational Instruction and Library" = 10`
  - `"Healthcare Practitioners and Technical, Healthcare Support" = 11`
  - `"Arts, Design, Entertainment, Sports, and Media" = 12`
  - `"Food Preparation and Serving Related" = 13`
  - `"Personal Care and Service" = 14`
  - `"Community and Social Service" = 15`
  - `"Military Specific" = 16`
- Remote-Work Capability of the Occupation (`capability`)
  - `"High-remote" = 3`
    - `occupation == 5 | 6 | 7 | 8 | 10 | 12`
  - `"Mid-remote" = 2`
    - `occupation == 3 | 9 | 11 | 14 | 15`
  - `"Low-remote" = 1`
    - `occupation == otherwise`
- Job Type (`jobtype`)
  - `"Professional, Managerial, or Technical" = 1`
    - `occupation == 2 | 7 | 8`
  - `"Health and Personal Care" = 2`
    - `occupation == 11 | 14`
  - `"Retail sales/Food services" = 3`
    - `occupation == 3 | 13`
  - `"Education/Social service" = 4`
    - `occupation == 10 | 15`
  - `"Public Administration" = 5`
    - `occupation == 1 | 4 | 9 | 16`
  - `"Information/Finance" = 6`
    - `occupation == otherwise`
- Employment Status (`employment`)
  - `"Full-time" = 1`
  - `"Part-time" = 0`
- Neighborhood Type (`neighborhood`)
  - `"Urban" = 3`
  - `"Suburban" = 2`
  - `"Small Town or Rural" = 1`
- Travel Impedance (`impedance`)
  - `"0-19 Mins" = 1`
  - `"20-39 Mins" = 2`
  - `"40-59 Mins" = 3`
  - `"60+ Mins" = 4`
- Commute Mode (`commute`)
  - `"Car" = 1`
  - `"Non-Car" = 0`
- Work Frequency On-Site (`work_freq_on_site`)
  - `pmax(C5_1a, C5_1b, na.rm = T)`
- Work Frequency by Remote (`work_freq_remote`)
  - `pmax(C5_1c, C5_1d, na.rm = T)`
- Work Practice, computed by the previous two variables (`work_practice`)
  - `"On-Site" = 1`
  - `"Remote" = 2`
  - `"Hybrid" = 3`
  - `"Infrequent" = 4`
- Work-Time Flexibility (`flexibility`)
  - `"Absolute" = 2`
  - `"Some" = 1`
  - `"No" = 0`
- Home Ownership (`homeownership`)
  - `"Non-Own" = 1`,
  - `"Own" = 2`,

## Data Output

The processed data is output to the original directory.
