#####likert chart practice using library (HH)
##### But I cannot still figure out how to increase the font size
##### the likert plot is based on the 'plot' or 'xyplot', can be contradictory to 'ggplot'.

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
 
###### likert practice using ggplot() and geom_col. 
####### you can basically add the couple of the 'bars' 

read<-read_xlsx("file directory")
bt<-read%>%pivot_longer(cols="병":"완",names_to="pottery",values_to="value")
head(bt)
## A tibble: 6 × 3
  명칭       pottery                 value
  <chr>      <chr>                   <dbl>
1 85-2토광묘 병                          0
2 85-2토광묘 뚜껑                       19
3 85-2토광묘 자비용기                    0
4 85-2토광묘 직구단경호                  0
5 85-2토광묘 삼족토기(삼족기,삼족반)     15
6 85-2토광묘 호                          0


tail(bt)
## A tibble: 6 × 3
  명칭       pottery        value
  <chr>      <chr>          <dbl>
1 85-1토광묘 파배(대부파배)     0
2 85-1토광묘 광구호             1
3 85-1토광묘 소호,대부소호      0
4 85-1토광묘 고배               1
5 85-1토광묘 시루(파수)         1
6 85-1토광묘 완                 0

bt$value<- as.numeric(bt$value)
bt[is.na(bt)]<-0

ggplot()+
  geom_col(data=bt%>%filter(명칭=="85-1토광묘"),aes(pottery,value,fill=명칭),color="white")+
  geom_col(data=bt%>%filter(명칭=="85-2토광묘"),aes(pottery,value*(-1),fill=명칭),color="white")+
  coord_flip()+
  scale_y_continuous(limits = c(-20, 20),breaks = seq(-20,20,2),labels = abs(seq(-20, 20, 2)))+
scale_fill_brewer(type = "div", palette = "Accent")+
  theme_fivethirtyeight()+  
  theme(axis.title.x =element_blank(),axis.text.x=element_text(size=15,face="bold"),axis.title.y=element_text(size=16,face="bold"),axis.text.y=element_text(size=16),legend.title=element_blank(),legend.position="bottom",legend.text=element_text(size=15,face="bold"))+
  geom_hline(yintercept=c(0),linetype=1,size=1,color="black",alpha=0.5)


