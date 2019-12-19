#
# 팀프로젝트 - 제주청년창업
#
# 연도별 제주 청년 실업률
jper <- c("5.1%", "5.4%", "5.7%", "5.1%")
year <- c(2015:2018)
total <- data.frame(jper, year)
total$year <- as.factor(total$year)
head(total)
library(ggplot2)

# 그래프 그리기 (롤리팝)
#ggplot(total, aes(x = year, y = jper))+
#  geom_segment(mapping = aes(x = year, xend = year, y = 0, yend = jper ), color = "orange", size = 1.5 ) +
#  geom_point( color = "orange", size = 4) +
#  geom_text(aes(label = jper),position = position_dodge(width = 1.8), vjust = -0.8)+
#  theme_light() +
#  theme(
#    panel.grid.major.x = element_blank(),
#    panel.border = element_blank(),
#    axis.ticks.x = element_blank()
#  ) +
#  xlab(NULL) +
#  ylab("실업률")+
#  ggtitle(" 제주 청년 실업률") +
#  theme_classic() +
#  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  ) 


  
# 실업률 bar 그래프
ggplot(total, aes(x = year, y = jper)) +
  geom_bar(stat = 'identity', width = 0.5, fill = ifelse(total$year %in% "2018", "orange", "grey")) +
 # geom_segment(mapping = aes(x = '2017', xend = '2018', y = "5.7%", yend = "5.4%" ), arrow = arrow(type = 'open'), color = "red" ,size = 2 ) +
  geom_text(aes(label = jper),position = position_dodge(width = 1.8), vjust = -0.8, size = 8) +
    ggtitle("제주 청년 실업률" ) +
    theme_void()+
    theme( plot.title = element_text(size =25, face = "bold", color = "orange")  )
  
  
  
# 종사자, 사업체 수
setwd("d:/")
mydata <- read.csv("종사,사업체.csv", as.is = TRUE)
View(mydata)

mydata <- mydata[,-1]
colnames(mydata) <- c( "2015","2016","2017","2018")
rownames(mydata) <- c("a","b","c","d")                      # c("사업체수", "증감률a","종사자수","증감률b")
head(mydata)

mydata <- t(mydata)


al <- factor(c(2015:2018))
mydata <- data.frame(mydata, al)
mydata$b <- c("2.3%", "4.8%", "3.9%", "4.6%")
mydata$d <- c("6.1%", "3.3%", "1.8%", "4.9%")

install.packages("hrbrthemes")
library(dplyr)
library(hrbrthemes)

# 사업체수
ggplot(mydata, aes(x = al, y = a))+
  geom_bar(stat = "identity", fill = ifelse(mydata$al %in% "2018", "orange", "grey"), width = 0.5) +
    geom_text(aes(label =  b),position = position_dodge(width = 1.8), vjust = -0.8, size = 8) +
  xlab("year") +
  ylab("사업체수")+
  ggtitle( " 제주 연도별 사업체 수" ) +
  theme_void() +
  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  )  # 이름 굵기
str(mydata)

#종업자 수
ggplot(mydata, aes(x = al, y = c))+
  geom_bar(stat = "identity", fill = ifelse(mydata$al %in% "2018", "orange", "grey"), width = 0.5) +
  geom_text(aes(label =  d),position = position_dodge(width = 1.8), vjust = -0.3, size = 7.5) +
  xlab(NULL) +
  ylab("종사자 수")+
  ggtitle( " 제주 연도별 종사자 수") +
  theme_classic() +
  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  ) 
  













