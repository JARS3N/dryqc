filter_last_run <- function(U){
  #ctg <- unique(U$Lot)
  dates <- unique(U$date)
  if(length(dates)==1){
    return(U)
  }else{
    datevalues<-sapply(dates,function(u){as.POSIXct(u,format="%m/%d/%y %H:%M:%S")})
    last<-dates[which(datevalues==max(datevalues))]
    U<-filter(U,date==last)
    return(U)
  }
}

