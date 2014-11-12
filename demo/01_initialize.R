#!/usr/bin/Rscript
# Purpose:         Small initialization script
# Date:            2014-11-12
# Author:          Tim Hagmann
# Notes:           WINDOWS: In order for it to work, RTools() has to be installed
# R Version:       R version 3.1.1 -- "Sock it to Me"
################################################################################

## Creat Environment
if(any(search() %in% "initEnv")) detach("initEnv")
initEnv <- new.env()

## Library Functions
# Function to load libraries
initEnv$loadLibraries <- function(required_packages){
  required_packages_cut <- cutTxt(x=required_packages, identifier="@", cut2="right") # Remove @ dev etc.

  for(i in seq_along(required_packages_cut)){
    library(required_packages_cut[i], character.only=TRUE)
  }
}

# Function to find missing packages
initEnv$findMissingPackages <- function(required_packages){
  required_packages_cut <- cutTxt(x=required_packages, identifier="@", cut2="right") # Remove @ dev etc.
  missing_packages <- required_packages[!(required_packages_cut %in% installed.packages()[ ,"Package"])]
  missing_packages
}

# Function to install and/or load packages from CRAN
initEnv$packagesCRAN <- function(required_packages, update=FALSE){
  missing_packages <- findMissingPackages(required_packages)

  if(length(missing_packages) > 0 || update){
    if(update){missing_packages <- required_packages} # Base (required)
    install.packages(missing_packages)
  }

  loadLibraries(required_packages)
}

# Function to install and/or load missing packages from Bioconductor
initEnv$packagesBioconductor <- function(required_packages, update=FALSE){
  missing_packages <- findMissingPackages(required_packages)

  if(length(missing_packages) > 0 || update){
    if(update){missing_packages <- required_packages} # Base (required)

    if(Sys.info()["sysname"][[1]] == "Linux"){
      source(pipe(paste("wget -O -", "https://rawgit.com/greenore/initR/master/biocLite.R")))
    } else {
      source("https://rawgit.com/greenore/initR/master/biocLite.R")
    }
    
    biocLite(missing_packages)
  }

  loadLibraries(required_packages)
}

# Function to install and/or load missing packages from Github
initEnv$packagesGithub <- function(required_packages, repo_name, auth_token=NULL,
                           proxy_url=NULL, port=NULL,
                           update=FALSE){
  packagesCRAN("devtools")

  missing_packages <- findMissingPackages(required_packages)

  if(length(missing_packages) > 0 || update){
    setProxy(proxy_url=proxy_url, port=port)
    full_repo_name <- paste0(repo_name, '/', missing_packages)    # Base (missing)

    if(update) {
      full_repo_name <- paste0(repo_name, '/', required_packages) # Base (required)
    }

    for(i in seq_along(full_repo_name)){
      install_github(repo=full_repo_name[i], auth_token=auth_token)
    }
  }

  loadLibraries(required_packages)
}

## Proxy Functions
# Function to ping a server (i.e., does the server exist)
initEnv$pingServer <- function(url, stderr=FALSE, stdout=FALSE, ...){
  vec <- suppressWarnings(system2("ping", url, stderr=stderr, stdout=stdout, ...))
  if (vec == 0){TRUE} else {FALSE}
}

# Function to set a proxy
initEnv$setProxy <- function(proxy_url, port){
  packagesCRAN("httr")

  port <- as.numeric(port)

  if(pingServer(proxy_url)){
    usr <- readline("Bitte Benutzername eingeben: ")
    pwd <- readline("Bitte Passwort eingeben: ")
    cat("\14")

    reset_config()
    set_config(use_proxy(url=proxy_url, port=port, username=usr, password=pwd))
  }
}

## Additional helper functions
# Cut txt to either the left or right of an identifier
initEnv$cutTxt <- function(x, identifier, regex="[[:alnum:]]{1, }", cut2="right"){
  if(cut2=="right"){
    x <- gsub(paste0(identifier, regex), "", x)
  }

  if(cut2=="left"){
    x <- gsub(paste0(regex, identifier), "", x)
  }
  x
}

## Attach environment
attach(initEnv)
rm(initEnv)
