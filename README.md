captchaSolveR
=============

## Introduction

**captchaSolveR** is an open source packages to tackle the problem of captcha codes. There are in principal two ways to crack a captcha. The first one is to use machine learning and image recognition. The second one to use a mechanical turk (i.e., real humans). There are helper functions for both methods in this package.

### Install 

Installing packages directly from Github is easiest with the «[devtools][1]» package. Furthermore, In order to read as well as solve captcha images, **captchaSolveR** heavily relies on the «[EBImage][2]» package. The following functions install and load the necessary packages: 

```
source("https://rawgit.com/greenore/initR/master/init.R")
packagesGithub(captchaSolveR, repo_name="greenore")
packagesBioconductor("EBImage")
```

[1]: http://cran.r-project.org/web/packages/devtools/index.html
[2]: http://cran.r-project.org/bin/windows/Rtools/
