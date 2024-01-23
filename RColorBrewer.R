# If diverse colors are required to cover through RColorBrewer

library(RColorBrewer)

length(unique(bt$pottery)) 

# 13 comes out = number of the required colors 


nb.cols<-length(unique(bt$pottery))

newcolors<-colorRampPalette(brewer.pal(13,"Set1"))(nb.cols) 

#graph foramtion 
c<-bt %>% ggplot(aes(x=유적,y=value,fill=pottery))+
geom_bar(position = position_fill(reverse = TRUE),stat="identity",width=.5,size=0.5)+
theme_classic()+
scale_y_continuous(labels=scales::percent,breaks=seq(0,1.1,0.25))+
theme(legend.position="bottom",legend.background = element_blank(),legend.box.background = element_rect(colour = "gray"))+
scale_fill_manual(values=newcolors) +
coord_flip()+
guides(fill=guide_legend(nrow=2,byrow=TRUE))

# If I want to change the direction of the scale colour 
 scale_colour_brewer(palette="BuPu", direction=-1)
       
