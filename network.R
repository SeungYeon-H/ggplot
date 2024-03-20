library(tidyverse)
library(tidygraph)
library(ggraph)
library(ggplot2)
library(grid)
library(readxl)
library(tidyverse)
library(dbplyr)
library(foreign)
library(ggthemes)
library(ggrepel)
library(cowplot)

#below is the network analysis code adopted-/modified  from https://github.com/LiYingWang/kwl-burials
#ussing similarity (common items) 

str(data2)
#tibble [11 × 21] (S3: tbl_df/tbl/data.frame)
# $ site_number           : chr [1:11] "House1" "House2" "House4" "Storage1" ...
# $ Imported              : num [1:11] 1 22 16 6 0 0 4 11 56 0 ...
# $ small dish            : num [1:11] 0 0 2 0 0 2 1 0 2 1 ...
# $ dish                  : num [1:11] 0 5 0 0 0 0 2 0 3 0 ...
# $ lid                   : num [1:11] 1 12 1 14 1 0 5 1 11 3 ...
# $ boiling               : num [1:11] 6 15 4 11 8 4 14 8 3 4 ...
# $ Jar(midsize)          : num [1:11] 0 14 21 14 5 7 24 21 42 12 ...
# $ steamer               : num [1:11] 3 12 3 2 7 4 7 2 3 4 ...
# $ tripods               : num [1:11] 1 16 3 6 3 0 6 3 13 0 ...
# $ mounted dish          : num [1:11] 0 15 7 7 7 1 10 7 14 5 ...
# $ dish with high stand  : num [1:11] 0 7 9 4 0 1 7 5 9 1 ...
# $ jar with straight neck: num [1:11] 2 0 6 0 5 3 4 1 3 0 ...
# $ oval shaped pottery   : num [1:11] 0 0 0 0 0 0 0 0 0 0 ...
# $ jar with wide neck    : num [1:11] 0 4 11 8 6 0 7 4 8 3 ...
# $ Large jar             : num [1:11] 0 0 0 0 0 0 0 0 0 0 ...
# $ fishnet weight        : num [1:11] 0 2 0 0 0 0 1 0 1 0 ...
# $ double head jar       : num [1:11] 0 1 0 0 0 0 0 0 0 0 ...
# $ whetstone             : num [1:11] 0 1 0 0 0 0 0 0 6 0 ...
# $ spinning field        : num [1:11] 0 0 0 1 1 0 1 0 1 0 ...
# $ Hap                   : num [1:11] 0 0 0 1 0 0 0 0 0 0 ...
 #$ goguryeo              : chr [1:11] "present" "present" "present" "present" 

nodes <- data2 %>% 
  select(site_number) %>%  rowid_to_column("id")

mc_comb_data <- tibble(
  mc_1 = rep(nodes$site_number, times = length(nodes$site_number)),
  mc_2 = rep(nodes$site_number, each = length(nodes$site_number))
) %>% 
  filter(mc_1 != mc_2) # Remove self-combinations

edge_list_data <- data2 %>%
  select(site_number, 2:20) %>%
  pivot_longer(-site_number, names_to = "pottery", values_to = "count") %>%
  group_by(site_number) %>%
  nest()

calculate_common_counts <- function(site1, site2) {
  site1_data <- edge_list_data %>%
    filter(site_number == site1) %>%
    unnest(cols = c(data)) %>%
    select(-site_number, -pottery)
  
  site2_data <- edge_list_data %>%
    filter(site_number == site2) %>%
    unnest(cols = c(data)) %>%
    select(-site_number, -pottery)
  
  sum(!is.na(site1_data) & !is.na(site2_data), na.rm = TRUE)
}


mc_comb_data <- mc_comb_data %>%
  rowwise() %>%
  mutate(common_counts = calculate_common_counts(mc_1, mc_2)) %>%
  ungroup()


edges_for_network_data <- edges_for_network_data %>%
  mutate(
    from = pmin(from, to),
    to = pmax(from, to)
  ) %>%
  distinct(from, to, .keep_all = TRUE) %>%
  filter(from != to)  

mc_network_data <- network(edges_for_network_data, directed = FALSE, matrix.type = "edgelist")


#ERGM
model_data_1 <- mc_network_data ~
  edges + 
  density +
  triangle + 
  gwesp(0.4, fixed = TRUE)+ gwdegree(0.3, fixed = TRUE)

summary(model_data_1)

model_data_3 <- burial_network_pre ~ edges +
nodematch('goguryeo') +
  +gwesp(0.4, fixed = TRUE) + 
  gwdegree(0.5, fixed = TRUE) 
summary(model_pre_3)

set.vertex.attribute(mc_network_data, "goguryeo", data2$goguryeo)

edges_for_network_data <- edges_for_network_data %>%
  mutate(
    from = pmin(from, to),
    to = pmax(from, to)
  ) %>%
  distinct(from, to, .keep_all = TRUE)  #

edges_for_network_data <- edges_for_network_data  %>%
  filter(from != to)  

mc_network_data <- network(edges_for_network_data, directed = FALSE, matrix.type = "edgelist")

mc_network_data %v% "site_number" <- nodes$site_number

mc_network_data%>%  
  ggraph(., layout='mds') +
  geom_edge_link(
    aes(width = common_counts),
    color = "tomato3",alpha=0.3, end_cap = circle(.2, "cm")) +  
  geom_node_point(aes(size = degree(mc_network_data)), color = "darkblue") +  
  scale_edge_width(range = c(0.1, 3),name = "Connections")+
  geom_node_text(aes(label = site_number), repel = TRUE)+
  guides(size = FALSE) +
theme_graph()+
labs(shape="Connection")

#layout ='eigen',graphopt, gem,fr,mds,kk
