#https://r-charts.com/flow/sankey-diagram-ggplot2/
install.packages("remotes")
remotes::install_github("davidsjoberg/ggsankey")
library(ggsankey)
library(viridis)
 str(df)
#tibble [22 × 5] (S3: tbl_df/tbl/data.frame)
# $ index         : chr [1:22] "Anderson et al. 2011" "Anderson et al. 2011" "Anderson et al. 2011" "Anderson et al. 2011" ...
# $ observation   : chr [1:22] "heterogenous pottery attributes" "heterogenous pottery attributes" "heterogenous pottery attributes" "heterogenous pottery attributes" ...
# $ theory        : chr [1:22] "mobility strategy" "mobility strategy" "mobility strategy" "mobility strategy" ...
# $ pottery data  : chr [1:22] "compositional analysis" "compositional analysis" "pottery style" "pottery style" ...
# $ interpretation: chr [1:22] "exchange network" "territoriality" "exchange network" "territoriality" ...

df<-df[,2:5]
df <- df %>%
  make_long("observation","theory","pottery data","interpretation")

ggplot(df, aes(x = x, 
                next_x = next_x, 
                node = node, 
                next_node = next_node,
                fill = factor(node),label = node)) +
  geom_sankey(flow.alpha = 0.4
              , node.color = "black"
              ,show.legend = FALSE)+
  geom_sankey_text(size = 3.5,color = "gray5", hjust = 0,vjust=1,  position = position_nudge(x = 0.06)) +
  scale_fill_viridis_d(option = "inferno") +theme_void()+
  theme(legend.position = "none")+  labs(x = NULL) +
  theme_sankey(base_size = 20)
 
