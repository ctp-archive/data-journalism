# Data journalism with the CTP archive

Designed and created for the [COVID Tracking Project Archive](https://www.library.ucsf.edu/archives/covid-19-pandemic/the-covid-tracking-project-archive/) housed at the University of California San Francisco Archives and Special Collections. Funded by a [data engagement award](https://www.nnlm.gov/about/regions/region5) from the National Network of Libraries of Medicine Region 5.

Uses the [Course-in-a-Box tool](https://course-in-a-box.p2pu.org) from P2PU for building and publishing online courses.

## TODO

- [X] Add pacing
- [ ] Add scripts/sample sheets
- [ ] Proofreading
- [ ] Check links
- [ ] Archive all external links
- [X] Add instructor note to walkthrough
 
## Making changes

To make changes to the template itself, a good place to start is the [`_layouts`](/_layouts), [`_includes`](/_includes) and [`css`](/css) directories. These directories contain all the layout and style files used.

See this [Boostrap 4 cheatsheet](https://hackerthemes.com/bootstrap-cheatsheet/) for a quick reference to classes that mostly work with the underlying Boostrap 4 template in use here.

For custom style used with the CTP Archive project, use the [`css/p2pustrap-custom.scss`](/css/p2pustrap-custom.scss) file.

Push to the `gh-pages` fork.

## Adding materials

Custom-created course materials are stored in the [`materials`](/materials) directory. Other source materials will be linked directly to the CTP Archive where possible.

When linking images, make sure to use `{{ site.baseurl }}` to work with both testing and the deployed version.

## Style notes

Notes to keep styling consistent.

### Credit style for tips and further reading
```
* [Linked title]()
: Author, *Publication*
```

### Instructor note boxes
```
<div class="alert alert-primary" role="alert">
    <strong>FOR INSTRUCTORS:</strong> This message for instructors offers pedagogical guidance and tips on presenting the lesson.
</div>
```

### Pro tip boxes
```
<div class="alert alert-info" role="alert">
    <strong>PRO TIP:</strong> This message for students offers reminders or best practices during walkthroughs and other aspects of the course. Sometimes it might <a href="#!" class="alert-link">include a link</a>.
</div>
```

### Reminder boxes
```
<div class="alert alert-success" role="alert">
    <strong>REMINDER:</strong> Specific instructions involving troubleshooting or avoiding errors and pitfalls.
</div>
```

## Running locally
Local testing done via Jekyll, which can be installed [with the instructions here](https://nicolas-van.github.io/bootstrap-4-github-pages/#run-jekyll-on-your-computer-to-speed-up-testing).

Run in the directory
```bash
bundle exec jekyll serve
```

## Other helpful links
* [Icon reference](https://www.w3schools.com/icons/icons_reference.asp)

---
Course-in-a-Box is built by [Peer 2 Peer University](https://www.p2pu.org) and shared under an MIT License.

Course content shared under a [CC BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/).
