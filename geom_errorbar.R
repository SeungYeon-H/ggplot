####using geom_errorbar to indicate max-min range 

sample<-read_xlsx("dates.xlsx",sheet="Sheet1")`

tibble(sample)

# A tibble: 13 × 6
#site                         max   min average type    year
#<chr>                      <dbl> <dbl>   <dbl> <chr>  <dbl>
#1 Oppenhiemer, 2017            946   946    946  first   2017
#2 Xu et al., 2013              940   952    946  first   2013
#3 Yatsuzuka et al., 2010       945   960    952. second  2010
# 4 Yatsuzuka et al., 2010       935   936    936. first   2010
#5 Yatsuzuka et al., 2010       859   884    872. third   2010
#6 Machida et al., 1990, 2007   916   936    926  first   1990
# 7 Yin et al., 2012             923   939    938. first   2012
# 8 Jwa et al., 2003             760   960    860  first   2003
# 9 Sun et al. 2015              916   990    953  first   2015
#10 Sun et al. 2015              940  1020    980  second  2015
#11 Horn and Scheminke, 1998     949   989    969  first   1998
#12 Nakamura et al., 2007        930   943    936. first   2007
#13 Nakamura et al., 2007        912   972    942  second  2007

sample$max<- as.numeric(max)
sample$min<- as.numeric(min)
sample$average<- as.numeric(average)
sample<-sample[order(sample$year),]

prac<-ggplot(sample, aes(x=reorder(site, year), 
                         y=average,ymin = min, ymax = max,color=type))+
  geom_hline(yintercept=c(926,946),linetype=1,size=2,color="orange",alpha=0.6)+ 
  geom_errorbar(size=1.2,width=0.3,alpha=.8)+
  geom_point(size=4)+
  coord_flip()+  
  scale_color_manual(values=c("#2F4E62","#6C8983","#61645B"))+ 
  theme_bw()+
  labs(y="Calendar year (AD)")+
  scale_y_continuous(breaks=seq(760,1020,20),
                     sec.axis = dup_axis())+  
  theme(axis.title.y=element_blank(),axis.title.x=element_text(face="bold",size=15),
        axis.text.x=element_text(face="bold",size=11),legend.title=element_blank(),
        legend.position="none",axis.text.y=element_text(face="bold",size=12)
       )

prac



## another version without average dots
prac<-ggplot(boru_long, aes(x=reorder(site, 순서), y=average, ymin = min, ymax = max,color=지역,shape=dataset))+
  geom_hline(yintercept=c(475,551),linetype=1,size=4,color="#E7F429",alpha=0.3)+
 scale_size_manual(values=c(1.8,1)) +
  geom_errorbar(aes(size = dataset), width=0.6,alpha=.8, position = position_dodge(width = 0.5))+
  coord_flip()+  
  scale_color_brewer(palette ="Spectral" ) + 
  theme_light()+
  labs(y="Calendar year (AD)")+
  scale_y_continuous(breaks=seq(175,950,50), sec.axis = dup_axis())+  
  theme(axis.title.y=element_blank(),
        axis.title.x=element_text(face="bold",size=14),
        axis.text.x=element_text(face="bold",size=12),
        legend.title=element_blank(),
        legend.position="bottom",
        legend.text=element_text(size=13,face="bold"),
        axis.text.y=element_text(face="bold",size=12)) +
  guides( color = guide_legend(title = "지역", order = 1, override.aes = list(size = 5, stroke = 4)), linetype = guide_legend(title = "Dataset", order = 2)
  )+
coord_flip(ylim = c(225, 925))
prac
