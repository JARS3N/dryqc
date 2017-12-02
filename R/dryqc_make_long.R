make_long<-function(u){
  constants<-c("Lot","sn","type","date","O2Threshold","pHThreshold",'dryQC')
  positions<- sapply(constants,function(j){which(names(u)==j)})
  a<-u[1,constants]
  b<-u[-1*positions]
  z<-Map(function(x,y){
    splat<-unlist(strsplit(x,split="_"))
   xf<- data.frame( analyte = y,well = splat[1])
   names(xf)<-c(splat[2],'well')
   xf
  },
  x=names(b),
  y=b[1,]
  )
  ans<-sapply(z,function(u){any(grepl("O2",names(u)))}) 
  O2<-do.call('rbind',z[ans])
  pH<-do.call('rbind',z[!ans])
  merged<-merge(O2,pH,by='well')
  index<-c('Lot','sn','date','O2Threshold','pHThreshold','dryQC')
  merged[index]<-a[index]
  db_order<-c("Lot","sn","date","O2Threshold","pHThreshold","well","O2","pH","dryQC")
  merged[,db_order]
}
