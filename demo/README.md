Documentation
=============

## Goal
Solve captcha codes with Tesseract.

## Principal structure
- All the code necessary for the analysis is in the «[demo][1]» folder
- All data, i.e., the captcha codes are in the «[data/captcha][2]» folder

## Reproducabilty
In order to replicate the analysis, the steps in the «[00_main.R][3]» script have to be followed.

## The idea
In this example we are going to use captcha like the following images:
  
  
![](https://cdn.rawgit.com/greenore/captchaSolveR/master/data/captcha/captcha1.jpg "Captcha1")

It's easy to observe the followings. First of all, a fixed font has been used and the distortions are held to a minimum. This makes extracting all the letters and using them as masks to check each digit, one by one, very easy. Also, the alphabet is simple lowercase hexadecimal letters.

The first part is to to extract all the letters. Then, the letters are made black and white and cropped, one by one. After that the letters are plotted with seperate rotations and put through the tesseract ocr engine. With a simple majoritiy voting the most likely letter is determined.

Author: Tim Hagmann

[1]: https://github.com/greenore/captchaSolveR/tree/master/demo
[2]: https://github.com/greenore/captchaSolveR/tree/master/data/captcha
[3]: https://github.com/greenore/captchaSolveR/tree/master/demo/00_main.R
