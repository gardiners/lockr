make_url <- function(redcap_uri, action = c("status", "lock", "unlock")) {
  action <- match.arg(action)
  base_uri <- httr::parse_url(redcap_uri)

  if(is.null(base_uri$scheme) | is.null(base_uri$host)) {
    stop("Problem with redcap_uri: both protocol and hostname must be specified.")
  }

  if(base_uri$path == "") {
    warning("redcap_uri should have the form https://foo.bar/api/")
  }

  query <- list(
    NOAUTH = "",
    type = "module",
    prefix = "locking_api",
    page = action
  )

  base_uri$query <- query
  httr::build_url(base_uri)
}

record_payload <- function(token, record){
  list(
    token = token,
    format = "json",
    returnFormat = "json",
    lock_record_level = "true",
    record = jsonlite::toJSON(record)
  )
}

data_payload <- function(token, record, event, instrument, instance, arm) {
  elements <- c(purrr::compact(as.list(environment())),
                list(returnFormat = "json"))
  purrr::cross(elements)
}
