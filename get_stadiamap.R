#get_stamenmap not working anymore...
#way to get API in stadia map 
#Getting API KEY at : https://client.stadiamaps.com/
remove.packages("ggmap")
install.packages("devtools")
devtools::install_github("stadiamaps/ggmap")
library("ggmap")
register_stadiamaps(key = "API KEY NUMBER")

#now working!
world <- get_stadiamap(bbox = c(left = 126.2, bottom = 36.3, right = 128.3, top = 38.1), maptype = "stamen_terrain")

#maptypes
#maptype = "stamen_terrain")  
#maptype = "stamen_terrain_background")
#maptype = "stamen_terrain_labels")    
#maptype = "stamen_terrain_lines")     
#maptype = "stamen_toner")              
#maptype = "stamen_toner_background")  
#maptype = "stamen_toner_labels")       
#maptype = "stamen_toner_lines")        
# maptype = "stamen_toner_lite")         
#maptype = "stamen_watercolor")        
