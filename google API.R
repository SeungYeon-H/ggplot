#google API - Making the terrain maps 

#Load the library
library("ggmap")
library(readxl)

library(tidyverse)
#Set your API Key
ggmap::register_google(key = "My API Key")
 
#example of Seoul, South Korea
#using terrain, getting rid of the road information, administration information
#also adding the scalebar and point of the compass. 

devtools::install_github('oswaldosantos/ggsn')
stylestr <- sprintf("&style=%s", c("element:labels|visibility:off", "feature:road.local|visibility:off","element:geometry|visibility:off")%>% paste(collapse = ""))  

map<-ggmap(get_googlemap(center=c(lon=127.1252,lat=37.5178),zoom=11,scale=2,maptype="terrain",style=stylestr, language="en-EN"))+
coord_equal()+ 
ggsn::north(location="topleft",scale = 0.8, x.min=126.9,x.max=127,y.min=37.6,y.max=37.68,symbol=10)+ 
ggsn::scalebar(location="bottomright",x.min = 127.15, x.max = 127.32,y.min = 37.38,  y.max = 37.65,dist = 5, model = 'WGS84', box.fill = c("white", "black"),dist_unit="km",transform="TRUE",st.size=3.8,height=0.025,st.dist=0.05)

map
