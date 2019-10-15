#Updating KIPRC Drug list

library(readxl)
data<-read_xlsx("X:/Vol 1/common/Patrick/Text scan/comb4.xlsx")

save(data, file="C:/R Packages/kipRc/kipRc/data/drugs.Rda")
