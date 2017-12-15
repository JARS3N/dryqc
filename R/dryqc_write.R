 write<-function(U){
 require(RMySQL)
 require(adminKraken)
 my_db <- con_mysql()
  dbWriteTable(
    my_db,
    name = "dryqcxf24",
    value = as.data.frame(U),
    append = TRUE,
    overwrite = FALSE,
    row.names = FALSE
  )
  dbDisconnect(my_db)
  }
