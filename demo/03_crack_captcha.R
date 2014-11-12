## Read image
captcha_loc <- 'data/captcha/captcha1.jpg'
captcha_col <- readImage(captcha_loc)

## Sharpen image and subtract color
captcha <- sharpenImage(captcha_col, limit=0.6)
captcha <- img2Grey(captcha)
captcha <- sharpenImage(captcha, limit=0.8)

## Seperate, rotate, combine and cut the letters
num_letters=6
rotation=seq(-90, 90, by=5)
nrows=80
ncols=2000

ls.letters <- list()
for(i in 1:num_letters){
  letter <- sepLetter(captcha, letter_num=i)
#   letter <- angleRotation(letter, angle=rotation)
  letter <- rotateAndCombine(letter, angle=rotation, nrows, ncols)
  ls.letters[[i]] <- cutWhite(letter)
}

## OCR the letters
dir_path <- paste0(getwd(), "/data/captcha")
input_file <- "input.jpeg"
output_file <- "output"
ocr <- NULL

for(i in 1:num_letters){
  writeImage(ls.letters[[i]], paste0(dir_path, "/", input_file), type="jpeg")
  result <- ocrTesseract(dir_path, image_name=input_file, output_base=output_file,
                         psm=5)
  char_count <- countChar(tolower(result), letters)
  ocr[i] <- chooseChar(char_count)
}
