# 5조
# 작성일 : 2019. 12. 13
# 제출일 : 2019. 12. 13

#강승웅/ 20191223
library(wordcloud)
library(wordcloud2)
library(KoNLP)
library(RColorBrewer)

library(dplyr)
library(ggplot2)

setwd('D:/workR')
text4 <- readLines('text.txt', encoding = 'UTF-8')
text4

noun4 <- sapply(text4, extractNoun, USE.NAMES = F)  
noun4

noun4 <- unlist(noun4)            #list <- vector로 변환

noun4 <- noun4[nchar(noun4)>=2]   

coun4<- table(noun4)

sort.noun4 <- sort(coun4, decreasing = T)[1:10]
sort.noun4
sort.noun4 <- sort.noun1[-3]            #3번째가 공백임.

wordcloud2(coun4,
           color = 'random-light',size = 1)


#외국인 투자현황(중국자본 유입)
setwd("c:/workR/homeworkData")
invest<- read.xlsx(file="산업통상자원부_지자체별외국인투자현황.xlsx",sheetIndex=1,encoding="UTF-8", header=T)
invest
str(invest)
View(invest)
in1 <- invest[50:56,]                #2011년 전의 데이터 제거, 2018년 데이터 제거(반기 수치임)
in1
View(in1)
in1_j <- in1$제주_신고금액+in1$제주_도착금액      #각 년도에 금액을 모두 더해서 사용함
in1_j

in1_b <- in1$부산_신고금액+in1$부산_도착금액
in1_b

in1_d <- in1$대구_신고금액+in1$대구_도착금액
in1_d

in1_I <- in1$인천_신고금액+in1$인천_도착금액
in1_I

plot(year, in1_j, main='지자체별외국인투자현황(단위:백만달러)',
     type='b', lty=1, lwd=2,
     xlab='연도', ylab="금액",col="red")  #제주
lines(year, in1_b, type = "b", lty=1, lwd=2, col="black") #부산
lines(year, in1_d, type = "b", lty=1, lwd=2, col="navy")  #대구
lines(year, in1_I, type = "b", lty=1, lwd=2, col="violet") #인천


#-----------------------------------------------------------------------------------------------

setwd('D:/5_project/가설1')
trans <- read.csv('transfer.csv')
trans
population <- read.csv('population.csv')
population

str(population)

#박주은/ 20191223
#제주 전체인구와 유입인구의 가중치
per<- trans$count/population$population
per
#필요시 곱
per1<- per*100
year <- 2015:2018
year
weight <- data.frame(year,per)
weight

#이윤지/ 20191223
#신규 산업체수*가중치
employ <- read.csv('employee.csv')
employ
ex<- employ$X2016*0.06293826 #2016년 산업별 신규 산업체 수 * 가중치(이주민 수)
re<- employ$X2017*0.06354144 #2017년 산업별 신규 산업체 수 * 가중치(이주민 수)
ex; re
industry <- c("전체 산업","농업/임업/어업","광업","제조업",
              "전기,가스,증기 및 공기조절 공급업",
              "수도,하수 및 폐기물 처리, 원료 재생업",
              "건설업","도매 및 소매업","운수 및 창고업",
              "숙박 및 음식점업","정보통신업","금융 및 보험업",
              "부동산업","전문, 과학 및 기술 서비스업",
              "사업시설 관리/사업 지원 및 임대 서비스업",
              "공공행정, 국방 및 사회보장 행정","
              교육 서비스업","보건업 및 사회복지 서비스업",
              "예술/스포츠 및 여가관련 서비스업",
              "협회 및 단체/수리 및 기타 개인 서비스업")
weight2<- data.frame(industry, ex,re)
weight2
weight2 <- weight2[-1,]
weight2 <- subset( weight2, weight2$ex >= 100 & weight2$re >= 100)

# par(mfrow = c(1,2))
# hist( weight2$ex, xlab = "2016년 가중치" )
# hist( weight2$re, xlab = "2017년 가중치" )
# par(mfrow = c(1,1))

class(weight2)


setwd('D:/5_project/가설1')
weight2
write.csv( weight2, "weight.csv", row.names = F, quote = F)

#박주은/ 20191223
#시계열분석-ARIMA 모형을 통한 미래추세 예측(GRDP)

setwd("D:/workR")
cnt<- read.csv('grdp.csv')
install.packages('TTR')
install.packages('forecast')

library(TTR)
library(forecast)

cnt
jeju<- cnt[,2]
jeju

jeju_ts <- ts(jeju)
jeju_ts

jeju_sma3 <- SMA(jeju_ts, n = 3)
jeju_sma8 <- SMA(jeju_ts, n = 8)
jeju_sma12 <- SMA(jeju_ts, n = 12)

par(mfrow = c(2,2))

plot.ts(jeju_ts)
plot.ts(jeju_sma3)
plot.ts(jeju_sma8)
plot.ts(jeju_sma12)

jeju_diff1 <- diff(jeju_ts, differences = 1)
jeju_diff2 <- diff(jeju_ts, differences = 2)
jeju_diff3 <- diff(jeju_ts, differences = 3)

plot.ts(jeju_ts)
plot.ts(jeju_diff1)   
plot.ts(jeju_diff2)
plot.ts(jeju_diff3)

par(mfrow = c(1,1))

mean(jeju_diff1); sd(jeju_diff1)

acf(jeju_diff1, lag.max = 20)    
pacf(jeju_diff1, lag.max = 20) 

auto.arima(jeju) 

jeju_arima <- arima(jeju_ts, order = c(3,1,1))
jeju_arima

