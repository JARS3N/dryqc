query_lots<-function(){
library(RMySQL)
mydb <- adminKraken::con_mysql()
query_lots <- dbSendQuery(mydb, "call get_unique_dry_qc_lots();")
dqc_lots <- dbFetch(query_lots)
dbClearResult(a2)
dbDisconnect(my_db)
dqc_lots
}
