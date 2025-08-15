
ggplot(CA1,aes(유적,value,fill=지역))+
  geom_bar(width=.6,color="gray30",stat="identity",alpha=0.7)+
  theme_minimal()+
  geom_text(aes(label=value), 
            position=position_identity(), hjust=-0.3,size=3.5)+
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))+ #forming interval between sorted bar graphs (10%)
  coord_flip()+
  labs(y="count")+
  facet_wrap(~`function`,scales="free_x",nrow=1) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.5, linetype = "solid") +  #puting solid line on x=0 line at each sorted bar graphs and it is h_line because we are using coord_flip()
  theme(strip.text = element_text(size=14,color = "white",face="bold"),
        strip.background = element_rect(fill = "gray0", color = "white"),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=14,face="bold"),
        axis.text.x=element_text(size=12),
        axis.text.y=element_text(size=12,face="bold"),
        legend.title=element_text(size=14,face="bold"),
        legend.text=element_text(size=11,face="bold"),
        legend.position="bottom")+  
  scale_fill_brewer(palette="Spectral")
