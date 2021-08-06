#' Perform record-level locking operations
#'
#' @param action A character string for the action to perform on records. One of "lock", "unlock" or "status"
#'
#' @return A dataframe with one row per record affected by the operation.
#' @export
#' @inheritParams data_action
record_action <- function(record, action = c("status", "lock", "unlock"), redcap_uri, token) {
  target <- make_url(redcap_uri, action)
  payload <- record_payload(token, record)
  request(target, payload)
}

#' @describeIn record_action Return the lock status of record/s
#' @export
record_status <- function(record, redcap_uri, token) {
  record_action(record, action = "status", redcap_uri = redcap_uri, token = token)
}

#' @describeIn record_action Lock named record/s
#' @export
lock_record <-function(record, redcap_uri, token) {
  record_action(record, action = "lock", redcap_uri = redcap_uri, token = token)
}

#' @describeIn record_action Unlock named record/s
#' @export
unlock_record <- function(record, redcap_uri, token) {
  record_action(record, action = "unlock", redcap_uri = redcap_uri, token = token)
}
