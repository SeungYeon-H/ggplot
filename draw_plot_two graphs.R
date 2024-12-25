#small bargraph in the bottom  
##using draw_plot!!!!!!!!!!!

str(all_spd_data)
#'data.frame':	139783 obs. of  5 variables:
# $ year  : num  1050 1050 1050 1050 1050 1050 1050 1050 1050 1050 ...
# $ prob  : num  1.42e-05 1.42e-05 1.42e-05 1.42e-05 1.42e-05 ...
# $ Site  : Factor w/ 12 levels "Horogoru","Mudeongri I",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ Region: Factor w/ 5 levels "Imjin","Yangju",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ region: chr  "Imjin" "Imjin" "Imjin" "Imjin" ...


spd_plot <- ggplot(all_spd_data, aes(x = year, y = prob, fill = Region)) +  geom_area(color = "gray40", size = 0.5) + 
  scale_fill_manual(values = colors) +
  facet_grid(rows = vars(Site), scales = "free") +
  theme_clean() +
  theme(strip.text.y =  element_text(size = 10,angle = 0,face="bold"),
        strip.background = element_rect(fill = "white", color = "gray30"),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(size = 11, face = "bold"),
        axis.text.y = element_text(size = 6)) +
  scale_x_continuous(breaks = seq(50, 1000, 50),sec.axis = dup_axis()) +
  coord_cartesian(xlim = c(300, 950)) +
  geom_vline(xintercept=c(475,676),linetype=1,size=1,color="gray30",alpha=0.3)

data1 <- c14dates %>% group_by(region) %>% 
  summarise(count = n()) %>% 
  mutate(perc = count/sum(count),x = c(rep("sample\nnumber",5)))

data1$region<-factor(data1$region,levels=c("Imjin","Yangju","Han River","Mongchon","central")) 

str(data1)
tibble [5 × 4] (S3: tbl_df/tbl/data.frame)
 $ region: Factor w/ 5 levels "Imjin","Yangju",..: 3 1 4 2 5
 $ count : int [1:5] 17 33 13 10 60
 $ perc  : num [1:5] 0.1278 0.2481 0.0977 0.0752 0.4511
 $ x     : chr [1:5] "sample\nnumber" "sample\nnumber" "sample\nnumber" "sample\nnumber" ...


data2<-data1%>%ggplot(aes(x=x, y = perc, fill=factor(region)))+
  geom_col(position="fill",width=.5,alpha=0.8)+
  scale_y_continuous(labels=scales::percent,breaks=seq(0,25,0.25))+
  scale_fill_brewer(palette="Spectral")+
  theme_light()+
  theme(axis.title.y=element_text(size=10,face="bold"),legend.title=element_blank(),axis.text.x=element_text(size=9,face="bold"),legend.position="none",axis.title.x=element_blank())+
  labs(y= "percentage(%)")+
  geom_text(aes(label = paste(count)),position = position_stack(vjust = 0.5), size = 3)

data2

ggdraw(spd_plot) + draw_plot(data2,0.84, 0.03, 0.15, 0.2)



