# covid_viz.R
# A script to accompany instructional materials for the COVID Tracking Project
# data journalism course in a box module Intro to R - Investigating disparities in R
# https://ctp-archive.github.io/data-journalism/modules/intro-to-r/data-viz/

# Getting set up ----------------------------------------------------------

#install other packages
#REMINDER: This step we'll only have to do ONCE for each package.
install.packages('zoo') #handy set of functions for advanced calculations
install.packages('geofacet') #neat tools for visualization

#REMINDER: This step we'll have to do EACH TIME we start R or start a new workspace.
library(tidyverse)
library(zoo)
library(geofacet)

# Downloading and importing the data --------------------------------------

#load in our us covid data
covid_time_series <- read_csv('data/all-states-history.csv')

# Recapping grouping and summarizing --------------------------------------

#count the number of rows for NC only
covid_time_series %>%
  filter(state == 'NC') %>% #filter for North Carolina
  nrow() #count the rows

#get the count of rows/observations for each state
covid_time_series %>% 
  group_by(state) %>% #group by state postal abbreviation
  summarize(count = n()) %>% #summarize by group and count
  arrange(desc(count)) #arrange in descending order

#create a separate dataframe for North Carolina
covid_nc <- covid_time_series %>% #assign the output to new variable
  filter(state == 'NC') %>% #filter by NC postal abbrev
  arrange(date) #arrange by date

# Getting started with ggplot ---------------------------------------------

#display a simple line chart of case counts
ggplot(covid_nc) + #input the data
  aes(date, positive) + #define the x and y axes
  geom_line() #use lines as visual marks

#an alternative method of charting a line chart with a plot
covid_nc %>% #input our covid data
  ggplot(aes(date, positive)) + #define the x and y axes
  geom_line() #use lines as visual marks


# Adding style to graphics ------------------------------------------------

#make a prettier plot by adding in styling in ggplot
covid_nc %>%
  ggplot(aes(date, positive)) + #define the x and y axes
  geom_line(color = 'blue') + #make a line chart and define the color
  scale_x_date(date_breaks = '2 months', date_labels = "%b %y") + #specify a date interval
  labs(title = "COVID-19 positive cases in North Carolina", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

# Calculating rolling averages --------------------------------------------

#chart new cases instead of cumulative cases
covid_nc %>%
  ggplot(aes(date, positiveIncrease)) + #define the x and y axes
  geom_line(color = 'blue') + #make a line chart and define the color
  scale_x_date(date_breaks = '2 months', date_labels = "%b %y") + #specify a date interval
  labs(title = "COVID-19 positive cases in North Carolina", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

#calculate rolling average of new cases as a new column
covid_nc_rolling <- covid_nc %>%
  select(date, positiveIncrease) %>% 
  mutate(rolling_new = rollmean(positiveIncrease, #specify our variable
             7, #calculate over seven days
             fill = NA, #ignore if there are blank cells
             align = "right"), #set the direction we want our rolling window to go
         rolling_new = round(rolling_new) #round the variable to the nearest whole number
         )

#chart the rolling average of cases in North Carolina
covid_nc_rolling %>%
  ggplot(aes(date, rolling_new)) + #define the x and y axes
  geom_line(color = 'blue') + #make a line chart and define the color
  scale_x_date(date_breaks = '2 months', date_labels = "%b %y") + #specify a date interval
  labs(title = "COVID-19 positive cases in North Carolina", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

# Combining different geoms -----------------------------------------------

#combine a bar and line chart with identity
covid_nc_rolling %>%
  ggplot() + #define the x and y axes
  geom_bar(aes(date, positiveIncrease), stat = 'identity', color = 'lightgrey') + #move the aesthetic down to the geom
  geom_line(aes(date, rolling_new), stat = 'identity', color = 'blue') + #include the stat parameter
  scale_x_date(date_breaks = '2 months', date_labels = "%b %y") + #specify a date interval
  labs(title = "COVID-19 positive cases in North Carolina", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

# Patterns in small multiples ---------------------------------------------

#calculate rolling averages for each state
covid_rolling <- covid_time_series %>%
  arrange(state, date) %>% #arrange by state, then date
  group_by(state) %>% #group by state so our rollmean doesn't average different states
  select(state, date, positiveIncrease) %>% #simplify our data
  mutate(rolling_new = rollmean(positiveIncrease, #specify our variable
                                7, #calculate over seven days
                                fill = NA, #ignore if there are blank cells
                                align = "right"), #set the direction we want our rolling window to go
         rolling_new = round(rolling_new) #round the variable to the nearest whole number
  )

#try filtering for a state
covid_rolling %>%
  filter(state == 'NY') #choose a state with the filter

#create a line chart for all states' rolling averages of new cases
covid_rolling %>% 
  ggplot(aes(date, rolling_new, color = state)) + #define the x and y axes - and color
  geom_line() + #make a line chart - no color definitition this time
  scale_x_date(date_breaks = '2 months', date_labels = "%b %y") + #specify a date interval
  labs(title = "COVID-19 positive cases in US states", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

#create a geofacet across US states
covid_rolling %>% 
  ggplot(aes(date, rolling_new)) + #define the x and y axes - no color this time
  geom_line(color = 'blue') + #make a line chart, and add the color back
  facet_geo(~state, grid = "us_state_grid2") + #facet over a predefined US grid
  scale_x_continuous(labels = NULL) + #specify we want a continuous (number) scale
  labs(title = "COVID-19 positive cases across the US", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.line.x = element_line(color="black", linewidth = 0.25),
        axis.line.y = element_line(color="black", linewidth = 0.25),
        panel.grid.major.x = element_line( color="grey", linewidth = 0.25 ),
        panel.grid.major.y = element_line( color="grey", linewidth = 0.25 ), 
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )

#create a geofacet across US states with a variable access
covid_rolling %>% 
  ggplot(aes(date, rolling_new)) + #define the x and y axes - no color this time
  geom_line(color = 'blue') + #make a line chart, and add the color back
  facet_geo(~state, grid = "us_state_grid2", scales="free_y") + #the free_y gives our charts a variable axis
  scale_x_continuous(labels = NULL) + #specify we want a continuous (number) scale
  labs(title = "COVID-19 positive cases across the US", #label our axes
       caption = "SOURCE: COVID Tracking Project",
       x = "",
       y = "Case count") +
  theme(strip.text.x = element_text(size = 10), #do a little styling
        strip.background.x = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(), #remove the y axis labels for space
        panel.background = element_blank(),
        plot.title = element_text(size = 12),
  )
