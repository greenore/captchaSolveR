captchaSolveR
=============

## Introduction

**captchaSolveR** is an open source packages to tackle the problem of captcha codes. There are in principal two ways to crack a captcha. The first one is to use machine learning and image recognition. The second one to use a mechanical turk (i.e., real humans). There are helper functions for both methods in this package.

### Install 

Installing directly from Github requires some helper packages. The easies way to setup **captchaSolveR** is to source the following «[init.R][1]» script and then install and run the packages with the **packagesGithub** function. Furthermore, In order to read as well as solve captcha images, **captchaSolveR** heavily relies on the «[EBImage][2]» package. The package is not on CRAN and has to be installed directly from Bioconductor. Running the following lines of code install and load everything for captchaSolveR to work:

```
source("https://rawgit.com/greenore/initR/master/init.R")
packagesGithub("captchaSolveR", repo_name="greenore")
packagesBioconductor("EBImage")
```

[1]: https://github.com/greenore/initR/blob/master/init.R
[2]: http://cran.r-project.org/bin/windows/Rtools/
