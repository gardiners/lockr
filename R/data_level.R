
data_action <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, action, redcap_uri, token) {

  target <- make_url(redcap_uri, action)
  payloads <- data_payload(token, record, event, instrument, instance, arm)

  purrr::map(payloads,
             function(payload) request(target, payload))
}

lock_data <- function(record, event = NULL, instrument = NULL, instance = NULL,
                      arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "lock"))
}

unlock_data <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "unlock"))
}

data_status <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "status"))
}
