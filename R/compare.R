#' Compare two dataframes for variables that match or don't match
#'
#' This function compares all of the variables in two similar dataframes to determine if the values in the data have changed.
#' This is helpful for identifying changes when a dataset is updated, similar to SAS PROC COMPARE.
#' @param new The "new" dataframe.
#' @param old The "old" dataframe to compare the new dataframe to.
#' @param ... The ID column(s) to be that indicate a unique record to compare between dataframes.
#' @keywords Compare
#' @export
#' @examples
#' compare(new=new_df, old_df, id)
#' @importFrom magrittr %>%
#'
compare<-function(new, old, ...){
  id_col<-dplyr::enquos(...)

  new_long<-new %>%
    tidyr::pivot_longer(cols=-c(!!! id_col),
                        names_to="var",
                        values_to="new_value")

  old_long<-old %>%
    tidyr::pivot_longer(cols=-c(!!! id_col),
                        names_to="var",
                        values_to="old_value")

  suppressMessages(new_long %>%
                     dplyr::full_join(old_long) %>%
                     dplyr::mutate(updated=ifelse(new_value!=old_value, 1, 0)) %>%
                     dplyr::arrange(!!! id_col))
}
