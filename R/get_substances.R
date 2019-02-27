#' Extract substance information from free-text information
#'
#' This function creates indicator variables for substances that are listed in free-text. Indicator variables for a
#' list of drugs and other terms are created in the dataframe supplied to the function.
#' @param data The dataframe containing the free text information.
#' @param ... The free text fields you wish to scan for substances.
#' @keywords Drugs, substances, free-text scan
#' @export
#' @examples
#' get_substances(data=death_certs, lina, lineb, linec, lined, injurydescription, contributingcauses)

get_substances<-function(data, ...){
  fields<-dplyr::quos(...)
  suppressMessages(data %>%
                     dplyr::mutate(scan=paste(!!! fields, sep=" ")) %>%
                     tidytext::unnest_tokens(word, scan) %>%
                     dplyr::anti_join(tidytext::stop_words)  %>%
                     dplyr::filter(!stringr::str_detect(word, pattern = "[[:digit:]]"),
                                   !stringr::str_detect(word, pattern = "\\b(.)\\b"),
                                   word %in% kipRc::drugs$Term) %>%
                     dplyr::count(casenumber, word) %>%
                     dplyr::left_join(drugs, by=c("word"="Term")) %>%
                     dplyr::select(casenumber, Drug) %>%
                     unique() %>%
                     dplyr::mutate(indicator=1) %>%
                     tidyr::spread(key=Drug, value=indicator) %>%
                     purrr::map_df(replace_na, 0) %>%
                     dplyr::right_join(data))
}

