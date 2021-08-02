record_action <- function(record, action = c("status", "lock", "unlock"), redcap_uri, token) {
  target <- make_url(redcap_uri, action)
  payload <- record_payload(token, record)
  request(target, payload)
}

lock_record <-function(record, redcap_uri, token) {
  record_action(record, action = "lock", redcap_uri = redcap_uri, token = token)
}

unlock_record <- function(record, redcap_uri, token) {
  record_action(record, action = "unlock", redcap_uri = redcap_uri, token = token)
}

record_status <- function(record, redcap_uri, token) {
  record_action(record, action = "status", redcap_uri = redcap_uri, token = token)
}
