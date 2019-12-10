#
# 장하림
# 20191210 / 20191211
#
# 문1)
# R에서 제공하는 state.x77 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오. 
# state.x77은 매트릭스 타입이기 때문에 데이터프레임으로 변환하여 실습한다.

st <- as.data.frame(state.x77)
str(st)
library(Rtsne)
library(ggplot2)

dup = which(duplicated(st))
dup
dim(st)


tsne <- Rtsne(st, dim = 2, perplexity = 15)
tsne
df.tens <- data.frame(tsne$Y)
head(df.tens)
ggplot(df.tens, aes(x = X1, y = X2)) +
  geom_point(size = 2)

library(car)
library(rgl)
library(mgcv)

tsne.1 <- Rtsne(st, dims = 3, perplexity = 15)
tsne.1
df.tens.1 <- data.frame(tsne.1$Y)
head(df.tens.1)

scatter3d(x = df.tens.1$X1, y = df.tens.1$X2, z = df.tens.1$X3)


# 문2)
# R에서 제공하는 swiss 데이터셋을 차원 축소하여 2차원 산점도와 3차원산점도를 작성하시오.
swiss
str(swiss)
dim(swiss)

dup1 <- which(duplicated(swiss))
dup1

sne <- Rtsne(swiss, dim = 2,perplexity = 15 )
sne
s <- data.frame(sne$Y)
ggplot(s, aes(x = X1, y = X2)) + 
  geom_point(size = 3)


sne.1 <- Rtsne(swiss, dims = 3, perplexity = 15)
sne.1
s.1 <- data.frame(sne.1$Y)
scatter3d(x = s.1$X1, y = s.1$X2, z = s.1$X3)


# 문3) 
# R을 이용하여 지도를 출력하시오.
# (1) 서울시청을 중심으로 지도 크기는 600x600, 지도 유형은 roadmap인 지도를 출력하시오.

library(ggmap)
register_google(key = "AIzaSyDlnUhm-Llf-JUjfPpyNG6yEkeZDwoiAi4")

gc <- geocode(enc2utf8("서울시청"))
gc

cen <- as.numeric(gc)
cen

map <- get_googlemap(center = cen, zoom = 10, size = c(600, 600), maptype = "roadmap")
ggmap(map)


# (2) 금강산 지역을 근방으로 지도 크기는 500x500, 지도 유형은 hybrid, zoom은 8인 지도를 출력하시오.
 gc.1 <- geocode(enc2utf8("금강산")); gc.1

cen.1 <- as.numeric(gc.1); cen.1

map.1 <- get_googlemap(center = cen.1, zoom = 8, size = c(500, 500), maptype = "hybrid")
ggmap(map.1)


# (3) 강남역 근방으로 지도 크기는 640x640, 지도 유형은 roadmap, zoom은 16인 지도를 출력하시오.
gc.2 <- geocode(enc2utf8("강남역"));  gc.2

cen.2 <- as.numeric(gc.2);  cen.2

map.2 <- get_googlemap(center = cen.2, zoom = 16, size = c(640, 640), maptype = "roadmap")
ggmap(map.2)


# (4) 지도 유형은 roadmap, zoom은 9인 경도 127.397692, 위도 36.337058 지역의 지도를 출력하시오.
cen.3 <- c(127.397692, 36.337058)
map.3 <- get_googlemap(center = cen.3, zoom = 9, maptype = "roadmap")
ggmap(map.3)


# (5) 지도 유형은 roadmap, zoom은 10인 경도 135.502330, 위도 34.693594 지역의지도를 출력하시오.
cen.4 <- c(135.502330, 34.693594)
map.4 <- get_googlemap(center = cen.4, zoom = 10, maptype = "roadmap")
ggmap(map.4)



