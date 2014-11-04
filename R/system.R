# System Functions
#-----------------
#' @export
getTasklist <- function(){
  # Get Tasklist
  tl <- system('tasklist', wait = T, intern = T)
  tl <- tl[5:length(tl)]
  
  # Remove Whitespace
  for(i in 1:10){tl <- gsub('  ' , ' ', tl)}
  
  # Split Table
  df.tl <- t(as.data.frame(strsplit(tl, ' '), stringsAsFactors = F))
  rownames(df.tl) <- NULL
  df.tl <- data.frame(df.tl, stringsAsFactors = F)
  
  # Rename Table
  if(length(df.tl) > 0){
    names(df.tl) <- c('ImageName', 'ProcessID', 'Session', 'SessionNR', 'Memusage', 'Size')
  } 
  df.tl  
}

#' @export
killTask <- function(name){
  for(i in name){
    path <- paste('taskkill /f /im ', i, sep = '')
    system(path, wait = F, intern = F)  
  }
}

#' @export
# IMPORT DATA FROM THE CLIPBOARD
readClip <- function(header = T, ...){
  read.table("clipboard", sep="\t", header = header, ...)
}

#' @export
# EXPORT DATA TO THE CLIPBOARD
writeClip <- function(x, row.names = F, col.names = T, ...){
  write.table(x, "clipboard", sep = "\t", row.names = row.names, col.names = col.names, ...)
}
