# Data journalism with the CTP archive

Designed and created for the [COVID Tracking Project Archive](https://www.library.ucsf.edu/archives/covid-19-pandemic/the-covid-tracking-project-archive/) housed at the University of California San Francisco Archives and Special Collections. Funded by a [data engagement award](https://www.nnlm.gov/about/regions/region5) from the National Network of Libraries of Medicine Region 5.

Uses the [Course-in-a-Box tool](https://course-in-a-box.p2pu.org) from P2PU for building and publishing online courses.

## TODO

- [ ] Figure out a way to print the walkthrough only as an accompanying PDF.
- [ ] Specify what should be flipped vs. done with an instructor

## Making changes

To make changes to the template itself, a good place to start is the [`_layouts`](/_layouts), [`_includes`](/_includes) and [`css`](/css) directories. These directories contain all the layout and style files used.

See this [Boostrap 4 cheatsheet](https://hackerthemes.com/bootstrap-cheatsheet/) for a quick reference to classes that mostly work with the underlying Boostrap 4 template in use here.

For custom style used with the CTP Archive project, use the [`css/p2pustrap-custom.scss`](/css/p2pustrap-custom.scss) file.

Push to the `gh-pages` fork.

## Adding materials

Custom-created course materials are stored in the [`materials`](/materials) directory. Other source materials will be linked directly to the CTP Archive where possible.

When linking images, make sure to use `{{ site.baseurl }}` to work with both testing and the deployed version.

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
