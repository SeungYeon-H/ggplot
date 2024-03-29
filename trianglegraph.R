library(ggtern)

data<-subset(data,select=c(1:6))
data<-data%>%filter(site=="Mongchon"|site=="Achasan")
str(data)
#'data.frame':	9 obs. of  6 variables:
# $ 토기: chr  "1988-89" "1" "2" "3" ...
# $ site: chr  "Mongchon" "Mongchon" "Achasan" "Achasan" ...
# $ 조리: num  123 63 23 38 17 24 40 17 62
# $ 배식: num  225 18 129 162 103 134 190 93 226
# $ 저장: num  161 82 198 170 180 235 252 145 149
# $ 의례: num  61 16 6 5 2 7 8 5 10

#but no way to change axis into the count, only described as the percentages 
# looking for a way to put the axis title at the middle of the each of the (x,y,z) axis.
attach(data)
data <- as.data.frame(data)
 
data %>%ggtern(aes(x = 조리,y = 배식,z = 의례,color = site)) +  
  geom_point(alpha=.6,size = 5) +
  labs(yarrow = "serving",zarrow = "ritual",xarrow = "cooking") +
  theme_arrowshort()+ #othertheme: theme_showarrows() theme_rgbw()
  scale_color_manual(values=c("blue", "brown"))+
  geom_text(data=subset(data, 의례 > 10),aes(x=조리+5, y=배식-5,label=토기),check_overlap=T, size=3) + 
  theme_clockwise()+ 
  theme(legend.justification=c(0,1), legend.position=c(0,1),text = element_text(size=16))