# 문4)
# R을 이용하여 서울시 한강 이남의 구청들의 위치에 마커와 구청 이름을 지도 위에 표시하시오.
gc.10 <- geocode(enc2utf8(c("강서구청", "영등포구청", "양천구청","구로구청", "동작구청", "서초구청", "강남구청", "송파구청", "강동구청", "금천구청")))
gc.10
names = c("강서구청", "영등포구청", "양천구청","구로구청", "동작구청", "서초구청", "강남구청", "송파구청", "강동구청", "금천구청")
df <- data.frame(name = names, lon = gc.10$lon, lat = gc.10$lat)
df

cen.10 <- c(mean(df$lon), mean(df$lat))
map.10 <-  get_googlemap(center = cen.10, maptype = "roadmap", zoom = 11, size = c(640, 640) , markers = gc.10)
gmap <- ggmap(map.10)
gmap + 
  geom_text(data = df, aes(x = lon, y = lat), size = 5, label = df$name)


# 문5)
# R을 이용하여 대한민국의 광역시를 지도 위에 출력하시오. 단, 마커와 광역시 이름을 함께 표시하시오.
gc.11 <- geocode(enc2utf8(c("인천광역시", " 대전광역시", "부산광역시", "울산광역시","대구광역시", "광주광역시")))
names <- c("인천광역시", " 대전광역시", "부산광역시", "울산광역시","대구광역시", "광주광역시")
df.2 <- data.frame(name = names, lon = gc.11$lon, lat = gc.11$lat)
df.2
cen.11 <- c(mean(df.2$lon), mean(df.2$lat))
map.11 <- get_googlemap(center = cen.11, maptype = "roadmap", zoom = 7, size = c(640,640), markers = gc.11)
gmap.2 <- ggmap(map.11)
gmap.2 +
  geom_text(data = df.2, aes(x = lon, y = lat), size = 5, label = df.2$name)


# 문6)
# R을 이용하여 서울, 경기, 강원 지역의 국립공원 위치를 지도 상에 마커로시하되 
# 국립공원의 이름을 함께 표시하시오.
gc.12 <- geocode(enc2utf8(c("설악산 국립공원","오대산국립공원","북한산국립공원","치악산국립공원")))
names <- c("설악산 국립공원","오대산국립공원","북한산국립공원","치악산국립공원")
df.3 <- data.frame(name = names, lon = gc.12$lon, lat = gc.12$lat)
df.3
cen.12 <- c(mean(df.3$lon), mean(df.3$lat))
map.12 <- get_googlemap(center = cen.12, maptype = "roadmap", zoom = 7, size = c(640,640), markers = gc.12 )
gmap.3 <- ggmap(map.12)
gmap.3 +
  geom_text(data = df.3, aes(x = lon, y = lat), size = 5, label = df.3$name)


#문7) 
#‘2018년도 시군구별 월별 교통사고 자료’로부터 서울시의 각 구별 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.

library(tibble)
setwd("d:/")
car <- read.csv("도로교통공단_시도_시군구별_월별_교통사고(2018).csv")
car <- as.data.frame(car)
str(car)
head(car)
car <- car[,-3]  
car
city <- car$시군구
city
gc.car <- geocode(enc2utf8(c("강남구", "강동구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구",
                             "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구","영등포구", "용산구", "은평구", "종로구", "중구", "중랑구")))
cnames <- c("강남구", "강동구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구",
            "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구","영등포구", "용산구", "은평구", "종로구", "중구", "중랑구")
df.car <- data.frame(name = cnames, lon = gc.car$lon, lat = gc.car$lat)
cen.car <- c(mean(df.car$lon), mean(df.car$lat))
map.car <- get_googlemap(center = cen.car, maptype = "roadmap", zoom = 9, markers = gc.car)
gmap.car <- ggmap(map.car)
gmap.car + 
  geom_point(data = car, aes(x = df.car$lon, y = df.car$lat, size = 발생건수, alpha = 0.5, col = "blue"))
scale_size_continuous(range = c(1,14))
car








#문8)
#7번과 동일한 자료를 이용하여 제주시 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.