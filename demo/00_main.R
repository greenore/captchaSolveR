#!/usr/bin/Rscript
# Purpose:         Solve Captcha Codes
# Date:            2014-11-13
# Author:          Tim Hagmann
# Notes:           In order for it to work, Tesseract has to be installed.
# R Version:       R version 3.1.2 -- "Pumpkin Helmet"
################################################################################

## Download init File
# download.file(url="https://rawgit.com/greenore/initR/master/init.R",
#               destfile="demo/01_initialize.R",
#               method=ifelse(Sys.info()["sysname"][[1]] == "Linux", "wget", "auto"))

## Source Files
update_packages <- FALSE
source("demo/01_initialize.R")
source("demo/02_load.R")
source("demo/03_crack_captcha.R")

## Display and compare
display(captcha_col)
paste0(ocr, collapse="")
