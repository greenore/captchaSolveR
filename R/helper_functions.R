#' @export
# Get IP information
getIP <- function(src = 'offline'){
  if(src == 'offline'){
    x <- system("ipconfig", wait = F, intern = T)
    x <- x[grep("IPv4", x)]
    result <- gsub(".*? ([[:digit:]])", "\\1", x)
  }
  if(src == 'online'){
    require(XML)
    
    html <- htmlParse('http://ipaddress.com/')
    result <- data.frame(readHTMLTable(html, header = F))
    names(result) <- c('Object', 'Attribute')
  }
  result
}

#' @export
# Open a new VPN instance
openVPN <- function(nr, protocol = 'UDP'){
  list <- list.files('C:/Program Files/OpenVPN/config')
  expr <- paste(protocol, '.ovpn', sep = '')
  expr <- paste('[[:print:]]{1, }.', expr, sep = '')
  list <- regmatches(list, regexpr(expr, list))
  path <- paste('openvpn-gui.exe --connect', list[nr], sep = ' ')
  system(path, wait = F, intern = F)  
}