str(CA1)
tibble [72 × 4] (S3: tbl_df/tbl/data.frame)
 $ Site    : Factor w/ 18 levels "Dogidong","Namsunggol",..: 4 4 4 4 7 7 7 7 8 8 ...
 $ region  : Factor w/ 5 levels "Imjin","Yangju",..: 4 4 4 4 3 3 3 3 3 3 ...
 $ function: chr [1:72] "Residence" "Defense/road" "Manufacture" "storage" ...
 $ value   : num [1:72] 8 9 NA 29 1 2 NA NA NA NA ...


#check the factor
levels(CA1)
ordered(df$x) checking the order of the factor 


#df2$x<-factor(df2$x,levels=c("carb","gear","am","vs","cyl")) #lowest level : carb 

#sorting one variable's level based on the other variable's level
site_region_order <- CA1 %>%
  group_by(Site) %>%
  summarize(HighestRegion = min(as.numeric(region)), .groups = 'drop') %>%
  arrange(HighestRegion)
CA1$Site <- factor(CA1$Site, levels = rev(site_region_order$Site))

#getting rid of rev-> level applied reversely

