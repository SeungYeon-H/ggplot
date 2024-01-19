# load package and data
library(ggplot2)
library(ggExtra)
head(read)
 
# A tibble: 6 × 3
  institutions length width
  <chr>         <dbl> <dbl>
1 SNU            2.26  1.04
2 SNU            2.23  0.76
3 SNU            2.3   0.64
4 SNU            0.7   0.65
5 SNU            0.43  0.72
6 SNU            2.4   0.85

tail(read)
# A tibble: 6 × 3
  institutions length width
  <chr>         <dbl> <dbl>
1 SNU            3.08  0.66
2 SNU            2.56  0.62
3 SBM            2.34  0.64
4 SBM            2.22  0.76
5 SBM            2.6   0.93
6 SBM            2.23  1.12



# Scatterplot
graph<-ggplot(read,aes(length,width,color=institutions))+
  geom_point(size=4)+
  scale_color_manual(values=c("#DC2D3C","#132F2A"))+
  scale_y_continuous(breaks=seq(0,1.4,0.2),limits = c(0.5, 1.4),expand=c(0,0))+
  scale_x_continuous(breaks=seq(0,4,0.5),limits = c(0, 3.6),expand=c(NA,0))+
  theme_bw()+
  theme(axis.title.y=element_text(size=15,angle = 0, vjust = 0.5,face="bold"),axis.title.x =element_text(size=15,face="bold"),legend.title=element_blank(),legend.text=element_text(size=12,face="bold"),axis.text.x=element_text(size=12,face="bold"),axis.text.y=element_text(size=12,face="bold"),legend.position="top",legend.background = element_blank(),legend.box.background = element_rect(color = "gray"),panel.grid.major = element_line(size = 0.5,colour = "lightgray"),panel.grid.minor = element_line(size = 0.3,colour = "lightgray"),panel.background = element_rect(colour = "black",size = 1, linetype = "solid"))+guides(color = guide_legend(override.aes = list(size = 8)))

ggMarginal(graph,groupColour=T,groupFill=T,type="boxplot",alpha=0.7,size=3)

ggMarginal(graph,groupColour=T,groupFill=T,type="histogram",bins=40,alpha=0.7,size=3)

ggMarginal(graph,groupColour=T,groupFill=T,type="density",alpha=0.7,size=3)

ggMarginal(graph,groupColour=T,groupFill=T,type="violin",alpha=0.7,size=3)

ggMarginal(graph2,groupColour=T,groupFill=T,type="densigram",alpha=0.7)


#geom_rug(distribution described at the x axis and y axis)
graph2<-graph+geom_jitter(size=3)+geom_rug(position="jitter",sides="trbl")
graph2
