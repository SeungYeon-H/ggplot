#how to put the compass and scale on the ggmap 
library(ggspatial) #for the compass and scale 
library("ggmap")
register_stadiamaps(key = " ")
world <- get_stadiamap(bbox = c(left = 126.2, bottom = 35.9, right = 128.4, top = 38.1), maptype="stamen_terrain_background")
ggmap(world)+  
  geom_point(data=data,aes(x = lat, y =lon,fill = region),shape=21,size=3,stroke = 1,color="black")+  
  theme_classic()+
  scale_fill_brewer(palette = "Spectral") +
  theme(axis.line=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),axis.text.y=element_blank(),
        legend.position="right",
        legend.background = element_rect(fill = "white", color = "black"),
        legend.text=element_text(size=11,face="bold"),
        title=element_text(size=11))+
  ggtitle("Location of the sites")+  
  #scale_x_continuous(position="top")+
  guides(colour = guide_legend(label.vjust = ,label.position = "right"),shape="none") +
  annotation_north_arrow(location="tl", pad_x = unit(0.5, "in"),style = north_arrow_fancy_orienteering)+ 
  annotate("text", x=127.08, y=37.58, label="capital area",size=3.5,fontface = "bold")+ 
  annotation_scale(location = "br", width_hint = 0.3) + 
  coord_sf(crs = 4326) #br=bottom right, width_hint=proportion of the width in the map
