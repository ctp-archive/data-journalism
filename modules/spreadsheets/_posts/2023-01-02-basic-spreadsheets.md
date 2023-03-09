---
title: Basic spreadsheets
---

# Basic spreadsheets

Whether it's in Microsoft Excel or Google Sheets, chances are you've at least played around with spreadsheets. Maybe to make a grocery list or a monthly budget. But forget about software for a minute.

## What is a spreadsheet?
A spreadsheet, at its core, is little more than a plain **text file**. What sets it apart from a big pile of **unstructured text**, though, is an encoded structure separating the data into **rows** and **columns**:
* New rows are indicated by **line breaks**
* New columns are indicated by special characters, like commas or tab spacing, or by position
	* Special characters that separate columns are called **delimiters**.
	* Spreadsheets that use position to separate columns are called **fixed-width** files.

![A CSV file viewed in a text editor](/img/wlkthr_gifs/csv_text.png)

Spreadsheet data can be stored in .txt files. Or they can have special extensions for:
* **Comma**-separated value files (.csv)
* **Tab**-separated values files (.tsv). 

Structure makes the text in the file **two-dimensional**, and it expands what we can do with the data once we import it into a spreadsheet software like Excel or Sheets.

Spreadsheet software allows us to add an additional layer of structure with **column types**:
* **Strings** – Think "plain text." Strings are just combinations of characters that can be letters, numbers or any other symbol ("street", "10th street", "No. 10", "ten", "10"). But even if they look like numbers, software won't interpret them as numeric values.
* **Numerics** – Could be integers, decimals, currency, percentages etc. Spreadsheet software can perform arithmetic on numeric values.
* **Dates/times** – Some combination of a date and/or time. There are lots of formats! Spreadsheet software can perform arithmetic on datetime values.
* **Logicals** – Binary values like yes/no or 1/0. These are typically interpreted as true or false.

> **PRO-TIP** The column types of your data may not always be obvious! When you open or import your data, spreadsheet software will often make "guesses" about your data based on a small sample of it.

## Interviewing your data
As we will say a lot in this course, data is as fallible as any other source. 

As journalists, our job is to **interview our data**. But we don't have to be experts to do that. Start with small questions.

Here are a few:
* What do the **descriptive statistics** show?
	* Counts and sums – How many and how much.
	* Average – The sum of all values, divided by the number of values.
	* Median – The middle value of a sorted range of numbers. Also called the typical value.
	* Quartiles – Where the median breaks a sorted list into two halves, quartiles break up into four. 
* How **many times** did something occur?
* Over what **time period**? Are there chronological **patterns**?
* What are the **biggest** or **smallest** values?
* What's happening **nearby**? On your **beat**?
* How do things **compare** by category? Subcategory?
* What's **missing**? Where are the **gaps**?

## Walkthrough
We'll be working with a simplified version of the COVID Tracking Project's data on the state of New York using Google Sheets. Get started by downloading the CSV file below.

<form method="get" action="/materials/covid_ny.csv">
	<button type="submit" class="btn btn-primary"><i class="fa fa-database"></i> Download the data</button>
</form>

### Import the file

