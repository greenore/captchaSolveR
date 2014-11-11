# Captcha Functions
#------------------

#' @title Transforms an image to Greyscale
#' @export
#' 
#' @description \code{img2Grey} transforms a multilayered and multicolored 
#' Image into a Greyscale image. 
#'  
#' @param img An image resulting from a readImage import.
#' 
#' @examples
#' captcha <- img2Grey(captcha)

img2Grey <- function(img){
  require(EBImage)
  
  # Image to grey Scale
  img <- channel(img, "gray")
  img
}

#' @title Makes dark colors black and light colors white, i.e. sharpens the colors
#' @export
#' 
#' @description \code{sharpenImage} transforms a multilayered and multicolored 
#' Image into a Greyscale image. 
#'  
#' @param img An image resulting from a readImage import.
#' @param limit The color limit value [0, 1], where 0 is black and 1 is white. 

sharpenImage <- function(img, limit){
  require(EBImage)
  
  # Get image data
  img_data <- imageData(img)
  
  # Change according to limit
  img_data[img_data < limit] <- 0
  img_data[img_data >= limit] <- 1
  
  # Output
  imageData(img) <- img_data
  img
}

#' @title Find parts of an image that is white
#' @export
#' 
#' @description \code{isWhite} is looking for the parts in an image that are  
#' white (rgb=255) and returns a logical vector (T or F).
#'  
#' @param img A matrix of imagedata resulting from a readJpeg import.
#' @param axes Either 'v' or 'h', is the image scaned trough vertically or 
#' horizontally.
#' 
#' @examples
#' whiteVector <- isWhite(letter, axes='h')

isWhite <- function(img_data, axes='v'){
  
  # Length & Width
  width <- length(img_data[1, ])
  height <- length(img_data[, 1])
  
  dfWhite <- NULL
  
  # Cut off vertically
  if(axes == 'v'){
    for(x in 1:width){
      dfWhite[x] <- sum(img_data[, x] != 1)
    }
  }
  
  # Cut off horizontally
  if(axes == 'h'){
    for(y in 1:height){
      dfWhite[y] <- sum(img_data[y, ] != 1)
    }
  }
  
  dfWhite > 0
}

#' @title Cut-off whitespace (with 1px left)
#' @export
#' 
#' @description \code{cutWhite} 
#'  
#' @param letter
#' 

cutWhite <- function(letter){
  require(EBImage)
  
  # Length & Width
  width <- length(letter[1, ])
  height <- length(letter[, 1])
  
  # Run length encoding
  rleHoriz <- rle(isWhite(letter, axes='h'))
  rleVerti <- rle(isWhite(letter, axes='v'))
  
  # Margins (with 1px white)
  TM <- rleHoriz$lengths[1]
  RM <- rleVerti$lengths[length(rleVerti$lengths)] - 1
  BM <- rleHoriz$lengths[length(rleHoriz$lengths)] - 1
  LM <- rleVerti$lengths[1]
  
  # cutting according to css box model
  letter <- letter[TM:(height - BM), LM:(width - RM)]
  letter
}

#' @title Seperate letters
#' @export
#' 
#' @description \code{sepLetter} 
#'  
#' @param img
#' @param nLetter
#' 

sepLetter <- function(img, nLetter){
  require(EBImage)
  
  # Get image data
  img_data <- imageData(img)
  img_data <- transpose(img_data)
  
  # Length & Width
  width <- length(img_data[1, ])
  height <- length(img_data[, 1])
  
  # Run length encoding
  rleVerti <- rle(isWhite(img_data, axes='v'))
  rleVerti$cumsum <- cumsum(rleVerti$lengths)
  
  # x Coordinates left and right side
  xLeft <- rleVerti$cumsum[rleVerti$values == F][1:(length(rleVerti$cumsum[rleVerti$values == F])-1)]
  xRight <- rleVerti$cumsum[rleVerti$values == T] + 1
  
  # Cut letter
  letter <- img_data[, xLeft[nLetter]:xRight[nLetter]]
  letter <- cutWhite(letter)
  
  # Change direction
  letter <- transpose(letter)
  
  letter
}

#' @title Creat a Canvas
#' @export
#' 
#' @description \code{makeCanvas} 
#'  
#' @param nrows
#' @param ncols
#' 

makeCanvas <- function(nrows, ncols){
  canvas <- transpose(matrix(data=rep(1, nrows * ncols), nrow=nrows, ncol=ncols))
  canvas
}

#' @title Rotate a letter
#' @export
#' 
#' @description \code{rotLetter} 
#'  
#' @param letter
#' @param canvas_size
#' @param angle
#' @param cutoff
#' 

