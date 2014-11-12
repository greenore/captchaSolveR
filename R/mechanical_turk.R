#' @export
# Post Captcha Code on www.deathbycaptcha.eu
postCaptcha <- function(url, user, pass, path){
  require(RCurl)
  
  result <- postForm(url, username=user, password=pass,
                     captchafile=fileUpload(filename=path, contentType='image/jpg'))
  result
}

#' @export
# Get Captcha Code Result from www.deathbycaptcha.eu
getCaptcha <- function(url, id){
  require(RCurl)
  
  url <- paste(url, '/', sep='')
  url <- paste(url, id, sep='')
  
  result <- getURL(url)
  result
}

#' @export
# Report Error on www.deathbycaptcha.eu
reportCaptcha <- function(url, user, pass){
  require(RCurl)
  
  url <- paste(url, '/', sep='')
  url <- paste(url, id, sep='')
  url <- paste(url, '/report', sep='')
  
  result <- postForm(url, username=user, password=pass)
  result
}