library(forecast)
library(forecast.Arima)

jeju_fcast <- forecast(jeju_arima)
jeju_fcast
jeju_fcast<- forecast(jeju_arima,h=10)
jeju_fcast

plot(jeju_fcast)

jeju_arima1 <- arima(jeju_ts, order = c(0,1,1))
jeju_arima1
 
jeju_fcast1 <- forecast(jeju_arima1, h = 5)
jeju_fcast1

plot(jeju_fcast1)

#제주 이주민 직업별 소득비교
setwd("D:/workR")
cnt<- read.csv('people.csv')
cnt
str(cnt)
install.packages("ggplot2")

library(ggplot2)

ggplot(cnt,aes(x="",y=관리자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

#  geom_text(aes(label=paste0(round(관리자,1),"%")),
#position=position_stack(vjust=0.5))+


#par(mfrow = c(2,2))

ggplot(cnt,aes(x="",y=관리자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=전문가.및.관련종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=사무.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=서비스.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=판매.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=농림수산업.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=기능원.및.관련.기능.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=장치.기계.조작.및.조립.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=단순노무.종사자,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=군인,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=학생,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=주부,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=취업.준비중,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()

ggplot(cnt,aes(x="",y=무직,fill=income))+
  geom_bar(width=1,stat="identity",color='white')+
  coord_polar("y")+theme_void()


#선행지수, 동행지수 시계열

##선행지수 변수(2010~2018)
소비자물가지수 <- c(91.82, 95.76, 96.93, 98.27, 99.37, 100.00, 101.29, 103.62, 105.42) #2015=100
건축허가면적 <- c(1592.80,	2340.50,	2475.80,	2205.60,	3459.50,	3857.00,	4781.30,	3534.90,	2348.00)

#동행지수 변수

취업자수 <- c(284, 294, 303, 309, 322, 339, 355, 374, 372)  #단위 : 천명
관광객수 <- c(7578301, 8740976, 9691703, 10851265, 12273917, 13664395, 15852980, 14753236, 14313961) #단위 : 명
광공업생산지수 <- c(78.87,	84.64,	87.93,	91.37,	93.05,	100,	101.75,	112,	113.17) #2015=100

year <- 2010:2018
cnt<- data.frame(소비자물가지수,건축허가면적,취업자수,관광객수,광공업생산지수,year)
head(cnt)

par(mfrow=c(2,3))
ggplot(cnt,aes(x=year,y=소비자물가지수,group=1))+
  geom_line()+
  ggtitle("소비자물가지수")+
  theme(plot.title=element_text(size=20))

ggplot(cnt,aes(x=year,y=건축허가면적,group=1))+
  geom_line()+
  ggtitle("건축허가면적")+
  theme(plot.title=element_text(size=20))

ggplot(cnt,aes(x=year,y=취업자수,group=1))+
  geom_line()+
  ggtitle("취업자수")+
  theme(plot.title=element_text(size=20))

ggplot(cnt,aes(x=year,y=관광객수,group=1))+
  geom_line()+
  ggtitle("관광객수")+
  theme(plot.title=element_text(size=20))

ggplot(cnt,aes(x=year,y=광공업생산지수,group=1))+
  geom_line()+
  ggtitle("광공업생산지수")+
  theme(plot.title=element_text(size=20))

par(mfrow = c(1,1))


#주요시도인구성장률(2011~2018)
cnt<- read.csv('grow.csv')
cnt
head(cnt)
ggplot(cnt,aes(x=year,y=전국,group=1))+
  geom_line()+
  ggtitle("전국")

#
setwd("c:/workR")
grdp<- read.csv('grdp.csv')

install.packages("ggplot2")
install.packages("ggthemes")
install.packages("extrafont")

library(ggplot2)
library(ggthemes)
library(extrafont)
grdp

#시계열
colour <- c("#5F9EA0","#E1B378","#40b8d0", "#b2d183")
p1 <- ggplot()+
  geom_line(aes(x=year,y=전국,colour="전국"),data=grdp,stat="identity",size=1.0)+
  geom_line(aes(x=year,y=제주특별자치도,colour="제주"),data=grdp,stat="identity",size=1.5)+
  geom_line(aes(x=year,y=서울특별시,colour="서울"),data=grdp,stat="identity",size=1.0)+
  geom_line(aes(x=year,y=부산광역시,colour="부산"),data=grdp,stat="identity",size=1.0)+
  geom_line(aes(x=year,y=대구광역시,colour="대구"),data=grdp,stat="identity",size=1.0)+
  geom_line(aes(x=year,y=광주광역시,colour="광주"),data=grdp,stat="identity",size=1.0)+
  geom_line(aes(x=year,y=울산광역시,colour="울산"),data=grdp,stat="identity",size=1.0)+
  labs(x="year",y="1인당 GRDP")+
  ggtitle("시도별 1인당 GRDP(단위:천원)")+
  coord_cartesian(ylim=c(18000, 65000))
  theme(legend.position = "bottom",legend.direction = "horizontal",legend.title = element_blank())
p1
p1+scale_fill_brewer(palette="Greens")


#파이차트
grdp2<- read.csv('grdp2.csv')
grdp2

ggplot(grdp2,aes(x="",y=GRDP,fill=city))+
  geom_bar(width=1,stat="identity",color="white")+
  coord_polar("y")+
  theme_void()

#막대그래프
palete="greens"
grdp2
p1 <- ggplot(grdp2,aes(x=reorder(city,GRDP),y=GRDP,fill=city))+geom_bar(stat="identity")

p1+scale_fill_brewer(palette="Greens",direction = -1)


