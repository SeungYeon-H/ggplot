str(CA)
tibble [18 × 33] (S3: tbl_df/tbl/data.frame)
 $ english                     : chr [1:18] "몽촌토성" "구의동 보루" "홍련봉 1보루" "홍련봉 2보루" ...
 $ Site                        : chr [1:18] "Mongchon" "Gouidong" "Hongryeonbong I" "Hongryeonbong II" ...
 $ region                      : chr [1:18] "Mongchon" "Han River" "Han River" "Han River" ...
 $ height                      : chr [1:18] "44.8" NA "250" "265" ...
 $ circumference               : chr [1:18] "2383" "46" "140" "218" ...
 $ volume                      : chr [1:18] "216000" "172" "950" "2704" ...
 $ feature                     : chr [1:18] "fortification" "fortress" "fortress" "fortress" ...
 $ Residence                   : chr [1:18] "8" "1" "0" "19" ...
 $ Defense/road                : chr [1:18] "9" "2" "0" "7" ...
 $ Manufacture                 : chr [1:18] "0" "0" "0" "1" ...
 $ storage                     : chr [1:18] "29" "0" "0" "2" ...
 $ roof tile                   : chr [1:18] "present" "absent" "present" NA ...
 $ drainage                    : chr [1:18] NA "1" NA "4" ...
 $ water tank                  : chr [1:18] "1" "1" NA "3" ...
 $ building(cornerstone)       : chr [1:18] "2" NA NA "18" ...
 $ building(pit)               : chr [1:18] NA NA NA "1" ...
 $ building(pithole)           : chr [1:18] "5" NA NA NA ...
 $ building(heating system)    : chr [1:18] "1" NA NA NA ...
 $ Unnamed 19                  : num [1:18] NA NA NA NA NA NA NA NA NA NA ...
 $ Unnamed 20                  : num [1:18] NA NA NA NA NA NA NA NA NA NA ...
 $ Unnamed 21                  : num [1:18] NA NA NA NA NA NA NA NA NA NA ...
 $ Unnamed 22                  : num [1:18] NA NA NA NA NA NA NA NA NA NA ...
 $ house                       : chr [1:18] NA NA NA NA ...
 $ pit                         : chr [1:18] "29" NA NA "2" ...
 $ ball-shaped pit             : chr [1:18] NA NA NA NA ...
 $ klin                        : chr [1:18] NA NA NA NA ...
 $ hearth                      : chr [1:18] NA "1" NA NA ...
 $ wooden storage              : chr [1:18] NA NA NA NA ...
 $ stone mound                 : chr [1:18] "8" NA NA NA ...
 $ road                        : chr [1:18] "present" NA NA NA ...
 $ mill/iron manufactoring area: chr [1:18] NA NA NA "1" ...
 $ etc                         : chr [1:18] NA NA NA "계단, 축대" ...
 $ stone alignment             : chr [1:18] NA NA NA NA ...

library(ggtern)
CA1<-CA%>%pivot_longer(cols="Residence":"storage",names_to="function",values_to="value")
CA$region<-factor(CA$region,levels=c("Imjin","Yangju","Han River","Mongchon","central")) 

CA1<-subset(CA1,select=c(2,3,30,31)) 
attach(CA1)
mode(CA1$value)<-"numeric"


###############################give order to the Site based onthe designated level of the region.
site_region_order <- CA1 %>%
  group_by(Site) %>%
  summarize(HighestRegion = min(as.numeric(region)), .groups = 'drop') %>%
  arrange(HighestRegion)
CA1$Site <- factor(CA1$Site, levels = rev(site_region_order$Site))
CA1$value[CA1$value==0]=NA



ggplot(CA1,aes(Site,value,fill=region))+
  geom_bar(width=.6,color="gray30",stat="identity",alpha=0.7)+
  theme_minimal()+
  geom_text(aes(label=value), 
            position=position_identity(), hjust=-0.3,size=3)+
  scale_y_continuous(expand = c(0,3))+
  coord_flip()+
  labs(y="Number of Inner Facilities")+
  facet_wrap(~`function`,scales="free_x",nrow=1) +  
  theme(strip.text = element_text(size=12,color = "white",face="bold"),
        strip.background = element_rect(fill = "gray0", color = "white"),
        axis.title.y = element_blank(),
        axis.text.x=element_text(size=11),
        legend.title=element_text(size=14,face="bold"),
        legend.text=element_text(size=11,face="bold"),
        legend.position="bottom")+  
  scale_fill_brewer(palette="Spectral")
