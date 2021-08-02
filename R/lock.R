lock_record <-function(record, redcap_uri, token) {
  record_action(record, action = "lock", redcap_uri = redcap_uri, token = token)
}

unlock_record <- function(record, redcap_uri, token) {
  record_action(record, action = "unlock", redcap_uri = redcap_uri, token = token)
}

record_status <- function(record, redcap_uri, token) {
  record_action(record, action = "status", redcap_uri = redcap_uri, token = token)
}


lock_data <- function() {}

unlock_data <- function() {}

data_status <- function() {}


record_action <- function(record, action = c("status", "lock", "unlock"), redcap_uri, token) {
  target <- make_url(redcap_uri, action)
  payload <- record_payload(token, record)
  request(target, payload)
}

data_action <- function(record, event = "", instrument = "", instance = "",
                        arm = "", action, redcap_uri, token) {

  target <- make_url(redcap_uri, action)

  tasks <- purrr::cross_df(list(token = token,
                               record = record,
                               event = event,
                               instrument = instrument,
                               instance = instance,
                               arm = arm))

  responses <- purrr::pmap(tasks,
                           function(token, record, event, instrument, instance, arm){
                             payload <- data_payload(token = token, record = record,
                                                     event = event, instrument = instrument,
                                                     instance = instance, arm = arm)
                             request(target, payload)
                           }
  )
  responses

}
