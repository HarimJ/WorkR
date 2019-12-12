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
str(data1)
area
a <- c("서울특별시",     "부산광역시", "대구광역시",  "인천광역시",  "광주광역시", "대전광역시", 
       "울산광역시", "세종특별자치시", "제주특별자치도")
h <- c(0.479 , 0.361 , 0.440  ,0.395 , 0.383 , 0.506 , -0.105, 0.152 , -0.372)
s <- c(0.510 , 0.343,  0.349 , 0.265 , 0.317 , 0.418,  -0.048, 0.186 , -0.387)
rdf <- data.frame(a,h,s)
rdf
str(rdf)


attach(rdf)

rdf$plus_minus <- ifelse(h >= 0, "PLUS", "MINUS")
rdf
detach(rdf)

#주거지역 지가변동률
ggplot(rdf, aes(x = a, y = h, fill=plus_minus)) +
  geom_bar(position = 'identity', stat = 'identity', colour = "white", width = 0.4) +
  scale_fill_manual(values = c("skyblue", "orange"), guide = FALSE) +
  ggtitle('주거지역 지가변동률') +
  xlab(NULL) +
  ylab('지가 변동률') +
    theme(plot.title = element_text(hjust = 0.5,
                                  size = 18),
        legend.position = 'bottom', 
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.minor.x = element_blank()
)

#상업지역 지가변동률
ggplot(rdf, aes(x = a, y = s, fill=plus_minus)) +
  geom_bar(position = 'identity', stat = 'identity', colour = "white", width = 0.4) +
  scale_fill_manual(values = c("steelblue", "pink"), guide = FALSE) +
  ggtitle('상업지역 지가변동률') +
  xlab(NULL) +
  ylab('지가 변동률') +
  theme(plot.title = element_text(hjust = 0.5,
                                  size = 18),
        legend.position = 'bottom', 
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        panel.grid.minor.x = element_blank()
  )

View(rdf)

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
           "제주관광대학창업보육센터","제주국제대학교창업보육센터","제주 벤처기업육성촉진지구")
#addr <- c("제주특별자치도 중앙로 217호","제주특별자치도 제주시 한라대학로 38 하이테크센터","제주특별자치도 제주시 첨단로 213-4","제주시 중앙로14길 21 제주대학교 창업보육센터",
#           "제주시 중앙로 217 제주벤처마루","제주시 제주대학로 102 공과대학", "제주시 애월읍 평화로 2715 창업보육센터",
#           "제주시 516로 2870 제주국제대학교 창업보육센터")

gc <- geocode(enc2utf8(names))
gc

df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen, maptype = "roadmap", zoom = 12, size = c(640, 640), markers = gc)
ggmap(map)
#gmap <- ggmap(map)
#gmap +
#  geom_text(data = df, aes(x = lon, y = lat, size = 1, label = df$name))

# 장소는 총 10개로 나오지만 그중 곁치는 곳이 있어서 총 7개 도출. 


#---------------------------------------------------------------------
setwd("d:/")
err <- read.csv("창업_당시_애로사항_12순위.csv", head = F)
str(err)
View(err)  
err <- err[-1,]  
err <- err[,-3]  
err <- err[-c(1,2,3,4),]
err <- err[-c(2,3),]
err <- err[,-1]
err <- err[,-2]
colnames(err) <- c("구분별",	"기술개발(%)",	"자금조달(%)",	"업종선정(%)",	
                   "사업 타당성 분석(%)",	"행정절차(%)",	"상품/서비스 개발(%)",	"사무실/작업공간 확보(%)",
                   "사업/시장정보 획득(%)", "경영교육(%)",	"인력확보(%)",	"홍보/마케팅(%)",	"기타(%)")  
err <- as.data.frame(err, stringsFactors = F)

aer <- err[c(1:5),];  View(aer)  
aer <- as.data.frame(aer) 
  
attach(aer)
rownames(aer) <- c("수도권", "충청권", "호남권", "영남권", "강원/제주")
aer <- aer[,-1]
View(aer)
str(aer)
aer$`사업 타당성 분석(%)`
aer$`행정절차(%)`
aer$`상품/서비스 개발(%)`
aer$`사무실/작업공간 확보(%)`
aer$`사업/시장정보 획득(%)`
aer$`경영교육(%)`
aer$`인력확보(%)`
aer$`홍보/마케팅(%)`
aer$`기타(%)`


aa <- list("기술개발" = c(6.2, 3.3, 10.2,6.6,5.2))
bb <- list("자금조달" = c(70.8,80.8,73.8,78.3,77))
cc <- list("업종선정" = c(3.5,5.1, 2.9,2.5,2.8))
cc <- list("사업타당성" = c(13.2, 16.2, 6.5 , 7.6 , 4.5 ))
dd <- list("행정절차" = c(5.3, 9.4, 8.6, 3.1, 4.4))
ee <- list("상품/서비스 개발" = c(1.4, 1.6, 1.1, 0.6, 0.4))
ff <- list("사무실/작업공간 확보" = c(25.2, 29.8, 45.4, 27.4, 19.1))
g <- list("사업/시장정보 획득" = c(5.3, 3.7, 2.3, 4.8, 5.5))
hh <- list("경영교육" = c(0.1, 0.5 ,0.2, 0.1, 0.0))
ii <- list("인력확보" = c(7.6, 2.3, 2.0, 4.7, 4.3))
jj <- list("홍보/마케팅" = c(25.1, 19.3, 29.8, 22.5, 21.9))
kk <- list("기타" = c(5.6 , 2.1, 1.9,  7.7,  10.5))

dda <- data.frame(aa,bb,cc,dd,ee,ff,g,hh,ii,jj,kk)
View(dda)
str(dda)
rownames(dda ) <- c("수도권", "충청권", "호남권", "영남권", "강원/제주")

cap <- dda['수도권',]


pie(66,33,10,66,52 )
#s <- read.csv("창업_희망_업종_20191212162242.csv")
#View(s)






