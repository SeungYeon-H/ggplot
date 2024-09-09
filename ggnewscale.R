#how to put the two differently applied color brewers (or color brewer and viridis applied to either color of the point or color of the gradients)
library(ggnewscale) #putting two color options

ggmap(world)+
  stat_density_2d(data=data,aes(x=lon,y=lat,fill=..level..),geom="polygon",contour_var = "ndensity",n=350,bins=10,alpha=0.8)+
  theme_classic()+
  scale_fill_distiller(palette="RdPu",direction=1)+
  #scale_fill_viridis_c(option="plasma",direction = -1)+
  #xlim(127.119,127.1252)+ylim(37.5178, 37.5214)+
  theme(axis.line=element_blank(),axis.title=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        legend.key = element_rect(fill = "white", color = NA),
        legend.title=element_text(size=11),
        legend.text=element_text(size=11,face="bold"),
        legend.position="right",
        legend.background = element_rect(fill = "white", color = "black")) +
  new_scale_fill() + ########renewing the scalebrewer
  geom_point(data=data,aes(x = lon, y =lat,fill = region),
             shape=21,size=3,stroke = 1,color="black",alpha=0.6)+
  scale_fill_brewer(palette = "Spectral")
