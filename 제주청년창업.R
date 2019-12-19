#
# 팀프로젝트 - 제주청년창업
#
# 연도별 제주 청년 실업률
jper <- c(5.1, 5.4, 5.7, 5.1)
year <- c(2015:2018)
total <- data.frame(jper, year)
total$year <- as.factor(total$year)
head(total)
library(ggplot2)

# 그래프 그리기
ggplot(total, aes(x = year, y = jper))+
  geom_segment(mapping = aes(x = year, xend = year, y = 0, yend = jper ), color = "grey", size = 1.5) +
  geom_point( color = "orange", size = 4) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("실업률")+
  ggtitle(" 제주 청년 실업률") +
  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  )# 제목으 좀더 두껍게 ????


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

install.packages("hrbrthemes")
library(dplyr)
library(hrbrthemes)

ggplot(mydata, aes(x = al, y = a))+
  geom_bar(stat = "identity", fill = ifelse(mydata$al %in% "2018", "orange", "grey"), width = 0.4) +   # 그래프 사이즈
  xlab("year") +
  ylab("사업체수")+
  ggtitle( " 제주 연도별 사업체 수" ) +
  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  )  # 이름 굵기


ggplot(mydata, aes(x = al, y = c))+
  geom_bar(stat = "identity", fill = ifelse(mydata$al %in% "2018", "orange", "grey"), width = 0.4) +   # 그래프 사이즈
  xlab("year") +
  ylab("종사자 수")+
  ggtitle( " 제주 연도별 종사자 수") +
  theme( plot.title = element_text(size =25, face = "bold", color = "orange")  )
