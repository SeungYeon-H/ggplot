#facet_wrap : sorted based on the row (ex. facet_wrap(~row.variable)) multiple sections in a row 
ggplot(aes(x = name, y = value, fill = pottery)) +
  geom_bar(position = position_fill(reverse = TRUE), stat = "identity", width = 0.6, size = 0.5) +
  theme_minimal() +
  facet_wrap(~Phase, scales = "free_x", nrow = 1) +
  scale_y_continuous(labels = scales::percent, breaks = seq(0, 1.1, 0.2)) +
  geom_text(
    data = label_data,  aes(label = total_value, y = total_value), 
    position = position_fill(vjust = 0.5, reverse = TRUE), 
    size = 2.5, color = "black"  ) +
  geom_text(aes(label = paste0("Feature n= ", count), y = 0), 
    size = 3, color = "black", vjust = 4, hjust = -1
  ) +
  theme(
    strip.text = element_text(size = 15, face = "bold", color = "black"),
    panel.spacing = unit(1, "mm"),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    axis.ticks.x = element_line(size = 0.5, color = "black"), 
    axis.ticks.y = element_line(size = 0.5, color = "black"), 
    legend.title = element_blank(),
    panel.border = element_rect(color = "gray30", size = 0.2,fill=NA),
    legend.text = element_text(size = 12),
    axis.text.x = element_text(size = 11),
    axis.text.y = element_text(size = 12, face = "bold"),
    legend.position = "bottom",
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "gray"),
    plot.margin = margin(t = 5, r = 10, b = 5, l = 5, unit = "mm")
  ) +
  scale_fill_manual(values = c( "#7B7A7C", "#D3D3D3", "#5A8080", "#C9CE6A", "#FDD370", "#F3C6FB", "#F37D71", "#948", "#6AB2ED"
  )) +
  coord_flip() +
  guides(fill = guide_legend(nrow = 2, byrow = FALSE, keyheight = unit(1, "cm")))

# facet_grid(row_variable ~ column_variable)

plot(data,aes(Site,value,fill=`function`))+
  geom_bar(width=.6,color="white",position = position_fill(reverse = TRUE),stat="identity",alpha=0.6)+
  theme_light()+
  geom_text(aes(label =value), 
            position = position_fill(vjust = 0.5,reverse=T), size = 4) +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()+
  labs(y="Percentage of features (%)")+
  facet_grid(type~phase,scales = "free", drop = TRUE) +  
  theme(strip.text = element_text(size=12,color = "white",face="bold"),
        strip.background.x = element_rect(fill = "gray0", color = "white"), 
        strip.background.y = element_rect(fill = "#19411C"),  # Row panels (type) gray
        axis.title.y = element_blank(),
        axis.title.x=element_text(size=13,face="bold"),
        axis.text.x=element_text(size=11,face="bold"),
        axis.text.y=element_text(size=13,face="bold"),
        legend.title=element_blank(),
        legend.text=element_text(size=11,face="bold"),
        legend.position="bottom")+  
  scale_fill_viridis(discrete=TRUE,option="H")

#https://www.zevross.com/blog/2019/04/02/easy-multi-panel-plots-in-r-using-facdt_wrap-and-facet_grid-from-ggplot2/
