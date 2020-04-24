#' Add indicators to ICD-10-CM coded hospitalization data
#'
#' This function adds indicator (0,1) variables to emergency department or inpatient hospitalization claims data.
#' Similar to cste_indicators, but in this case the user defines the ICD-10-CM codes to search.
#' @param data The dataframe containing claims data.
#' @param icd_codes A vector of quoted ICD-10 codes to search. These can be individual codes or regular expressions.
#' @param new_var_names A vector of quoted strings representing the names of the new variables to be created.
#' @param diag_codes A vector of quoted variable names representing the diagnosis codes in the data. Default is KIPRC's field names.
#' @keywords ICD-10-CM
#' @export
#' @examples
#' icd_indicators(ipdata, icd_codes=c("(T401.[1-4])(A|$|\b)", "(T405.[1-4])(A|$|\b)"), new_var_names=c("heroin", "cocaine"))
#' @importFrom magrittr %>%
#'
icd_indicators<-function(data, icd_codes, new_var_names, 
                         diag_codes=c("DIAG1",  "DIAG2",  "DIAG3",  "DIAG4",  "DIAG5",  "DIAG6",  "DIAG7",  "DIAG8",
                                      "DIAG9",  "DIAG10", "DIAG11", "DIAG12", "DIAG13", "DIAG14", "DIAG15", "DIAG16",
                                      "DIAG17", "DIAG18", "DIAG19", "DIAG20", "DIAG21", "DIAG22", "DIAG23", "DIAG24",
                                      "DIAG25", "ECODE1", "ECODE2", "ECODE3","ECODE4", "ECODE5", "ECODE6")){
  
  new_diag_codes<-dplyr::enquo(diag_codes)
  
  temp<-data %>% 
    tidyr::unite(scan_field, tidyselect::all_of(!! new_diag_codes), sep=" ")
  
  
  indicators<-purrr:map2_dfc(icd_codes, new_var_names, ~(temp %>%
                                                           dplyr::mutate(!!.y:=ifelse(stringr::str_detect(scan_field, .x), 1, 0)) %>%
                                                           dplyr::select(!!.y)))
  data %>% 
    dplyr::bind_cols(indicators)
}
