captchaSolveR
=============

## Introduction

**captchaSolveR** is an open source packages to tackle the problem of captcha codes. There are in principal two ways to crack a captcha. The first one is to use machine learning and image recognition. The second one to use a mechanical turk (i.e., real humans) to solve the problem. There are helper functions for both ways in this package.

### Install 

To install captchaSolveR from Github requires the devtools package from CRAN. That means running the following commands:

```
install.packages("devtools")
devtools::install_github(repo="greenore/captchaSolveR")
```
### Dependency

In order to read as well as solve captcha images, **captchaSolveR** utilizes heavily the «[EBImage][1]» package. To install and load it, you can use the following functions:

```
source("https://rawgit.com/greenore/initR/master/init.R")
packagesBioconductor("EBImage")
rm(list = ls())
```
