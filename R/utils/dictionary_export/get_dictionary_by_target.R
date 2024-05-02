get_dictionary_by_target <- function(data, target) {
  data %>%
    pull(target) %>%
    attributes() %>%
    .$labels %>%
    as.list() %>%
    return()
}
