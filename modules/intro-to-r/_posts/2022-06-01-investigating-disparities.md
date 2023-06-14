---
title: Investigating disparities in R
---

# Investigating disparities in R


## Joining other data

Among the fields in our data is a column called `NAICSCode`, which is the code assigned by the [North American Industry Classification System](https://www.census.gov/naics/). It basically describes what type of business the company is in. The codes are standardized, meaning we can use them to find out how funds are distributed across industry types, but we'll need to join them up to do that.

First, [download our NAICS lookup table here]({{ site.baseurl }}/assets/data/naics_lookup.zip). Then unzip the file and move it to your working directory.

<div class="alert alert-warning"><b>NOTE:</b> If you're getting errors here &#x2935; make sure your file is downloaded, unzipped and in the correct directory.</div>

```R
# load in our naics lookup table
naics <- read_csv('naics_lookup.csv')
```

The dataset we'll be joining is a lookup table using the first two digits of the NAICS code, which describes the top-level industry type.

First, let's make sure we have a column to match on.

We'll use the `mutate()` function like we did before, but we'll use it in combination with two other functions: `substr()` and `strtoi()`. The first take a "substring" of each NAICS code (just the first to characters of the text). The second converts that text number (a "string") into an _actual_ numeric type, or an "integer" (strtoi = string to int).

```R
#create a two-digit naics code using the first two positions in our longer naics code
ppp_150k_clean_naics <- ppp_150k_clean %>%
  mutate(NAICS_initial = strtoi(substr(NAICSCode, start = 1, stop = 2)))
```

There are lots of [types of joins](https://dplyr.tidyverse.org/reference/mutate-joins.html), but for this analysis, we'll use a __LEFT JOIN__. 

Our PPP data is our __left__ table (Table A in the example below), and our NAICS lookup table is our __right__ table (Table B in the example below).

![Left join visualization.]({{ site.baseurl }}/img/wlkthr_gifs/left_join.png)

Executing a left join using our two-digit naics code means that only columns from our NAICS lookup table that matches will be tacked on to our PPP data.

The `left_join()` function accepts a dataframe (`naics`, in this case) and a `by` parameter, which tells the function what we actually want to match on.

In this case, the column names we want to match are different. That's OK! We just use the left table's column name on the left of the equal sign, and the right table's column name on the right of the equal sign.

```R
#practice doing a left join
ppp_150k_clean_naics %>% #our leftside table
  left_join(naics, #our rightside table
            by = c('NAICS_initial' = 'naics_initial_code') #our left and right match columns
            )
```

That output, if it runs correctly, isn't terribly interesting.

<div class="alert alert-success"><b>PRO TIP:</b> Joins like these will only match if the two terms are EXACTLY equal – that means they have to be equal data types too. The string version of 23 and a numeric 23, for example, won't match. That's why we set our newly <code>NAICS_initial</code> variable to numeric.</div>

There are so many columns, in fact, we can't even see if the ones we're interested in (`naics_title`) are even in the dataframe we created!

So once we know our join works, lets add a little more code to group those results and summarize them into something interesting.

We'll do that with the `group_by()` function, which accepts a field/column name and works in concert with the `summarize()` function to run those descriptive statistics across the _group_ rather than the whole column.

Then we can arrange the result to see the top loan recipients by industry.

```R
ppp_150k_clean_naics %>% #our leftside table
  left_join(naics, #our rightside table
            by = c('NAICS_initial' = 'naics_initial_code') #our left and right match columns
  ) %>%
  group_by(naics_title) %>% #group by our newly joined naics description
  summarize(total = sum(InitialApprovalAmount)) %>% #give us the sum for each group.
  arrange(desc(total)) #arrange in descening order by total
```

