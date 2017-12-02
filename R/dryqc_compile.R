compile<-function(dir){
fls<-list.files(pattern='xls',full.names=T,recursive =T) 
xl<-lapply(fls,readxl::read_excel,sheet='Data Base')
df<-do.call('rbind',xl)
df$fls<-fls
names(df)<-gsub(" ","_",names(df))
names(df)<-gsub("_[%]","",names(df))
df
}
