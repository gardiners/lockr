set_redcap_uri <- function(redcap_uri){
  options(redcap_uri = redcap_uri)
}

get_redcap_uri <- function(){
  getOption("redcap_uri")
}

set_redcap_token <- function(token){
  options(redcap_token = token)
}

get_redcap_token <- function(){
  getOption("redcap_token")
}
