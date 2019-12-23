#
# 팀프로젝트 - 제주청년창업
#
# 연도별 제주 청년 실업률
jper1 <- c("5.1%", "5.4%", "5.7%", "5.1%", "4.6%")
year1 <- c(2015:2019)
total <- data.frame(jper1, year1)
total$year1 <- as.factor(total$year1)
head(total)
library(ggplot2)


# 그래프 그리기
ggplot(total, aes(x = year1, y = jper1)) +
  geom_bar(stat = 'identity', width = 0.5, fill = ifelse(total$year1 %in% "2018", "orange", "grey")) +
  geom_text(aes(label = jper1),position = position_dodge(width = 1.8), vjust = -0.8, size = 8) +
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
