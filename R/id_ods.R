#' Subset death certificate records to those with drug overdose death underlying cause of death fields
#'
#' This function subsets a dataframe of death certificates to those with a UCOD field indicating acute drug poisoning.
#' @param data The death certificate dataframe.
#' @param ucod_field The underlying cause of death field.
#' @keywords Drugs, underlying cause of death, death certificates
#' @export
#' @examples
#' id_ods(data=death_certs, field=UCOD)
#' @importFrom magrittr %>%
#'
id_ods<-function(data, ucod_field){
  condition_call<-substitute(ucod_field)
  new<-eval(condition_call, data)
  data %>%
    dplyr::filter(new %in% drug_ucod)
}