In a new browser tab, open a new Google Sheet by typing [sheet.new](http://sheet.new/) in the address bar.

Click where it says "Untitled Spreasheet" and give it a name, then move it somewhere in your Google Drive where you can find it again.

![Opening a new sheet.](/img/wlkthr_gifs/new_sheet.gif)

You can name it anything you want – in our case, we'll keep it simple and use `covid_ny`.

> PRO TIP: It's a good habit to name your files and directories in lowercase WITHOUT any spaces, to make them more computer readable . You can use underscores or dashes to make your names more human readable.

To import the file, click `File > Import` in the main menu, then click `UPLOAD`. From here, you'll need to browse to where you downloaded your CSV file and select it or drag the file directly into the dialogue box.

Specifying `Separator type` gives us some control over how Sheets determines the **column types** in your data. But we can leave this alone for now.

Use the dropdown menu to change the `Import location` to "Replace spreadsheet," then click `OK`. 

![Google Sheet import dialogue](/img/wlkthr_gifs/import_file.png)

Sheets will process the file, and you should see your data!

### Explore what's here

Take a minute to examine the data and think about the fields. Most are self-explanatory. Some less so. Here's the listing from the COVID Tracking Project's field definitions, a **data dictionary** that tells us what each column means.

* [`date`](https://explore.covidtracking.com/field-definitions/date.html) - date on which data was collected by The COVID Tracking Project
* [`state`](https://explore.covidtracking.com/field-definitions/state.html) - two-letter abbreviation for the state or territory
* [`fips`](https://explore.covidtracking.com/field-definitions/fips.html) - Federal Information Processing System (FIPS) code for reporting state
* [`positive`](https://explore.covidtracking.com/field-definitions/positive.html) - total number of confirmed plus probable cases of COVID-19 reported by the state or territory
* [`totalTestResults`](https://explore.covidtracking.com/field-definitions/totalTestEncountersViral.html) - Total number of people tested per day via PCR testing as reported by the state or territory
* [`hospitalizedCurrently`](https://explore.covidtracking.com/field-definitions/hospitalizedCurrently.html) - Individuals who are currently hospitalized with COVID-19
* [`inIcuCurrently`](https://explore.covidtracking.com/field-definitions/inIcuCurrently.html) - individuals who are currently hospitalized in the intensive care unit with COVID-19
* [`onVentilatorCurrently`](https://explore.covidtracking.com/field-definitions/onVentilatorCurrently.html) - individuals who are currently hospitalized under advanced ventilation with COVID-19
* [`death`](https://explore.covidtracking.com/field-definitions/death.html) - total fatalities with confirmed OR probable COVID-19 case diagnosis

> **PRO-TIP** Get the data dictionary for every dataset you work with. It's a handy guide that can help us make sure the data means what we think it means!

For sanity's sake, let's freeze the **header row** – where our column names are – by clicking `View > Freeze > 1 row` or by using the cursor to click and drag the thick grey bar in the top corner of our spreadsheet data. Now no matter where we scroll, we know what our columns mean.

![Freezing the header row](/img/wlkthr_gifs/freeze_header.gif)

There's a good bit of data here, and although it's not impossible to scroll up and down through more than 300 rows, you could imagine this would get tedious if your data was 1,000 or 10,000 rows long.

To make our lives a little easier, we can use a series of keyboard shortcuts to navigate quickly around the sheet. 

Pressing <kbd> CTRL + ↓ </kbd>&ensp;(PC) or <kbd> CMD + ↓ </kbd>&ensp;(Mac), for example, will jump down to the end of your current column – or the last cell with actual data in it. <kbd> CTRL + ↑ </kbd>/<kbd> CMD + ↑ </kbd>&ensp;will jump back up to your header row.

> **PRO-TIP** Bookmark [the link here](/modules/spreadsheets/further-reading/#keyboard-shortcuts) to jump to the full list of keyboard shortcuts quickly.

### Sorting and filtering
By default, the data is sorted by `date` in **descending** order. Let's start from the beginning instead.

On the spreadsheet toolbar, you should see a button that looks like a funnel. 

![Filter icon](/img/wlkthr_gifs/filter.png)

This is your filter toggle, and if you click it, you'll notice a subtle change in your headers. They now have little inverted pyramids next to them!

In the `date` column, click the pyramid to bring up the filter dialogue, then click `Sort A → Z`.

![Sort by date.](/img/wlkthr_gifs/sort_date.gif)

You'll probably notice here that the "dates" don't really look like dates – they're actually numerics. But we'll deal with that later. But if we think about it, we can see that 20200302 translates to "March 2, 2020," the first day data was captured for New York (and about a week before the World Health Organization [declared COVID-19 a pandemic](https://www.cdc.gov/museum/timeline/covid19.html)).

We can also filter our data by **condition**, setting a criteria all rows must meet before they're displayed.

For example, let's see how many days saw **more than 1,000 people on ventilators**.

Click the pyramid next to the `onVentilatorCurrently` column to bring up the filter dialogue, then:
1. Click `Filter by condition`
2. Select `Greater than`
3. Type `1000`
4. Click `OK`

![Sort by date.](/img/wlkthr_gifs/filter_vents.gif)

How many rows is that?

Find out by highlighting one of your columns (try `onVentilatorCurrently`). You'll see a box pop up in the bottom right with a `Sum` value that isn't all that helpful. Click the box to select `Count Numbers` instead (you can also use `Count`, although this will include the header row).

![Get a count of your filtered items.](/img/wlkthr_gifs/rough_count.gif)

From there, we can see that 34 days saw more than 1,000 COVID-19 patients on ventilators.

### What is a function?

Typing the **equal sign** at the beginning of the text string is an indicator to the spreadsheet software that some kind of formula follows (maybe just `=2+2)`.

But spreadsheet software like Sheets has a set of built-in **functions** that perform some action based on the **arguments** they receive. In Excel, Sheets and just about any other spreadsheets software, a function looks like this:

```
=FUNCTION(argument1,argument2)
```

Arguments are contained in **parentheses**, and if there is more than one, they're separated by **commas**.

There are functions to do basic math ([`SUM`](https://support.google.com/docs/answer/3093669)) and parse strings ([`FIND`](https://support.google.com/docs/answer/3094126)) and much more, each of which requires different arguments.


`SUM`, for example, just adds up all the arguments – and you can include as many as you want. The formula itself, once you type it, will only be visible in the function bar right about the spreadsheet. The data itself will show you the value returned by the function.

So `=SUM(2,2)` would display `4`, and it's the equivalent of just typing `=4+4` in the cell.

> **PRO-TIP** Look up Google Sheet formulas and their arguments with [this searchable function list](https://support.google.com/docs/table/25273?hl=en&ref_topic=1361471).

Once you type `=` at the beginning of a cell, you can substitute values from other cells with a **cell reference**, a letter and number combination describing the row and column of the cell.

![A cell reference grid.](/img/wlkthr_gifs/cell_reference.jpeg)

But you don't actually need to look up a cell reference and hand-type it into a cell – once you begin a cell with an equal sign, you click on the cell you want and Sheets will insert the cell reference for you.

### Cleaning data with formulas

We noted before that our "date" field isn't quite right. In this case, Sheets has interpreted that column as a numeric value. So let's practice a little data cleaning to get it right.

Start by toggling your filters off. You should be looking at all your original data – nothing hidden here.

Create a column by right-clicking on the `A` label of the data column, then clicking `Insert 1 column right`. Do this three times more to create four total new empty columns. We'll name them `year`, `month`, `day` and `date_clean`.

![Create and name new columns.](/img/wlkthr_gifs/new_columns.gif)

What we want to do is slice up the sequence of numbers in our `date` column. We'll do that with a few functions designed *exactly* for that purpose: `LEFT`, `MID` and `RIGHT`.

Let's tackle `LEFT` and `RIGHT` first.

```
=LEFT(string, [number_of_characters])
=RIGHT(string, [number_of_characters])
```

These functions take two arguments, `string` which is the sequence of characters we want to work with. In this case, that's our eight-character "date". The second argument is a number that tells the function how many of the string's characters you want to extract, with either the left (the beginning) or the right (the end) as a starting point.

```
=LEFT(12345678, 4)
1234
=RIGHT(12345678, 2)
78
```

The `MID` function follows a similar logic, except there are *three* arguments this time – you need to specify both a starting position as a number and the number of characters you want to extract.

```
=MID(string, starting_at, extract_length)

```

So if we want to start at the fourth character and extract two total characters, our formula would look like this.


```
=MID(12345678, 4, 2)
45
```

Use these formulas to extract the first year, month and day from our `date` column by cell reference.

![Using the LEFT, MID and RIGHT functions.](/img/wlkthr_gifs/left_mid_right.gif)

<div id="accordion" role="tablist">
  <div class="card">
    <div class="card-header" role="tab" id="headingOne">
      <h5 class="mb-0">
        <a class="collapsed" data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
          Show the formulas
        </a>
      </h5>
    </div>
    <div id="collapseOne" class="collapse" role="tabpanel" aria-labelledby="headingOne">
      <div class="card-body">
        <table class="table">
		  <tbody>
		    <tr>
		      <td>year</td>
		      <td>month</td>
		      <td>day</td>
		    </tr>
		    <tr>
		      <td><code class="language-plaintext highlighter-rouge">=LEFT(A2,4)</code></td>
		      <td><code class="language-plaintext highlighter-rouge">=MID(A2,5,2)</code></td>
		      <td><code class="language-plaintext highlighter-rouge">=RIGHT(A2,2)</code></td>
		    </tr>
		  </tbody>
		</table>
      </div>
    </div>
  </div>
</div>

So we've got row of good data. But what about the rest?

Instead of copying the formula hundreds of times, we can use an operation called **fill** instead. In this case, we'll **fill down** – and because we're using cell references, Sheets is smart enough to assume that we want to perform the same operation to the cell in the same relative location all the way down to the bottom of our data.

Use fill down by highlighting the three cells containing your formulas.

In the bottom right corner of the selection you highlighted, you'll see a black square. Hover your cursor over it until the cursor turns into a black cross.

Double-click, and you'll apply the fill down operation to all your rows.

![Demonstrating fill down](/img/wlkthr_gifs/fill_down.gif)

Now we can reconstruct our date using the `DATE` function, which accepts as its three parameters a year, month and day.

```
=DATE(year, month, day)
```

Like you did with our other functions, use cell references to supply your arguments for your very first row of data. Then use the fill down operation to fill in the rest of the rows.

![Using the DATE function.](/img/wlkthr_gifs/date_fix.gif)

You may find that Sheets will prompt you with an option to "autofill" the rest of your rows, which gives you the same result.

There are often multiple ways to perform a task using spreadsheets!

### Adding data with formulas

You probably noticed, just on the cursory look we've given the data so far, that some of the fields counting COVID-19 cases are **cumulative**. That constant growth might obscure some trends and story ideas we might find if were to look at spikes and slowdowns.

Let's create two new columns – `positive_new` and `positive_avg` – at the end of our spreadsheet's existing columns.

We're going to use simple math to calculate the day-to-day changes.

But we need to be careful.

Unlike the previous functions, where we were performing **column-wise** operations that more or less wouldn't be affected by the sorting and filtering, this next step is a **row-wise operation**.

If we sort the data into a different order, the formulas will recalculate and our values will change!

Start this process by sorting our dates in ascending (or oldest to newest) order.

Click on any cell in the `date_clean` column. Then use the menu bar to select `Data > Sort sheet > Sort sheet by column E (A to Z)`.

![](/img/wlkthr_gifs/sort_clean_date.gif)

With our data sorted, we can start generating our new figures.

We want to create a daily count of new cases by subtracting each row's cases by the previous row's cases – today's count minus yesterday's count. But where we previously built our new columns beginning with the first row of data, we actually have to start with day two this time.

Otherwise, we have no "yesterday" to compare with "today."

In the second row of your new `positive_new` column (which is actually marked with a 3 because of the header), type an equal sign and click on the `positive` cell in the same row (H3). Type a minus sign, then click on the `positive` of the previous day (H2). Press enter.

```
=H3-H2
```

You may notice, if you try the fill down trick from our previous steps, that nothing happens.

Why?

Notice that the adjoining `death` column has no data – the state hasn't reported any COVID-19 related deaths yet.

Sheets performs the fill down operation based on the number of rows in the adjoining column. That's why, in our other columns, it didn't keep updating each row all the way down through our 700-odd blank rows. We'll have to fill down a slightly different way this time by higlighting all the cells we want to update.

If you want, you can do this by clicking that black square in the corner of your `positive_new` cell an dragging aaaaaaallll the way down to the bottom of your sheet. But that's annoying. And when your data gets bigger, it's way too time consuming.

Instead, we'll use a few keyboard shortcuts.

Click on any entry.


* calculate difference columns
* calculate average columns
* calculate flag columns

## Exercises

For New York, what's the peak?

Split the class into multiple sections.

Download several different datasets

Answer the following quesitons
- what's the peak

