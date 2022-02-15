#### This script is a proof of concept that a function could return a peer list, given certain parameters.

df <- as.data.frame(read.csv("district_data.csv"))

keeps <- c("IssuerName","District.Number","DPETALLC","TEA.District.Type","DZCAMPUS","DPSTKIDR","DPSTTOFP")

df <- df[keeps]
df$TEA.District.Type <- as.character(df$TEA.District.Type)

### This function takes the name of a school district as input and returns peers based on similar TEA classification
### and other demographics (in this case, student-teacher ratios)

findpeer<-function(x,NameChoice){
  focus <- (x[which(x$IssuerName==NameChoice),])
  type <- focus$TEA.District.Type
  teacher_ratio <- focus$DPSTKIDR
  min.ratio <- teacher_ratio - teacher_ratio*.1
  max.ratio <- teacher_ratio + teacher_ratio*.1
  teacher_pct <- focus$DPSTTOFP
  min.teacher.pct <- teacher_pct - teacher_pct*.1
  max.teacher.pct <- teacher_pct + teacher_pct*.1
  campus <- focus$DZCAMPUS
  min.campus <- campus - campus*.25
  max.campus <- campus + campus*.25
  filtered <- df %>%
    filter(DPSTKIDR < max.ratio, DPSTKIDR > min.ratio, DPSTTOFP< max.teacher.pct, DPSTTOFP > min.teacher.pct,
           DZCAMPUS < max.campus, DZCAMPUS > min.campus, TEA.District.Type == type)
}


y <- findpeer(df, 'DUNCANVILLE ISD')
write(y, "peergroup.csv")
