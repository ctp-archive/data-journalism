# covid_analysis.R
# A script to accompany instructional materials for the COVID Tracking Project
# data journalism course in a box module Intro to R - R and the Tidyverse
# https://ctp-archive.github.io/data-journalism/modules/intro-to-r/tidyverse/

# Installing and importing packages ---------------------------------------

#install the tidyverse package
#REMINDER: This step is only required ONCE for your machine.
install.packages("tidyverse")

#load our packages from our library into our workspace
#REMINDER: This step is required EACH TIME we start R or start a new workspace.
library(tidyverse)


# Downloading and importing data ------------------------------------------

#load in our ny covid data
covid_ny <- read_csv('data/ny.csv')

#how many rows do we have?
covid_ny %>% 
  nrow()

#make sure we've got 371 dates
covid_ny %>% 
  count(date)

#show me all the column names
covid_ny %>% 
  glimpse()

#what's up with the count function?
?count()

# Sorting and filtering ---------------------------------------------------

#show the peak of hospitalizations in New York
covid_ny %>% 
  arrange( desc(hospitalizedCurrently) )

#show the days with more than 1000 people on vents
covid_ny %>% 
  filter(onVentilatorCurrently > 1000)

#show the days with more than 1000 people on vents
#in a new tab to explore all of the results
covid_ny %>% 
  filter(onVentilatorCurrently > 1000) %>% 
  view()


# Cleaning data with mutate -----------------------------------------------

#convert the date and save to a new dataframe
covid_ny_clean <- covid_ny %>% #assign to new variable
  mutate(date_clean = as.character(date), #convert to character
         date_clean = as.Date(date_clean, format = '%Y%m%d')) %>% #convert to date format
  relocate(date_clean, .after = date) #change column order

#display an explanation of the lag function
?lag

#compute change in values for hospitalizations
covid_ny_clean <- covid_ny_clean %>% #overwrite our existing table
  arrange(date_clean) %>% #sort by ascending date
  mutate(hospitalizedIncrease = hospitalizedCurrently - lag(hospitalizedCurrently)) #calculate the change


# Grouping by variables ---------------------------------------------------

#test out the summarize function
covid_ny_clean %>% 
  summarize(
    total_cases = sum(positiveIncrease), #calculate the total
    avg_increase = mean(positiveIncrease), #calculate the average
    median_increase = median(positiveIncrease), #calculate the median (middle value)
    max_increase = max(positiveIncrease) #calculate the maximum
  )

#group by year and month
covid_ny_clean %>%
  mutate(year = year(date_clean),
         month = month(date_clean)) %>% #create a few temporary variables
  group_by(year, month) %>% #group by our new year and month variables
  summarize(total_cases = sum(positiveIncrease)) #summarize the increase