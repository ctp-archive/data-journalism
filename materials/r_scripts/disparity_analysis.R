# disparity_analysis.R
# A script to accompany instructional materials for the COVID Tracking Project
# data journalism course in a box module Intro to R - Investigating disparities in R
# https://ctp-archive.github.io/data-journalism/modules/intro-to-r/investigating-disparities/

# Getting set up ----------------------------------------------------------

#load our packages from our library into our workspace
library(tidyverse)

# Downloading and importing the data --------------------------------------

#load in covid nv race and ethnicity data
covid_race_nv <- read_csv('data/nv-race-ethnicity.csv')

#load in nv race and ethnicity population data
census_race_nv <- read_csv('data/nv_race_ethnicity_census.csv')

# Creating comparisons ----------------------------------------------------

#get a quick look at the fields in our data
covid_race_nv %>% 
  glimpse()

#store the numerator and denominator
hisp_deaths <- covid_race_nv$Deaths_LatinX[[1]]
total_deaths <- covid_race_nv$Deaths_Total[[1]]

#calculate the proportion of total deaths as a percentage
round(hisp_deaths / total_deaths * 100, 1)

#store the population numerator and denominator
hisp_pop <- census_race_nv$estimate[[9]]
total_pop <- census_race_nv$estimate[[1]]

#then calculate the proporation as a percentage
round(hisp_pop / total_pop * 100, 1)

# Creating clean keys for joins -------------------------------------------

#testing out some data simplification
covid_race_nv %>% 
  filter(Date == '20210307') %>% 
  select(starts_with('Deaths_')) 

#simplify and reformat the covid data
covid_race_match <- covid_race_nv %>% #store clean data into a new variable
  filter(Date == '20210307') %>% #get the most recent date
  select(starts_with('Deaths_')) %>% #simplify by selecting death columns only
  pivot_longer(cols = everything(), #specify the columns you want to transpose
               names_prefix = 'Deaths_', #provide a prefix to remove (optional)
               names_to = 'label', #name of the new column where your old column names go
               values_to = 'deaths' #name of the new column where the values in your old columns go
               )

#clean census data with matching covid labels
census_race_match <- census_race_nv %>% 
  mutate(label = case_when(
    label == 'Black or African American' ~ 'Black',
    label == 'American Indian and Alaska Native' ~ 'AIAN',
    label == 'Native Hawaiian and Other Pacific Islander' ~ 'NHPI',
    label == 'Some other race' ~ 'Other',
    label == 'Two or more races' ~ 'Multiracial',
    label == 'Hispanic or Latino' ~ 'LatinX',
    .default = label
  ))

# Executing the join ------------------------------------------------------

#join the census and covid data
covid_race_joined <- covid_race_match %>% #store output into a new variable
  left_join(census_race_match, #dataset to join on the right side
            by = c('label' = 'label') #keys provided in a 
            )

# Calculating rates -------------------------------------------------------

#calculate comparison rates
covid_race_joined %>% 
  mutate(pop_pct = round(estimate / covid_race_joined$estimate[[1]] * 100, 1),
         death_pct = round(deaths / covid_race_joined$deaths[[1]] * 100, 1)
         )

#calculate comparison rates by subgroup
covid_race_joined %>% 
  mutate(pop_pct = round(estimate / covid_race_joined$estimate[[1]] * 100, 1),
         death_pct = round(deaths / covid_race_joined$deaths[[1]] * 100, 1),
         death_rate = deaths / estimate
  )

#calculate comparison rates by subgroup with rounding
covid_race_joined %>% 
  mutate(pop_pct = round(estimate / covid_race_joined$estimate[[1]] * 100, 1),
         death_pct = round(deaths / covid_race_joined$deaths[[1]] * 100, 1),
         death_rate = round(deaths / estimate * 100000, 1)
  )

# Disparity ratios --------------------------------------------------------

#calculate comparison rates by subgroup with rounding
covid_race_joined %>% 
  mutate(pop_pct = round(estimate / covid_race_joined$estimate[[1]] * 100, 1),
         death_pct = round(deaths / covid_race_joined$deaths[[1]] * 100, 1),
         death_rate = round(deaths / estimate * 100000, 1)
  )