rotLetter <- function(letter, canvas_size, angle, cutoff=1/5){
  require(EBImage)
  
  # Prepare canvas
  canvas <- makeCanvas(nrows=canvas_size, ncols=canvas_size)
  
  # Center coordinates of the canvas (e.g., c(50, 50))
  center_x <- nrow(letter)/2
  center_y <- ncol(letter)/2
  
  # Zero coordinates of the canvas c(0, 0)
  zero_x <- canvas_size/2 - center_x
  zero_y <- canvas_size/2 - center_y
  
  # Max. width and max. height of the letter
  width_x <- length(letter[, 1])
  height_y <- length(letter[1, ])
  
  # Plot the letter on the canvas
  for(y in 1:height_y){
    for(x in 1:width_x){
      canvas[zero_x + (x - 1), zero_y + (y - 1)] <- letter[x, y]
    }
  }
  
  # Rotate the canvas
  canvas.r <- rotate(canvas, angle=angle)
  
  # Cut the Canvas by a percentage
  canvas.r <- canvas.r[(cutoff * canvas_size):((1 - cutoff) * canvas_size),
                       (cutoff * canvas_size):((1 - cutoff) * canvas_size)]
  
  canvas.r
}

#' @title Is a letter a M or W
#' @export
#' 
#' @description \code{isMW} 
#'  
#' @param letter
#' 

isMW <- function(letter){
  #require(biOps)
  
  width <- letter[1, ]
  height <- letter[, 1]
  
  nPixel <- round(length(width) * 2/5)
  nPixel2 <- round(length(width) * 1/15)
  
  xLeft <- letter[, (1 + nPixel2):nPixel]
  xRight <- letter[, (length(letter[1, ]) - nPixel):(length(letter[1, ]) - nPixel2)]
  
  xLeft <- isWhite(sharpenImage(xLeft), axes='h')
  xRight <- isWhite(sharpenImage(xRight), axes='h')
  
  rleLeft <- rle(xLeft)
  rleRight <- rle(xRight)
  
  x <- NULL  
  if(length(rleLeft$values) == 7){
    if(sum(rleLeft$values == c(F, T, F, T, F, T, F)) == 7){
      x[1] <- T
    }
  }
  
  if(length(rleRight$values) == 7){
    if(sum(rleRight$values == c(F, T, F, T, F, T, F)) == 7){
      x[2] <- T
    }
  }
  sum(x, na.rm=T) > 0
}

#' @title Rotate a letter
#' @export
#' 
#' @description \code{rotationFun} rotates a letter according to it's width, i.e.,
#' it minimizes or maximizes it (for the letters M & W). 
#' 
#' @param letter
#' 

rotationFun <- function(letter){
  #require(biOps)
  
  ## Rotate, cut horizontal and vertical whitespace / get the width
  rotation <- c(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, -5, -10, -15, -20,
                -25, -30, -35, -40, -45, -50)
  #   rotation <- c(0, 22.5, 45, 67.5, 90, -22.5, -45, -67.5, -90)
  df <- data.frame(rotation)
  
  for(i in 1:length(rotation)){
    df$width[i] <- length(cutWhite(rotLetter(letter, cSize=100, angle=rotation[i], cutoff=1/5))[1, ])
    df$height[i] <- length(cutWhite(rotLetter(letter, cSize=100, angle=rotation[i], cutoff=1/5))[, 1])
  }
  
  # min width
  df$opt <- df$width
  optRotation <- df$rotation[df$opt == min(df$opt)][1]
  
  # Rotate the letter
  letter_temp <- cutWhite(rotLetter(letter, cSize=100, angle=optRotation, cutoff=1/5))
  
  # Check if not a M or W
  if(isMW(letter_temp)){
    df <- data.frame(rotation)
    
    for(i in 1:length(rotation)){
      df$width[i] <- length(cutWhite(rotLetter(letter, cSize=100, angle=rotation[i], cutoff=1/5))[1, ])
      df$height[i] <- length(cutWhite(rotLetter(letter, cSize=100, angle=rotation[i], cutoff=1/5))[, 1])
    }
    
    # max width
    df$opt <- df$width
    optRotation <- df$rotation[df$opt == max(df$opt)][1]
    
    letter_temp <- cutWhite(rotLetter(letter, cSize=100, angle=optRotation, cutoff=1/5))
  }
  letter_temp
}

#' @title Plot Letter on a canvas
#' @export
#' 
#' @description \code{plotLetters} 
#'  
#' @param letter
#' @param canvas
#' @param number
#' @param widthLetter
#' 

plotLetters <- function(letter, canvas, number, widthLetter=30){
  
  # Max. width and max. height of the letter
  widthX <- length(letter[, 1])
  heightY <- length(letter[1, ])
  
  # Zero coordinates of the canvas c(Y, X)
  zeroY <- length(canvas[, 1])/2
  zeroX <- 10 + (widthLetter * (number - 1))
  
  # Plot the letter on the canvas
  for(y in 1:heightY){
    for(x in 1:widthX){
      canvas[zeroY + (x - 1), zeroX + (y - 1)] <- letter[x, y]
    }
  } 
  
  imagedata(canvas)
}

#' @title Rotate Letter randomly
#' @export
#' 
#' @description \code{rotateAndCombine} 
#'  
#' @param letter
#' 

rotateAndCombine <- function(letter){
  #require(biOps)
  
  ## Rotate, cut horizontal and vertical whitespace / get the width
  rotation <- seq(-55, 55, by=5)
  
  # Prepare canvas
  canvas <- makeCanvas(nrows=70, ncols=800)
  
  # Rotate the letter
  for(i in 1:length(rotation)){
    canvas <- plotLetters(cutWhite(rotLetter(letter, cSize=100, angle=rotation[i], cutoff=1/5)), canvas, number=i)
  }
  
  
  canvas
}
