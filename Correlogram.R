#visualization of the coorelation matrix = Correlogram
install.packages("ggcorrplot")
library("ggcorrplot")

#practice
head(mtcars)
M<-cor(mtcars) #showing all the correlation coefficient
head(round(M,1)) #rounding off to the nearest integer

ggcorrplot(M,hc.order=T, type="lower",
           outline.col = "white", insig = "blank",lab=TRUE,
           ggtheme = ggplot2::theme_minimal,
           colors = c("#6D9EC1", "white", "#E46726"))
#http://www.sthda.com/english/wiki/ggcorrplot-visualization-of-a-correlation-matrix-using-ggplot2
