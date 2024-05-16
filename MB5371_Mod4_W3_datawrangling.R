# ------ Workshop 3 - Data wrangling --------
library(tidyverse)

## Tidy data:
table1 # check out the correct layout of data

# Use a pipe and apply a function to it. 

# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>% 
  count(year, wt = cases)

# Visualize changes over time:
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

## Exercises ##
# Try in own time #

## Pivoting data to make it tidy

# Lengthening datasets

# Billboard dataset
billboard

# Use pivot_longer to tidy billboard dataset sot hat there are now columns of weeks:
billboard |> 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank"
  )

# Remove NAs to tracks that did not spend time on the chart:
billboard |> 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank",
    values_drop_na = TRUE
  )

# Data is now tidy!


# Pivoting longer:

# Create a tribble
df <- tribble(
  ~id,  ~bp1, ~bp2,
  "A",  100,  120,
  "B",  140,  115,
  "C",  120,  125
)
df

# We want data to have 3 variables: id, measurement and value.
# Pivot df to be longer to include these variable names:
df |> 
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )

# Widening datasets
 # Use cms_patient_experience dataset
cms_patient_experience
# Issue here is that organization is spread across 6 ros. Create 1 variable that encompasses it all:
cms_patient_experience |> 
  distinct(measure_cd, measure_title)

# Use pivot_wider
cms_patient_experience |> 
  pivot_wider(
    names_from = measure_cd,
    values_from = prf_rate
  )
# still doesn't look quite right, still have multiple rows for each organisation.
# Need to tell pivot_wider() which column or columns have values that identify each row, so 'org':
cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )
# much better

# Pivoting wider - understanding how it works
# Create dataset:
df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)
# widen dataset:
df |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

df |> 
  distinct(measurement) |> 
  pull()

# Exercises 4.5.5 - for later

# Separating and uniting data tables
table3
# need to separate 'cases' and 'population':
table3 %>% 
  separate(rate, into = c("cases", "population"))
# both cases and population still listed as 'character' data types.
# Can use separate() and convert to integers:
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

# For practice, separate year into 'century' and 'year:
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)
# Now, use unite() to unite century and year again:
table5 # has year separated already into century and year
table5 %>% 
  unite(new, century, year, sep = "")

## Handling missing values:

# Explicit missing values (NAs)
# Load a dataset that contains lots of NAs:
treatment <- tribble(
  ~person,           ~treatment, ~response,
  "Derrick Whitmore", 1,         7,
  NA,                 2,         10,
  NA,                 3,         NA,
  "Katherine Burke",  1,         4
)

# Fill in missing values with tidyr:fill():
filltreat <-treatment |>
  fill(everything())

# Fixed values
# Replace NA with 0 if you know NA represented '0' rather than a missing value:
x <- c(1, 4, 5, 7, NA)
coalesce(x, 0)

# Replace a concrete value with NA if it is in fact meant to represent a missing value:
x <- c(1, 4, 5, 7, -99)
na_if(x, -99)

# NaN - not a number
# Distinguish NA with NaN:
x <- c(NA, NaN)
x*10
x==1
is.na(x)

# Implicit missing values - blank cells
# Load stocks dataset:
stocks <- tibble(
  year  = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr   = c(   1,    2,    3,    4,    2,    3,    4),
  price = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)
# dataset has two missing observations
# Use pivot_wider to widen stocks dataset:
stocks
stocks |>
  pivot_wider(
    names_from = qtr, 
    values_from = price
  )

## Importing data to into R
#Exercise
read_csv("a,b\n1,2,3\n4,5,6")
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")


# exercise to bind dataframes
one <- starwars[1:4, ]
two <- starwars[9:12, ]
bind_rows(one, two)
