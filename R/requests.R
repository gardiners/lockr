# HTTP requests and response parsing

request <- function(target, payload){
  response <- httr::POST(url = target,
                         encode = "form",
                         body = payload,
                         httr::user_agent("https://github.com/gardiners/lockr"))

  if (response$status_code != 200) {
    err_message <- xml2::xml_text(httr::content(response, type = "text/xml"))
    stop(err_message)
  }

  # httr::stop_for_status(response)

  httr::content(response, type = "application/json")
}

