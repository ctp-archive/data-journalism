---
title: What is a spreadsheet?
---

# What is a spreadsheet?

***Total suggested time: 10 minutes***

## Lecture: Defining a spreadsheet
*Suggested time: 10 minutes*

Whether it's in Microsoft Excel or Google Sheets, chances are you've at least played around with spreadsheets. Maybe to make a grocery list or a monthly budget. But forget about software for a minute.

A spreadsheet, at its core, is little more than a plain **text file**. What sets it apart from a big pile of **unstructured text**, though, is an encoded structure separating the data into **rows** and **columns**:
* New rows are indicated by **line breaks**
* New columns are indicated by special characters, like commas or tab spacing, or by position
	* Special characters that separate columns are called **delimiters**.
	* Spreadsheets that use position to separate columns are called **fixed-width** files.

![A CSV file viewed in a text editor]({{ site.baseurl }}/img/wlkthr_gifs/csv_text.png)

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