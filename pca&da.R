#Discriminant analysis
#LdA
library(MASS)
library(ggplot2)
library(grid)
library(readxl)
library(tidyverse)
library(dbplyr)
library(foreign)
library(ggthemes)

bt2<-names(read)[10:18]


read[bt2]<-lapply(read[bt2],as.numeric)
sapply(read,class)
mode(read$code)="character"
factor(read$code)
read.lda<-lda(code~.,data=read)

read.lda


readProjection <- cbind(scale(as.matrix(read[,-1]),scale=FALSE) %*% read.lda$scaling,read[,1,drop=FALSE])



p <- ggplot(data=readProjection,aes(x=LD1,y=LD2,color=as.factor(code)))+
geom_point(size=0.5)+
  geom_text(aes(label=row_num),size=5,fontface=2)+
theme_bw()+
theme(legend.title = element_blank(),legend.text=element_text(size=15))+
scale_colour_brewer(palette="Set1")

p



#PCA##############################################
library("FactoMineR")
library("factoextra")


CA<-data[,c(1,2:20)]
name=CA[,1]
frame=data.frame(CA,row.names=name$site_number)
frame=frame[,-1]
frame[is.na(frame)]<-0


res.pca<-PCA(frame,graph=F)
eig.val <- get_eigenvalue(res.pca)
eig.val
a<-fviz_pca_ind(res.pca, col.ind = "cos2", pointsize=4,gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),  repel = TRUE        )+
  theme(legend.title=element_blank(),legend.position="right",plot.title=element_blank(),axis.text=element_text(size=10))

a<-fviz_pca_biplot(res.pca, col.ind = "cos2", pointsize=4,gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),   col.var = "black",repel = TRUE        )+
  theme(legend.title=element_blank(),legend.position="right",plot.title=element_blank(),axis.text=element_text(size=10))

ggsave("mc_pca2.jpg",a, width=6,height=6,dpi=500)

##############Put PC1 at x axis and PC2 at y axis 

ind.p <- fviz_pca_ind(res.pca, geom = "point", col.ind = data$site_number)
library(ggpubr)
ggpubr::ggpar(ind.p, xlab = "PC1", ylab = "PC2")+geom_point(size=1)+
  geom_text(aes(label=data$site_number),size=5,fontface=2,color="#FC4E07")+
  theme_bw()+theme(legend.position = "none",axis.title.x =element_text(size=15,face="bold"),axis.title.y=element_text(size=15,face="bold"),legend.title=element_blank())+scale_colour_brewer(palette="Set1")
