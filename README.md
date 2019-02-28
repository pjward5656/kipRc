# kipRc
R functions commonly used by KIPRC epidemiologists and statisticians

Under development

Currently:

  rate_ci()-function that calculates rate and 1-alpha confidence intervals
  
  get_substances()-function that scans free-text for known substances and creates indicator variables for these substances
  
  drugs-table containing a list of substance terms (names, mispellings, metabolites, etc) found in free text
  
  UCOD vector for drug overdose deaths

  id_ods()-function to filter a DC dataframe for drug overdose deaths

To be added:

  Age adjusted rates and confidence intervals
  
  T-code vectors for drug identification
  
  t_code()-function to create indicator variables for T codes associated with drug poisonings
  
  reg_summary()-function to summarize a dataframe by a region variable
  
  Percent change
