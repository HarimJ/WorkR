library(ggmap)
register_google(key = "AIzaSyDlnUhm-Llf-JUjfPpyNG6yEkeZDwoiAi4")
install.packages("dygraphs")
install.packages("highcharter")
library(tidyverse)
library(ggplot2)
library(dygraphs)
library(highcharter)

setwd("d:/")
data <- read.csv("시군구별_용도지역별_이용상황별_지가변동률_20191212171358.csv", head = F)
data <- data.frame(data)
data1 <- data[c(-1,-2,-3),]; data1
data1 <- data1[, -2]; data1
colnames(data1) <- c("area", "home", "store")

data1 <- as.data.frame(data1)

#rownames(data1) <- data1$area
#data <- data1[,-1]; data
View(data1)



#area_levels <- levels(data1$area)
#data1$area <- as.numeric(data1$area)
ggplot(data1, aes( x = area, y = home)) +
  geom_segment(aes( x= area, xend = area,  y = 0, yend = y), color = "grey") +
  geom_point(color = "orange", size = 4) +
  theme_light() +
  theme(panel.grid.major.x = element_blank(),
        panel.border = element_blank(),
        axis.ticks.x = element_blank()
  )


#ggplot(data = data) +
 # geom_bar(mapping = aes(x = home))

install.packages("sqldf")
library(sqldf)
area <- sqldf('select area, count(*) as Type_cnt 
              from data1
              group by area
              order by area')
area
sapply(area, class)


#1
ggplot(data1, aes(x = area, y = home)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  ggtitle('지가') +
  xlab(NULL) +
  ylab(NULL) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 12),
        legend.position = 'bottom', 
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        panel.grid.minor.x = element_blank()
  ) 

#2
ggplot(data1, aes(x = area, y = home)) +
  geom_bar(position = 'identity', stat = 'identity', colour = "white") +
  scale_fill_manual(values = c("blue", "red"), guide = FALSE)

#-----------------------------------------------------------
setwd("d:/")
edu <- read.csv("창업진흥원_벤처창업입지 위치정보 입지정보 좌표정보_2018.csv", head = F)
edu <- edu[,-1]
colnames(edu) <- c('시설구분',	'벤처기업육성촉진지구명',	'주소',	'좌표(X)',	'좌표(Y)')
edu <- edu[-1, ] 
View(edu)

library(dplyr)
edu <- as.data.frame(edu)

jedu <- edu[c(137,370,450,182,526,474,349,292,44,45),]
jedu <- as.data.frame(jedu);   jedu
View(jedu)

library(ggmap)
register_google(key = "AIzaSyDlnUhm-Llf-JUjfPpyNG6yEkeZDwoiAi4")

names <- c("제주벤처마루","제주한라대학교창업보육센터","제주첨단과학기술단지 인큐베이팅큐브","제주대학교 창업보육센터",
           "제주대학교","제주관광대학창업보육센터","제주국제대학교창업보육센터","제주 벤처기업육성촉진지구")
addr <- c("제주특별자치도 중앙로 217호","제주특별자치도 제주시 한라대학로 38 하이테크센터","제주특별자치도 제주시 첨단로 213-4","제주시 중앙로14길 21 제주대학교 창업보육센터",
           "제주시 중앙로 217 제주벤처마루","제주시 제주대학로 102 공과대학", "제주시 애월읍 평화로 2715 창업보육센터",
           "제주시 516로 2870 제주국제대학교 창업보육센터","제주특별자치도 이도1동, 이도2동")


gc <- geocode(enc2utf8(addr))


df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
df





