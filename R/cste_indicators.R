#' Add CSTE drug overdose indicators to ICD-10-CM coded hospitalization data
#'
#' This function adds indicator (0,1) variables to emergency department or inpatient hospitalization claims data.
#' For definitions, see: https://resources.cste.org/ICD-10-CM/Standardized%20Validation%20Datasets/Indicator-Specific%20Regular%20Expressions_2_5_20.pdf
#' @param data The dataframe containing claims data.
#' @param diag_codes A vector of quoted variable names representing the diagnosis codes in the data. Default is KIPRC's field names.
#' @keywords ICD-10-CM, CSTE, Overdose
#' @export
#' @examples
#' ip_data %>% cste_indicators()
#' @importFrom magrittr %>%
#'
cste_indicators<-function(data, diag_codes=c("DIAG1",  "DIAG2",  "DIAG3",  "DIAG4",  "DIAG5",  "DIAG6",  "DIAG7",  "DIAG8",
                                             "DIAG9",  "DIAG10", "DIAG11", "DIAG12", "DIAG13", "DIAG14", "DIAG15", "DIAG16",
                                             "DIAG17", "DIAG18", "DIAG19", "DIAG20", "DIAG21", "DIAG22", "DIAG23", "DIAG24",
                                             "DIAG25", "ECODE1", "ECODE2", "ECODE3","ECODE4", "ECODE5", "ECODE6")){
  #Regular expressions to search for
  od_regex<-"((T3[679]9|T414|T427|T4[3579]9)[1-4].|(?!(T3[679]9|T414|T427|T4[3579]9))(T3[6-9]|T4[0-9]|T50)..[1-4])(A|$|\b)"
  op_regex<-"((T40[0-4].|T406[09])[1-4])(A|$|\b)"
  hr_regex<-"(T401.[1-4])(A|$|\b)"
  nonhr_op_regex<-"((T40[0234].|T406[09])[1-4])(A|$|\b)"
  stim_regex<-"((T405|T436).[1-4])(A|$|\b)"
  cocaine_regex<-"(T405.[1-4])(A|$|\b)"
  noncoke_stim_regex<-"(T436.[1-4])(A|$|\b)"
  
  all_regex<-c(od_regex, op_regex, hr_regex, nonhr_op_regex, stim_regex, cocaine_regex, noncoke_stim_regex)
  
  new_diag_codes<-dplyr::enquo(diag_codes)
  
  temp<-data %>% 
    tidyr::unite(scan_field, tidyselect::all_of(!! new_diag_codes), sep=" ")
  
  var_names<-c("any_drug", "any_opioid", "heroin", "non_heroin_opioid", "stimulant", "cocaine", "stimulant_not_cocaine")
  
  drugs<-purrr::map2_dfc(all_regex, var_names, ~(temp %>% 
                                                   dplyr::mutate(!!.y:=ifelse(stringr::str_detect(scan_field, .x), 1, 0)) %>% 
                                                   dplyr::select(!!.y)))
  data %>% 
    dplyr::bind_cols(drugs)
    
}
