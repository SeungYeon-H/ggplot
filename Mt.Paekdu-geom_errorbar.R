#baekdu mix min average
setwd("C:/Users/Seung Yeon/Desktop/과제/대학원 박사/▷박사 1학기/ANTH 6035 Dendrochronology/발해")
bakdu<-read_xlsx("dates.xlsx",sheet="Sheet1")

attach(bakdu)

bakdu$max<- as.numeric(max)
bakdu$min<- as.numeric(min)
bakdu$average<- as.numeric(average)
bakdu<-bakdu[order(bakdu$year),]

prac<-ggplot(bakdu, aes(x=reorder(site, year), y=average,ymin = min, ymax = max,color=type))+
  geom_hline(yintercept=c(926,946),linetype=1,size=2,color="orange",alpha=0.6)+ 
  geom_errorbar(size=1.2,width=0.3,alpha=.8)+geom_point(size=4)+
  coord_flip()+  
  scale_color_manual(values=c("#2F4E62","#6C8983","#61645B"))+ 
  theme_bw()+
  labs(y="Calendar year (AD)")+
  scale_y_continuous(breaks=seq(760,1020,20),sec.axis = dup_axis())+  
  theme(axis.title.y=element_blank(),axis.title.x=element_text(face="bold",size=15),axis.text.x=element_text(face="bold",size=11),legend.title=element_blank(),legend.position="none",axis.text.y=element_text(face="bold",size=12))
prac
ggsave("dates.jpg",prac,width=10,height=5, dpi=500)
