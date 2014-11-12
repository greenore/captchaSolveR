captchaSolveR
=============

## Introduction

**captchaSolveR** is an open source packages to tackle the problem of captcha codes. There are in principal two ways to crack a captcha. The first one is to use machine learning and image recognition. The second one to use a mechanical turk (i.e., real humans). There are helper functions for both methods in this package.

### Install captchaSolveR

Installing directly from Github requires some helper packages and **Tesseract**. The easiest way to setup **captchaSolveR** is to source the following «[init.R][1]» script and then install and run the package with the packagesGithub function. Furthermore, in order to read as well as solve captcha images, **captchaSolveR** heavily relies on the «[EBImage][2]» package and also utilizes some functions from «[systemR][3]» and «[ocR][4]». Running the following lines of code installs and loads captchaSolveR:

#### Windows:
```
source("https://rawgit.com/greenore/initR/master/init.R")
packagesBioconductor("EBImage")
packagesGithub(c("systemR", "ocR", "captchaSolveR"), repo_name="greenore")
```

#### Linux:
```
source(pipe(paste("wget -O -", "https://rawgit.com/greenore/initR/master/init.R")))
packagesBioconductor("EBImage")
packagesGithub(c("systemR", "ocR", "captchaSolveR"), repo_name="greenore")
```

### Install Tesseract (OCR Engine)

#### Linux:
Tesseract is available directly from many Linux distributions. The package is generally called 'tesseract' or 'tesseract-ocr' - search your distribution's repositories to find it. Packages are also generally available for language training data (search the repositories,) but if not you will need to download the appropriate training data, unpack it, and copy the .traineddata file into the 'tessdata' directory, probably /usr/share/tesseract-ocr/tessdata or /usr/share/tessdata.

```
# On Ubuntu the following command will install tesseract
sudo apt-get update
sudo apt-get install tesseract-ocr
```

#### Mac OS X
The easiest way to install Tesseract is with MacPorts. Once it is installed, you can install Tesseract by running the command sudo port install tesseract, and any language with sudo port install tesseract-<langcode>. List of available langcodes can be found on MacPorts tesseract page.

#### Windows
An installer is available on the [Tesseract-OCR][5] project page. This includes the English training data.

[1]: https://github.com/greenore/initR/blob/master/init.R
[2]: http://www.bioconductor.org/packages/release/bioc/html/EBImage.html
[3]: https://github.com/greenore/systemR
[4]: https://github.com/greenore/ocR
[5]: https://code.google.com/p/tesseract-ocr/

