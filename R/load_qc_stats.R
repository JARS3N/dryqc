load_qc_stats<-function(x){
  require(readxl)
  require(dplyr)
  require(tidyr)
  DryQCINST<-readxl::read_excel(x,sheet='File List') %>%
    .[1,1] %>% grepl("DRY QC#2",.) %>% as.numeric()+1
  readxl::read_excel(x,sheet='Data') %>%
    filter(.,`Cartridge Lot` != "Average" ) %>%
    filter(., `Cartridge Lot` !=  "Std.Dev") %>%
    select(.,-Operator,-`Num Failure O2`,-`Num Failure pH`,-`Test Result`) %>%
    gather(.,key='sensewell',value='transmission',-`Cartridge Lot`,
           -`Cartridge Serial`, -`Cartridge Type`  , -`Test Date` ,
           -`O2 Threshold %`  , -`pH Threshold %`
    ) %>%
    mutate(.,well=gsub(' pH| O2',"",sensewell)) %>%
    mutate(.,analyte=gsub("[A-Z]{1}[0-9]{1} ","",sensewell)) %>%
    select(.,-sensewell) %>%
    tidyr::spread(.,key=analyte,value=transmission) %>%
    rename(.,Lot=`Cartridge Lot`,
           sn=`Cartridge Serial`,
           type =`Cartridge Type`,
           date = `Test Date`,
           O2Threshold =`O2 Threshold %`,
           pHThreshold =`pH Threshold %`
    ) %>%
    mutate(.,Lot=paste0(type,Lot)) %>%
    select(.,-type) %>%
    mutate(ctg=paste0(Lot,"_",sn)) %>%
    mutate(dryQC=DryQCINST) %>%
    split(.,.$ctg) %>%
    lapply(.,filter_last_run) %>%
    bind_rows() %>%
    select(.,-ctg)
}
