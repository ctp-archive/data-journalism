---
title: Walkthrough - Investigating disparities
---

# Walkthrough - Investigating disparities in R

## Jump to a section
1. [Getting set up](#getting-set-up)
1. [Downloading and importing the data](#downloading-and-importing-the-data)
1. [Creating comparisons]()
1. [Understanding joins]()
1. [Creating clean keys for joins]()
1. [Executing the join]()

## Getting set up

Create a new R project called `covid_disparities`.

Create a new folder in your project directory called `data`.

And start a new R script in your main project directory, and `Save as...` with a name of your choice.

<div class="alert alert-warning"><b>NOTE:</b> For a refresher, see <a href="{{ site.baseurl }}/modules/intro-to-r/tidyverse/#starting-an-r-project">Starting an R Project</a> in the previous module.</div>

Load our [Tidyverse](https://www.tidyverse.org/) package, which we should already have installed

<div class="alert alert-warning"><b>NOTE:</b> This step &#x2935; we'll have to do EACH TIME we start R or start a new workspace.</div>

```R
#load our packages from our library into our workspace
library(tidyverse)
```
<div class="alert alert-success"><b>PRO TIP:</b> If you get an error about R not being able to locate a package, make sure you have it installed!</div>

## Downloading and importing the data

The data we'll be working with for this walkthrough comes from the COVID Tracking Project's [race and ethnicity file for Nevada](https://explore.covidtracking.com/state/nv/crdt/index.html), portions of which we've already used.

Download the CSV file here and save it to `data` folder in the R project directory you created above.

<form method="get" action="https://explore.covidtracking.com/download/state/nv/nv-race-ethnicity.csv" class="text-center">
  <button type="submit" class="btn btn-primary"><i class="fa fa-database"></i> Download the data</button>
</form>

Once our file is saved, we'll load it in into a new dataframe called `covid_race_nv` with a function from our Tidyverse package.

```R
#load in our us covid data
covid_race_nv <- read_csv('data/all-states-history.csv')
```

Take note that in your "Environment" window (by default in the top right), you should be able to see your `covid_race_nv` dataframe with more than 20,000 rows and 41 variables.

We'll need one more dataset. This one is the race and ethnicity breakdown of the Nevada population, according to [the 2020 5-year American Community Survey](https://data.census.gov/table?q=hispanic&g=040XX00US32&y=2020&d=ACS+5-Year+Estimates+Detailed+Tables).

<form method="get" action="{{ site.baseurl }}/materials/nv_race_ethnicity_census.csv" class="text-center">
  <button type="submit" class="btn btn-primary"><i class="fa fa-database"></i> Download the data</button>
</form>

Download the file and save it to your project file's `data` directory. Then import the data into your workspace.

This is a pretty small file: just 9 rows and 3 columns.

## Creating comparisons

There's a lot we can do with these two separate datasets, especially if we're interested in better understanding the unequal impacts of COVID-19 on different racial and ethnic groups.

And the math is pretty simple.

But before we get to the equations – and the code – it can help to think through in plain language what we want to find out. For example:

```
How does the percentage of Hispanic COVID-19 deaths of compare to the percentage of Hispanics in Nevada overall?
```

Single question, two numbers to compare. And a good, quick indicator of what a disparity might look like.

Let's tackle the first part:

```
What percentage of total COVID-19 deaths in Nevada were identified as Hispanic?
```

We know we'll get that from our COVID data, but we can use `glimpse()` to get a quick look at which fields we want to use to make our calculation.

```R
#get a quick look at the fields in our data
covid_race_nv %>% 
  glimpse()
```

A few things to note here:
1. Judging by the `date` field, this is another time series dataset, and our most recent total is in the first row
2. Our total is in the `Deaths_Total` field
3. Our Hispanic figure is in the `Deaths_Hispanic` field

![Glimpsing the fields of our COVID data.]({{ site.baseurl }}/img/wlkthr_gifs/r_glimpse_race_eth.png)

We don't actually need a complex Tidyverse chain of commands here. We just need to a few special operators R uses to access data inside our dataframe.

The next two lines of code tell R we want the list of values from specific columns (using the `$` operator) and the value from the first row only (the `[[]] notation`). And in this case, we want essentially the same thing from two different columns.

```R
#store the numerator and denominator
hisp_deaths <- covid_race_nv$Deaths_LatinX[[1]]
total_deaths <- covid_race_nv$Deaths_Total[[1]]
```

Now we can calculate a percentage with the numerator and denominator and a little rounding.

```R
#calculate the proportion of total deaths as a percentage
round(hisp_deaths / total_deaths * 100, 1)
```

Hispanic residents in Nevada made up 24% of COVID-19 deaths.

Let's move on to the next question.

```
What percentage of Nevada residents are Hispanic?
```

View the dataframe by clicking on the `census_race_nv` in your environment pane. 

The data in this simplified census table is formatted a little differently, but we can use similar code to pull the values we need, which happen to be in the `estimate` column this time, and the 1st and 9th rows. So we can adjust our commands accordingly.

```R
#store the population numerator and denominator
hisp_pop <- census_race_nv$estimate[[9]]
total_pop <- census_race_nv$estimate[[1]]

#then calculate the proporation as a percentage
round(hisp_pop / total_pop * 100, 1)
```

Hispanic residents in Nevada were about 29% of the population in 2020.

So:

**Hispanic residents in Nevada made up 24% of COVID-19 deaths, despite making up 29% of the population there.**

Not much of a disparity there it appears. What about the other racial groups?

We could repeat these steps, but the process is a little tedious. What if we make a similar calculations for every racial group all at once?

## Understanding joins

Before we get there thought, let's talk about **joins**.

<div class="alert alert-warning"><b>NOTE:</b> If you worked with a previous module on advanced spreadsheets, some of this might sound familiar.</div>

At their core, joins in data journalism and data science (or any other field that works with databases) is just a way to link to datasets together using a common, matching field – often called a **key**.

<div class="alert alert-success"><b>PRO TIP:</b> Joins like these will only match if the two terms are EXACTLY equal – that means they have to be equal data types too.</div>

There are lots of [types of joins](https://dplyr.tidyverse.org/reference/mutate-joins.html), but for this analysis, we'll use a **left join**. 

![Left join visualization.]({{ site.baseurl }}/img/wlkthr_gifs/left_join.png)

Left joins preserve the entirety of Database A, adding any elements of Database B where the keys match. Think of A, or your left side, as your **primary data**, while B, on the right side, is **supplementary** information you want to add.

Following that guideline, our lefthand dataset should be `covid_race_nv` and our righthand dataset should be `census_rate_nv`.

## Creating clean keys for joins

We're going to match on the race/ethnicity label. But you may have already noticed that the two datasets use different labels – a literal join won't match `Black` with `Black or African American`.

So we need to do a little data cleaning first.

We already know we can simplify. We only need the most recent date, so we can filter for that. We can also remove all the columns we don't need with `select()`. But instead of typing out all of the death columns, we can actually take advantage of a little convenience function called `starts_with()` to only give us fields starting with `Death_`.

```R
#testing out some data simplification
covid_race_nv %>% 
  filter(Date == '20210307') %>% 
  select(starts_with('Deaths_')) 
```

We also need one more new function: `pivot_longer()`.

This data is currently "wide." We need it to be "long" to get it to match up with our census datasets.

![Wide vs. long data]({{ site.baseurl }}/img/wlkthr_gifs/r_wide_long.png)

And that's where `pivot_longer()` can help – it basically just transposes the data based on a few parameters:
* `cols` - the columns you want to transpose
* `names_to` - name of the new column where your old column names go
* `values_to` - name of the new column where the values in your old columns go

In our code, we'll define `cols` using another convenience function called `everything()` that returns *all* the columns at once. We'll also use an optional parameter, `names_prefix`, to remove the unnecssary `Deaths_` text from our race/ethnicity label.

```R
#simplify and reformat the covid data
covid_race_match <- covid_race_nv %>% #store clean data into a new variable
  filter(Date == '20210307') %>% #get the most recent date
  select(starts_with('Deaths_')) %>% #simplify by selecting death columns only
  pivot_longer(cols = everything(), #specify the columns you want to transpose
               names_prefix = 'Deaths_', #provide a prefix to remove (optional)
               names_to = 'label', #name of the new column where your old column names go
               values_to = 'deaths' #name of the new column where the values in your old columns go
               )
```

Now onto the right side of our join. This data is mostly fine, but we'll need to standardize the labels so we're sure they'll match with our COVID data. To do that, we'll create a new dataframe using the `case_when()` function.

Basically just a cleaner form of the **if/then** statement, `case_when()` allows us to take every wrong label and turn it into the right one. We'll use the labels in our `covid_race_match` dataset to make those corrections.

Notice, with the code below, that we don't need to fix *all* of the labels, only the ones that don't match. To catch everything else, we'll just set a `.default` parameter that sets anything that doesn't match to the original label text.

```R
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
```

Now, we're ready to join.

## Executing the join

In the Tidyverse, the `left_join()` function accepts two dataframes (left and right) and a `by` parameter, which tells the function what keys actually want to match on.

Since we're using the Tidyverse pipe syntax (`%>%`), we'll start with the left dataframe (`covid_race_match`), then feed in the righthand dataset (`census_race_match`). For the `by` parameter, we'll pass in the column names of the keys we're matching, which in this case are both named `label`.

```R
#executing the join
covid_race_joined <- covid_race_match %>% 
  left_join(census_race_match, by = c('label' = 'label')  )
```

Now, repeating our earlier check of disparities only takes a few lines of code.

```R
#calculate comparison rates
covid_race_joined %>% 
  mutate(pop_pct = round(estimate / covid_race_joined$estimate[[1]] * 100, 1),
         death_pct = round(deaths / covid_race_joined$deaths[[1]] * 100, 1)
         )
```

![Executing mutates on our combined datasets]({{ site.baseurl }}/img/wlkthr_gifs/r_comparison_rates.gif)

## Calculating rates

TK

## Converting math to sentences

TK




