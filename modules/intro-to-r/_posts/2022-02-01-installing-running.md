---
title: Installing and running
---

# Installing and running

***Total suggested time: 30 minutes***

<div class="alert alert-primary" role="alert">
    <strong>FOR INSTRUCTORS:</strong> Consider assigning these steps for students to complete on their own outside of class, providing technical help asynchronously.
</div>

There are a variety of ways to work with R, which is the actual __language__. For most of the projects here, we'll be using RStudio, a popular **integrated development environment** (IDE) that essentially functions as a user interface for the R language itself.

## On your own: Getting started with R

*Suggested time: 10-15 minutes*

### Step 1: Install R

Download and install the [latest version of R from CRAN](https://cran.rstudio.com/), the "Comprehensive R Archive Network," for your operating system:

[https://cran.rstudio.com/](https://cran.rstudio.com/)

No need to change any of the settings in the default install wizard.

*NOTE: If you're on a Mac, and you get an error about not being able to open an application downloaded from the Internet, right-click (or control-click) on the file and click "Open" on the dialog to override Apple's sometimes finicky security settings.*

### Step 2: Install RStudio

Download and install the latest version of RStudio (the website should automatically suggest the version for your operating system):

[https://www.rstudio.com/products/rstudio/download/#download](https://www.rstudio.com/products/rstudio/download/#download)

*NOTE: If you're on a Mac, you may have to drag and drop the RStudio icon into your Applications folder to complete the install.*

### Step 3: Open RStudio

To make sure everything is installed correctly, navigate to wherever your applications are stored and launch RStudio.

You may see an icon for R – we won't actually be launching this application, since we're using the interface instead.

## On your own: R basics

*Suggested time: 10-15 minutes*

### Starting a new script in RStudio

When you open RStudio, for the first time, you'll see a few different panes in your workspace. The largest is your console, which you can use to directly enter commands using the R language.

Some commands, like simple arithmetic, are pretty obvious! Try typing the following into your console panel.

```R
100 + 100
```

Execute the code by clicking `Code > Run Selected Line(s)` or with <kbd>Command</kbd> + <kbd>Enter</kbd>.

![Simple addition in the RStudio console]({{ site.baseurl }}/img/wlkthr_gifs/r_simple_addition.gif)

Practice executing code with a few other simple calculations.

For the most part though, we won't be working in the console directly. We'll be writing our R code in an **R script**, a separate file we can save, reload and share.

At the top menu, click `File > New File > R Script` to start a new script. You'll see your blank file appear in a new pane in RStudio. Go ahead and `Save As...` to give it a name. You should get in the habit of saving your work often.

![Starting a new script]({{ site.baseurl }}/img/wlkthr_gifs/r_studio_start.png)

### Commenting code

At the top of your script, write a quick **comment** that tells you something about what your new script does.

Starting each line with a `#` character will ensure this line is not executed when you run your code.

```R
    #My first R script
    #Hands-on exercise on March 3, 2023
```

### Storing variables
You can also store variables using an **assignment function**.

Variable types (which may sound familiar to column types we discussed in the [spreadsheet module]({{ site.baseurl }}/modules/spreadsheets/what-is-a-spreadsheet/) describe the nature of the data stored in each variable.

The most basic variable types are **characters**, **numerics**, **dates** and **logicals**. 

```R
current_year <- 2022

current_date <- as.Date('2022-01-10')

current_month <- 'January'

is_winter <- TRUE
```

You can also store multiple values as a **vector** or **list**.

```R
primes <- c(2, 3, 5, 7, 11)

months <- c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')
```

And you can call those values by their numerical index with the double bracket notation.

```R
#return the third prime
primes[[3]]

#return the fifth month
months[[5]]
```

R has a lot of great, basic functionality built in. But an entire community of R developers has created a long list of packages that give R a wealth of additional tricks.

We'll talk about some of those next.

For a list of common R terms and some handy keyboard shortcuts, [check out the Tips and Further Reading page]({{ site.baseurl }}/modules/spreadsheets/further-reading/).