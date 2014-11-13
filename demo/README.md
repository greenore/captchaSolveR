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

The first part is to Sharpen image and subtract color, i.e., make it black and white.
       
![](https://cdn.rawgit.com/greenore/captchaSolveR/master/data/captcha/captcha_bw.jpeg "Captcha_BW")

After that the letters can be seperated, rotated, and combinend so that they can be put trough the tesseract ocr engine. With a simple majoritiy voting the most likely letter is then determined.
    
![](https://cdn.rawgit.com/greenore/captchaSolveR/master/data/captcha/captcha_letter5.jpeg "Captcha_Letter5")

Author: Tim Hagmann

[1]: https://github.com/greenore/captchaSolveR/tree/master/demo
[2]: https://github.com/greenore/captchaSolveR/tree/master/data/captcha
[3]: https://github.com/greenore/captchaSolveR/tree/master/demo/00_main.R
