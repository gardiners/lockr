make_url <- function(redcap_uri, action = c("status", "lock", "unlock")) {
  action <- match.arg(action)
  base_uri <- httr::parse_url(redcap_uri)
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
  list(
    token = token,
    record = record,
    event = event,
    instrument = instrument,
    instance = instance,
    arm = arm,
    returnFormat = "json",
    lock_record_level = "false"
  )
}
