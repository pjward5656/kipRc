class_lu<-class_lu %>% 
  rename(drug=nottesteddrug,
         class=nottesteddrugclass)


save(class_lu, file="C:/R Packages/kipRc/kipRc/data/class_lu.Rda")
