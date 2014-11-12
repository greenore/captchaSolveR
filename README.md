captchaSolveR
=============

## Introduction

**captchaSolveR** is an open source packages to tackle the problem of captcha codes. There are in principal two ways to crack a captcha. The first one is to use machine learning and image recognition. The second one to use a mechanical turk (i.e., real humans). There are helper functions for both methods in this package.

### Install 

Installing directly from Github requires some helper packages. The easiest way to setup **captchaSolveR** is to source the following «[init.R][1]» script and then install and run the package with the packagesGithub function. Furthermore, in order to read as well as solve captcha images, **captchaSolveR** heavily relies on the «[EBImage][2]» package and also utilizes some functions from the «[systemR][3]» and «[ocR][4]» package. The package is not on CRAN and has to be installed directly from Bioconductor. Running the following lines of code installs and loads everything for captchaSolveR to work:

#### Windows:
```
source("https://rawgit.com/greenore/initR/master/init.R")
packagesBioconductor("EBImage")
packagesGithub(c("systemR", "ocR", "captchaSolveR"), repo_name="greenore")
```

#### Unix like systems:
```
source(pipe(paste("wget -O -", "https://rawgit.com/greenore/initR/master/init.R")))
packagesBioconductor("EBImage")
packagesGithub(c("systemR", "ocR", "captchaSolveR"), repo_name="greenore")
```

[1]: https://github.com/greenore/initR/blob/master/init.R
[2]: http://www.bioconductor.org/packages/release/bioc/html/EBImage.html
[3]: https://github.com/greenore/systemR
[4]: https://github.com/greenore/ocR

