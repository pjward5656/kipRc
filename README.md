# kipRc
R functions commonly used by KIPRC epidemiologists and statisticians

Under development

Currently:

  `rate_ci()`-function that calculates rate and 1-alpha confidence intervals
  
  `get_substances()`-function that scans free-text for known substances and creates indicator variables for these substances
  
  `compare()`-function to compare values in two dataframes, similar to SAS PROC COMPARE

  `id_ods()`-function to filter a DC dataframe for drug overdose deaths
  
  `drugs`-table containing a list of substance terms (names, mispellings, metabolites, etc) found in free text
  
  `class_lu`-table containing a substance to drug class lookup
  
  `metabs`-table containing a list of drugs with unique metabolites
  
  `pharm_lu`-table that converts KIPRC REDCap drug class numbers to the class
  
  `subs_lu`-table that converts KIPRC REDCap substance numbers to the substance
  
  `UCOD` vector for drug overdose deaths
  
  `cste_indicators` Function that addes CSTE overdose indicators to hospital claims data
  
  `icd_indicators` Function that adds indicator variables for any ICD-10-CM code a user wishes to identify to hospital claims data.

To be added:

  Age adjusted rates and confidence intervals
  
  T-code vectors for drug identification
  
  `t_code()`-function to create indicator variables for T codes associated with drug poisonings
  
  `reg_summary()`-function to summarize a dataframe by a region variable
  
  `Percent change`

Example: Take raw DCs, identify drug overdose deaths and pull substances from free text:

```
library(tidyverse)

df<-id_ods(deaths, C_UNDER_C) %>% 
  get_substances(data=., C_UNDER_MC, C_SUPP_MC1, C_SUPP_MC2, C_SUPP_MC3, C_SIGCC_MC, I_DESCRIPT)
  
```

