library(ggmap)
register_google(key = "AIzaSyDlnUhm-Llf-JUjfPpyNG6yEkeZDwoiAi4")
install.packages("dygraphs")
install.packages("highcharter")
library(tidyverse)
library(ggplot2)
library(dygraphs)
library(highcharter)




# 지가변동
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
# 교육장
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
#\\애로사항
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


cap <- dda[1,]
cap <- as.vector(cap)
cap <- table(cap)
library(RColorBrewer)
coul <- brewer.pal(5, "Set2") 
barplot(height = dda$자금조달, names = row.names(dda), col=coul )
barplot(height = dda$기술개발, col=rgb(0.2,0.4,0.6,0.6), )
barplot(height = dda$자금조달, names = dda)
barplot(height = cap, names = colnames(dda))



#________________________여기부터 ____________________________

a <- list("수도권" = c(6.2,	70.8,3.5,	13.2,	5.3,	1.4,	25.2,	5.3,	0.1,	7.6,	25.1,	5.6))
b <- list("충청권" = c(3.3,	80.8,	5.1,16.2,	9.4,	1.6	,29.8,	3.7,	0.5,	2.3,	19.3,	2.1))
c <- list("호남권" = c(10.2,	73.8,	2.9,6.5,	8.6,	1.1,	45.4,	2.3,	0.2,	2.0,	29.8,	1.9))
d <- list("영남권" = c(6.6,	78.3,	2.5,7.6,	3.1,	0.6,	27.4,	4.8,	0.1,	4.7,	22.5,	7.7 ))
e <- list("강원/제주" = c(5.2	,77.0	,2.8,4.5,	4.4	,0.4,	19.1,	5.5	,0.0,	4.3,	21.9,	10.5))

la <- data.frame(a,b,c,d,e)
la

rownames(la) <- c("기술개발", "자금조달", "업종선정", "사업타당", "행정", "상품개발", "공간확보","정보", "교육", "인력", "마케팅","기타")

View(la)
par(mfrow = c(2,3))
barplot(height = la$수도권, names = row.names(la),col = coul, main = "수도권")
barplot(height = la$충청권, names = row.names(la),col = coul, main = "충청권")
barplot(height = la$호남권, names = row.names(la),col = coul, main = "호남권")
barplot(height = la$영남권, names = row.names(la),col = coul, main = "영남권")
barplot(height = la$강원.제주, names = row.names(la),col = coul, main = "강원/제주권")



#_______________________________밑에자료______________________________________________________________________
w <- list("농업임업 및 어업" = c(58.0,	75.2,	2.8,	21.2,	14.0,	0.0,	22.3,	5.3,	0.0,	7.8,	20.1,3.1))
x <- list("	제조업" = c(6.7,	77.8,	2.6,	8.5,	3.9,	1.5,	18.5,	5.1,	0.2,	3.8,	20.0,	8.2))
y <- list("도매 및 소매업" = c(2.4,	67.6,	4.9	,8.8,	3.4,	2.4,	11.0,	6.6	,0.0,	6.1	,45.7,	6.2))
z <- list("출판영상방송통신 및 정보서비스업" = c(7.9,	74.7,	5.1,	8.9,	3.5,	0.8,	13.8,	8.4,	0.5,	12.1,	24.2,	4.6))
o <- list("금융 및 보험업" = c(0.6,	64.9,	18.5,	24.7,	8.2,	0.0,	19.9,	5.3	,0.0,	2.7,	25.6,	5.8))
p <- list("전문과학 및 기술 서비스업" = c(10.1,	62.6,	2.7,	13.0,	6.4,	1.1,	15.9,	11.4,	0.4,	4.3,	27.3,	9.3))
q <- list("사업시설관리 및 사업지원 서비스업" = c(4.0,	70.8,	13.1,	15.1,	10.9,	2.0,	12.0,	7.1	,0.2,	7.3,	25.1,	3.9))
r <- list("교육 서비스업" = c(5.4,	72.8,	1.8	,12.2,	7.7,	1.0	,37.4,	2.5	,0.0,	8.7,	31.7,	1.4))
ss <- list("예술 스포츠 및 여가관련 서비스업" = c(4.4,	76.7,	6.9	,11.5	,6.4,	0.7,	34.2,	2.7,	0.0	,6.5,	21.3,	2.8))
t<- list("협회 및 단체 수리 및 기타 개인 서비스업" = c(6.7,	78.4,	3.3,	10.8,	2.9	,0.4,	42.5,	3.0	,0.0,	2.8,	16.9,	6.8))

da <- data.frame(w,x,y,z,o,p,q,r,ss,t)
colnames(da) <- c("농업", "제조","도매","방송/정보","금융","과학","사업","교육", "예술", "협회")
View(da)

#rownames(da) <- c("기술개발",'자금조달','사업타당성','행정절차','상품.서비스.개발','사무실.작업공간.확보','사업.시장정보.획득','경영교육','인력확보','홍보.마케팅','기타')

barplot(height = da$농업, names = colnames(da), color =ncol )


#-----------------------------------------------------------------------------
job <- read.csv("창업_희망_업종_20191212162242.csv", head = F)

View(job)

job <- job[-c(8:19),]
job <- job[,-1]
colnames(job) <- c("2016","2018",'2019')
job <- job[-1,]
rownames(job) <- c("계","제조업/건설업", "도매/소도매", "숙박/음식점","부동산","기타")
job <- job[,-1]

job <- data.frame(job)
str(job)


iu <- c(22,36,31,28,27)

yu <- c(6,29,27,14,43)
su <- c(9,33,33,15,48)

jobk <- data.frame(iu,yu,su)
str(jobk)
View(jobk)
colnames(jobk) <- c("2016","2018",'2019')
rownames(jobk) <- c("제조업/건설업", "도매/소도매", "숙박/음식점","부동산","기타")

iu <- c(15, 25, 22, 19, 19)
yu <- c(5, 24, 23, 12, 36 )
su <- c(7, 24, 24, 10, 35)


library(ggplot2)
par(mfrow = c(1,3))

barplot(height = jobk$`2016`, names = row.names(jobk),col="#69b3a2",
        las=1, main = '2016년 창업희망')

barplot(height = jobk$`2018`, names = row.names(jobk),col="steelblue",
         las=1, main = '2018년 창업희망')

barplot(height = jobk$`2019`, names = row.names(jobk),col="grey",
         las=1, main = '2019년 창업희망')

par(mfrow = c(1,1))









