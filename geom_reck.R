bakdu<-read_xlsx("dates.xlsx",sheet="Sheet1")
attach(bakdu)
bakdu$max<- as.numeric(max)
bakdu$min<- as.numeric(min)
bakdu$average<- as.numeric(average)
bakdu<-bakdu%>%filter(type=="first")
bakdu[ , "id" ] <- 1:nrow(bakdu) #inserting new column named 'id', composed of the number of nrows of the dataframe
 str(bakdu)

#tibble [9 × 7] (S3: tbl_df/tbl/data.frame)
# $ site   : chr [1:9] "Oppenhiemer, 2017" "Sun et al. 2015" "Xu et al., 2013" "Yin et al., 2012" ...
# $ max    : num [1:9] 946 916 940 923 935 930 760 949 916
# $ min    : num [1:9] 946 990 952 939 936 943 960 989 936
# $ average: num [1:9] 946 953 946 938 936 ...
# $ type   : chr [1:9] "first" "first" "first" "first" ...
# $ year   : Factor w/ 9 levels "1990","1998",..: 9 8 7 6 5 4 3 2 1
# $ id     : int [1:9] 1 2 3 4 5 6 7 8 9
### making sure that id is 'int' and site is 'chr' + year is 'factor'

ggplot(bakdu, aes(x = id, fill = year)) +
  geom_rect(aes(xmin=id-0.25,xmax=id+0.25,ymin=max,ymax=min),alpha = 0.7)+  
theme_minimal()+  
coord_flip()+
  scale_y_continuous(breaks=seq(760,1020,20),sec.axis = dup_axis())+
scale_x_continuous(expand=c(0,0),
  limits = c(min(id)-0.5,max(id)+0.5),
  breaks = c(min(id)-0.5,unique(id),unique(id) + 0.5
  ),  labels = c("",as.character(unique(site)),  rep(c(""), length(unique(site)))
    )) +  
  theme(axis.title =element_blank(),axis.text = element_text(size = 12, face = "bold"))+
  scale_fill_viridis(discrete=TRUE,option="magma")
