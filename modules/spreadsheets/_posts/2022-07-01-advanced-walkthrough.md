---
title: Advanced spreadsheets - Walkthrough
---

# Walkthrough - Advanced spreadsheets

So far, you've mastered sorting, filtering, functions and other basic spreadsheet operations. But there's so much more you can do with spreadsheets with the help of a few advanced features.

## Jump to a section

1. [Scraping the data](#scraping-the-data)
1. [Data dictionary](#data-dictionary)
1. [Naming your tabs](#naming-your-tabs)
1. [Vlookup](#using-vlookup-to-join-data)
1. [Pivot tables](#using-pivot-tables-to-create-crosstabs)

## Scraping the data

For this walkthrough, we'll be working with long-term care facility outbreak data from the state of [Connecticut](https://explore.covidtracking.com/state/ct/ltc/facilities.html).

But instead of downloading the data as a file and importing it, we're going to use one of Google's built-in scraper functions – [`IMPORTHTML`](https://support.google.com/docs/answer/3093339?sjid=14565079737800821871-NA) – to grab the data and drop it right into a new Google sheet.

But before we do that, we'll need to understand a little more about the function's syntax:

```
IMPORTHTML(url, query, index)
```

The `URL` (or uniform resource locator) we need is just the link containing the data:

https://explore.covidtracking.com/state/ct/ltc/facilities.html

For `query`, this function accepts either "list" or "table." To know which one we need, we'll need to dig into the guts of the web page. Most web browsers have a tool to do just that!

In your browser, right click on the page to bring up the context menu. There should be an option like "Inspect" or "Inspect element," and when you click on that, you'll see a pop-up window with a bunch of code.

![Inspecting elements of a web page.]({{ site.baseurl }}/img/wlkthr_gifs/inspect_element.gif)

What you're seeing is the code – hypertext markup language (HTML) and cascading stylesheets (CSS) – that tell your browser how to render the web page you see. And hovering over each of these elements will highlight them on the page.

You'll see, for example, that hovering over the `<table sticky>` element highlights our table. And that's exactly what we want to capture.

In this case, the `index` is unnecessary since the table we want is the only one on the page.

We should have all the information we need.

Open a new Google Sheet by typing [sheet.new](http://sheet.new/) in the address bar of a new tab. Don't forget to rename it and store it in a easy-to-find location on your Google Drive.

In the first cell (A1) enter the following function and parameters:

```
=IMPORTHTML("https://explore.covidtracking.com/state/ct/ltc/facilities.html","table")
```

After a few seconds of load time, you'll see the data fill in to your sheet *exactly* as it appeared on the web page.

> **PRO-TIP** You may find that trying this on other state sites will give you an error that the URL's contents exceeded maximum size. That's an unfortunate drawback of using Google's free tools!

This is incredibly useful for loading in live updating data on the fly. But this data shouldn't change, so lets do a quick copy/paste to make sure our data stays as is.

* Click on any cell in the sheet and press <kbd> CTRL + A </kbd>&ensp;(PC) or <kbd> CMD + A </kbd>&ensp;(Mac) to select all.
* Right click to bring up the context menu and click `Copy` (or press <kbd> CTRL + C </kbd>&ensp;for PC or <kbd> CMD + C </kbd>&ensp;for Mac).
* Right click to bring up the context menu and click `Paste Special > Values only` (or press <kbd> CTRL + C </kbd>&ensp;for PC or <kbd> CMD + C </kbd>&ensp; for Mac.

![Pasting values only]({{ site.baseurl }}/img/wlkthr_gifs/scrape_paste_values.gif)

In your A1 cell, you should no longer see your `IMPORTHTML` formula in the function bar – just plain old data!

> **PRO-TIP** Remember how to freeze your header row and navigate around the spreadheet? Review what you learned in the [previous submodule]({{ site.baseurl }}/modules/spreadsheets/basic-walkthrough/#navigating-the-spreadsheet).

## Import more data

We'll also use one additional dataset: [2020 town population estimates](https://portal.ct.gov/DPH/Health-Information-Systems--Reporting/Population/Annual-Town-and-County-Population-for-Connecticut) from the Connecticut Department of Public Health.

Download a simplified version of the data here.

<form method="get" action="/materials/ct_city_pop.csv" class="text-center">
	<button type="submit" class="btn btn-primary"><i class="fa fa-database"></i> Download the data</button>
</form>

Then import the data into your existing spreadsheet by choosing `Insert new sheet(s)` in your import options.

> **PRO-TIP** Stuck on how to import? Review what you learned in the [previous submodule]({{ site.baseurl }}/modules/spreadsheets/basic-walkthrough/#import-the-file).

## Data dictionary

We've got two datasets now, so let's examine the field layout or data dictionary for each.

### Long-term facility outbreak data

Taking stock of the facility data, you might notice a lot of empty fields. The CTP staff actually has a whole page of notes with background on what Connecticut reports and what it doesn't.

But for now, here's the data dictionary for the fields actually present in the data that we'll be focused on, [according to the CTP](https://explore.covidtracking.com/field-definitions/ltc-facility/index.html), in this data last recorded March 4, 2021.

* [`city`](https://explore.covidtracking.com/field-definitions/ltc-facility/city.html) - City where facility resides.
* [`facility_name`](https://explore.covidtracking.com/field-definitions/ltc-facility/facility_name.html) - Name of long-term-care facility.
* [`ctp_facility_category`](https://explore.covidtracking.com/field-definitions/ltc-facility/ctp_facility_category.html) - CTP standardized facility types into 3 categories: Nursing Homes, Assisted Living Facilities, and Lumped and Other Facilities.
* [`state_fed_regulated`](https://explore.covidtracking.com/field-definitions/ltc-facility/state_fed_regulated.html) - This category notes whether a facility is regulated by the individual state or by the federal government. When “Federal” appears next to a facility, that means it’s a Nursing Home or Skilled Nursing Facility. When “State” appears, it’s an Assisted Living Facility or other facility. When a blank appears, the regulatory body is unknown.
* [`resident_census`](https://explore.covidtracking.com/field-definitions/ltc-facility/resident_census.html) - The number of residents who live at a particular facility.
* [`resident_positives`](https://explore.covidtracking.com/field-definitions/ltc-facility/resident_positives.html) - Total number of residents who have ever had a COVID case at a facility. 
* [`resident_deaths`](https://explore.covidtracking.com/field-definitions/ltc-facility/resident_deaths.html) - Total number of resident fatalities with confirmed COVID-19 case diagnosis at a facility.
* [`staff_positive`](https://explore.covidtracking.com/field-definitions/ltc-facility/staff_positive.html) - Total number of staff who have ever had a COVID case at a facility.
* [`staff_deaths`](https://explore.covidtracking.com/field-definitions/ltc-facility/staff_deaths.html) - Total number of staff fatalities with confirmed COVID-19 case diagnosis at a facility.

### Connecticut town population data
This is a simplified version of the annual town and county population for Connecticut from the state Department of Public Health

* `state` - Connecticut
* `town` - town name
* `estimated_population` - estimated populations calculated for July 1 of each year and are released by October of the following year.
* `year` - 2020

## Naming your tabs

After both scraping and importing your two datasets, you'll notice your file will have two tabs – labeled `Sheet1` and `Sheet2` – at the bottom left of the spreadsheet.

In addition to being confusing, these names will actually be important later. Double click on the name, or click on the downward-facing caret and click `Rename` in the menu.

Following our best practices for naming files (all lowercase, no spaces, short and sweet), let's name them `facility` and `population`.

![Renaming your sheets]({{ site.baseurl }}/img/wlkthr_gifs/name_sheets.gif)

## Using vlookup to join data

## Using Pivot Tables to create crosstabs

Let's pick two different states to compare
va - eth back to 4/12 for cases, back to 6/14 for deaths
https://explore.covidtracking.com/state/va/crdt/index.html
sc - eth back to 4/12 for cases, back to 11/11 for deaths
fl - eth back to 4/22 for cases, back to 6/17 for deaths
https://explore.covidtracking.com/state/fl/crdt/index.html
ct has facilities with census and fits in limits
la has facilities with census and fits within limits. also has counties

calculate rates of positivity using the census