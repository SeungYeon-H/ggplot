
c14dates<-read_xlsx("c14.xlsx",sheet="고구려")
c14dates<-subset(c14dates,select=c(1,4:17,20))
c14dates<-c14dates%>%filter(BP<1900)
c14dates<-c14dates%>%filter(!region=="NA")
c14dates<-c14dates%>%filter(!Feature=="unknown"&!Feature=="trench"&!Feature=="grid")
c14dates$BP<-as.numeric(c14dates$BP)
c14dates$er<-as.numeric(c14dates$er)
c14dates$number<-as.numeric(c14dates$number)
attach(c14dates)
c14dates<-c14dates[order(number),] 
str(c14dates)
tibble [208 × 16] (S3: tbl_df/tbl/data.frame)
 $ number   : num [1:208] 1 2 3 4 5 6 7 8 9 10 ...
 $ code     : chr [1:208] "SNU02-103" "SNU02-104" "SNU02-105" "SNU02-106" ...
 $ 시료재질 : chr [1:208] "목탄" "목탄" "목탄" "목탄" ...
 $ 측정기관 : chr [1:208] "서울대" "서울대" "서울대" "서울대" ...
 $ BP       : num [1:208] 1580 1530 1690 1450 1500 1690 1620 1610 1640 1550 ...
 $ er       : num [1:208] 60 40 40 30 40 40 40 40 60 40 ...
 $ 유적     : chr [1:208] "청원 남성골" "청원 남성골" "청원 남성골" "청원 남성골" ...
 $ Site     : chr [1:208] "Cheongwon Namseonggol" "Cheongwon Namseonggol" "Cheongwon Namseonggol" "Cheongwon Namseonggol" ...
 $ 유구     : chr [1:208] "1호가마" "2호 가마" "3호가마" "4호가마" ...
 $ 유구종류 : chr [1:208] "가마" "가마" "가마" "가마" ...
 $ Feature  : chr [1:208] "klin" "klin" "klin" "klin" ...
 $ 시대     : chr [1:208] "고구려" "고구려" "고구려" "고구려" ...
 $ 시기폭   : chr [1:208] "1599-1550" "1549-1500" "1699-1650" "1499-1450" ...
 $ period   : chr [1:208] "Goguryeo" "Goguryeo" "Goguryeo" "Goguryeo" ...
 $ r combine: chr [1:208] "1545±34" NA NA NA ...
 $ region   : chr [1:208] "central" "central" "central" "central" ...

#loop start 
sites <- unique(c14dates$region)
all_spd_data <- data.frame()   

for (site_type in sites) {
  subset_data <- filter(c14dates, region == site_type)
   
  kyusyu.cal <- BchronCalibrate(ages=subset_data$BP, ageSds=subset_data$er, calCurves = rep("intcal20", nrow(subset_data)))
   
  sampleSPD <- data.frame(year = seq(2050, 1000, -1), prob = 0, Site = site_type)
   
  for (cal_result in kyusyu.cal) {
    tmp <- data.frame(year = cal_result$ageGrid, prob = cal_result$densities)
    sampleSPD <- merge(sampleSPD, tmp, by = "year", all = TRUE, suffixes = c("", ".new"))
 
    prob_cols <- grep("prob", names(sampleSPD), value = TRUE)
    sampleSPD$prob <- rowSums(sampleSPD[prob_cols], na.rm = TRUE)
    sampleSPD[prob_cols[-1]] <- NULL  # Clean up additional prob columns
  }
  
  sampleSPD$year <- -sampleSPD$year + 2050
   
  all_spd_data <- rbind(all_spd_data, sampleSPD)
}

 
all_spd_data<-all_spd_data%>%filter(!Site=="NA")
all_spd_data$Site<-factor(all_spd_data$Site,levels=c("Imjin","Yangju","Han River","Mongchon","central")) 

number_of_sites <- length(unique(all_spd_data$Site))
pal.x <- brewer.pal(number_of_sites, "Spectral")

spd_plot <- ggplot(all_spd_data, aes(x = year, y = prob,fill=Site)) +
  geom_area(color="gray",size=0.5)+ 
  scale_fill_manual(values = pal.x) +  
  theme_clean() +
  theme(strip.text= element_text(face = "bold", size = 14),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(size = 12, face = "bold"),
        axis.text.y = element_text(size = 10),
        strip.background = element_rect(fill="#AAB6BD",color="white")) +
  scale_x_continuous(breaks = seq(50, 1000, 50),sec.axis = dup_axis()) +
  coord_cartesian(xlim = c(250, 1000)) +
  facet_grid(rows = vars(Site),scales="free")
