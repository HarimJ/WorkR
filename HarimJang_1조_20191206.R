setwd("d:/data")
cctv_2018 <- read.csv(file("2018년_제주특별자치도_제주시_CCTV_20180430 (1).csv"))
cctv_2018
cctv_2018_s <- read.csv(file = "2018년_제주특별자치도_서귀포시_CCTV_20180731 (1).csv")

cctv_2018 <- as.data.frame(cctv_2018)
cctv_2018_s <- as.data.frame(cctv_2018_s)

library(dplyr)
car_Jnum <- cctv_2018 %>% select("카메라대수")
car_Jnum <- sum(car_Jnum); car_Jnum

str(cctv_2018_s)
car_Snum <- cctv_2018_s %>% select("카메라대수"); car_Snum
car_Snum <- sum(car_Snum); car_Snum

chart_data <- c(car_Jnum, car_Snum)
names(chart_data) <- c('제주시', '서귀포시')
barplot(chart_data, ylab = 'CCTV 수', col = c('skyblue', 'orange'))


vis_K <- read.csv(file = "제주특별자치도_내국인관광객현황_20181231.csv")
vis_F <- read.csv(file = "제주특별자치도_외국인관광객현황_20181231.csv")
vis_K <- as.data.frame(vis_K)
vis_F <- as.data.frame(vis_F)
head(vis_K)
head(vis_F)

a <- vis_K[,c(-1,-14)]; a
b <- colSums(a); b

c <- vis_F[,c(-1,-14)];c
d <- colSums(c); d

e <- cbind(b,d); e
f <- rowSums(e);f 

#plot(f, main = "월별 관광객 수",type = 'b', xlab = 'Month', ylab = 'Visitors')

boxplot(f)    #이상치 없음. 

g <- mean(f); g

ppl <- c(501791, 190241,g)
names(ppl) <- c('제주시','서귀포시','관광객')
pie(ppl, col = c("skyblue", "orange","green"), main = '2018년도 제주시, 서귀포시, 관광객 인구분포')


head(cctv_2018)
head(cctv_2018_s)
cctv <- merge(cctv_2018, cctv_2018_s, all = TRUE)
cctv
str(cctv)
cctv$설치목적구분
table(cctv$설치목적구분)
kn <- cctv %>% select(설치목적구분); kn
plot(kn, main = 'CCTV 설치 목적별 구분')





