#' Perform data-level locking operations
#'
#' @param record A vector of REDCap record names to affect. Required.
#' @param event A character vector specifying the event/s to affect. Ignored if REDCap project is not longitudinal
#' @param instrument A character vector specifying the instrument/s to affect. If NULL, all instruments for the given record/event specification are affected
#' @param instance A vector specifying which instance of a repeating instrument to affect. If not specified, affects every instance.
#' @param arm A vector specifying which arm to affect.
#' @param action A character string for the action to perform on records. One of "lock", "unlock" or "status"
#' @param redcap_uri A character string of the REDCap server's API endpoint URL
#' @param token A character string of the REDCap API token
#'
#' @export
data_action <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, action, redcap_uri, token) {

  target <- make_url(redcap_uri, action)
  payloads <- data_payload(token, record, event, instrument, instance, arm)

  purrr::map(payloads,
             function(payload) request(target, payload))
}

#' @describeIn data_action Get the lock status of specified instruments
#' @export
data_status <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "status"))
}

#' @describeIn data_action Lock specified instruments
#' @export
lock_data <- function(record, event = NULL, instrument = NULL, instance = NULL,
                      arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "lock"))
}

#' @describeIn data_action Unlock specified instruments
#' @export
unlock_data <- function(record, event = NULL, instrument = NULL, instance = NULL,
                        arm = NULL, redcap_uri, token) {
  do.call(data_action, args = c(as.list(environment()),
                                action = "unlock"))
}

