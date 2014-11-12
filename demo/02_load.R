## Load Dependencies
# Bioconductor
required_packages <- c("EBImage")
packagesBioconductor(required_packages, update=update_packages)

# Github
required_packages <- c("systemR", "ocR", "captchaSolveR")
packagesGithub(required_packages, repo_name="greenore",
               update=update_packages)

rm(required_packages, update_packages)
