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
