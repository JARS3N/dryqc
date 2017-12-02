convert_compiled<-function(x){
df<-read.csv(x,stringsAsFactors = F)
df[c( "Operator", "Num_Failure_O2", "Num_Failure_pH","Test_Result")]<-NULL
old_names<-c(
  "Cartridge_Lot",
  "Cartridge_Serial",
  "Cartridge_Type",
  "Test_Date",
  "O2_Threshold",
  "pH_Threshold"
)
positions<-sapply(old_names,function(u){which(names(df)==u)})
new_names<-c("Lot","sn","type","date","O2Threshold","pHThreshold")
names(df)[positions]<-new_names
df$dryQC<-as.numeric(grepl("DRY QC#2",df$fls))+1  
df$fls<-NULL
split1<-split(df,seq_along(df$sn))
fin<-do.call('rbind',lapply(split1,make_long))
rownames(fin)<-NULL
fin$sn<-sprintf("%05d", fin$sn)
fin$Lot<-paste0("Q",fin$Lot)
fin[order(fin$sn,fin$well),]
}
