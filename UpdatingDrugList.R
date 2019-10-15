#Updating KIPRC Drug list

library(readxl)
drugs<-read_xlsx("X:/Vol 1/common/Patrick/Text scan/comb4.xlsx") %>%
  rename(Term=Terms_found_on_death_certificate)

save(drugs, file="C:/R Packages/kipRc/kipRc/data/drugs.Rda")
