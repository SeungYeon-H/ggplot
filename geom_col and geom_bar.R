####Difference between geom_bar and geom_col 

##using the geom_bar() if the exact value of the character is not indicated (and let Rstudio to count them)

head(diamonds)

# A tibble: 6 × 10
  carat cut       color clarity depth table price     x     y     z
  <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
1  0.23 Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
2  0.21 Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
3  0.23 Good      E     VS1      56.9    65   327  4.05  4.07  2.31
4  0.29 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
5  0.31 Good      J     SI2      63.3    58   335  4.34  4.35  2.75
6  0.24 Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48


ggplot(diamonds,aes(x=color))+geom_bar()+theme_bw()


##using the geom_col if you already counted the contents of the specific variable that you want to express in x axis

sample<-USArrests %>%as.data.frame() %>%tibble::rownames_to_column('region') 

head(sample)
#      region Murder Assault UrbanPop Rape
1    Alabama   13.2     236       58 21.2
2     Alaska   10.0     263       48 44.5
3    Arizona    8.1     294       80 31.0
4   Arkansas    8.8     190       50 19.5
5 California    9.0     276       91 40.6
6   Colorado    7.9     204       78 38.7


sample<-sample%>%filter(Murder>12)
 ggplot(sample,aes(x=(region),y=Assault))+geom_bar(stat='identity')+theme_bw()


## then how to convert counts to the observation? (adopted from the https://stackoverflow.com/questions/66568926/converting-counts-into-individual-observations)

sample2<- sample %>%
  slice(rep(1:nrow(sample), times = sample$Assault)) %>%
  select(-Assault)

head(sample2)
#   region Murder UrbanPop Rape
1 Alabama   13.2       58 21.2
2 Alabama   13.2       58 21.2
3 Alabama   13.2       58 21.2
4 Alabama   13.2       58 21.2
5 Alabama   13.2       58 21.2
6 Alabama   13.2       58 21.2

ggplot(sample2,aes(x=region))+geom_bar()+theme_bw()
## This draw the exact same result with the former geom_bar(stat='identity'). 


