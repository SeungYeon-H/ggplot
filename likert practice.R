#likert chart practice
# But I cannot still figure out how to increase the font size
# the likert plot is based on the 'plot' or 'xyplot', can be contradictory to 'ggplot'.

library(HH)

 
read<-read_xlsx("file directory")
read<-subset(read,select=c(1,4:15))
read[is.na(read)]<-0
read2<-t(read)
read2<-data.frame(read2)
names(read2)<-c("85-2","85-1")
read3<-read2[c(2:12),]
read3$`85-2`<- as.numeric(read3$`85-2`)
read3$`85-1`<- as.numeric(read3$`85-1`)
head(read3)
# the data format has to be two-way table like this 

#                        85-2 85-1
병                         0    1
뚜껑                      19    2
자비용기                   0    3
직구단경호                 0    0
삼족토기(삼족기,삼족반)   15    1
호                         0    2

mycolor<- c("#A8C2C0", "#C9E9E6")

likert<-likertplot(read3,col=mycolor,main="pottery differentiation",text.size=4,ylab=NULL, 
                   positive.order=TRUE,scales=list(x=list(limits=c(-20,20),at=seq(-20,20,1))),
                   auto.key=list(space="right", columns=2,size=5),box.width=unit(0.7,"cm"),
                   strip.par=list(cex=2, lines=1),
                   strip.left.par=list(cex=2, lines=1),
                   par.strip.text=list(cex=10, lines=2) )
likert
 

