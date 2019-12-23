#
#11일차
#
#
# open source를 사용할때
# 1. Bug가 존재가능하다. 꼭확인해보기. 
# 2. 저작권이 어떤지 잘 확인해야한다. - 내가 사용한 source를 수정했다면 꼭 알려야한다. 
#
#
# mosaic 시각화 함수 사용방법 사이트 
# https://www.rdocumentation.org/packages/vcd/versions/1.4-4/topics/mosaic
#
#    mosaic은 범주형이면서 다중 범주일때 사용한다. 
#
#
# 다중변수 범주형 데이터에 대한 각 변수의 그룹별 비율을 면적으로 표시
#
str(mtcars)
head(mtcars)
mosaicplot(~gear + vs,              # 대상변수  ->  ~다음이 x축, +다음이 y축
           data = mtcars,           # 데이터셋
           color = TRUE,            # y측 변수의 그룹별 음영 다르게 표시  (서로 다른 값을 음영으로 처리해라 = TRUE)
           main = "Gear and Vs")    # 제목
                                    # 두 범주형 데이터의 비율!! 을 시각화. 

mosaicplot( ~gear + vs, data = mtcars,
            color = c("green", "blue"),    # 색상지정
            main = "Gear and Vs")


  #  같은 결과 다른 방법
tbl <- table(mtcars$gear, mtcars$vs)       # 빈도확인할때 쓰는 table함수를 사용해서 두 범주형 변수의 교차표를 만들기. 
tbl
mosaicplot(tbl, color = T, main = "Gear and Vs")   # 여시서는 x,y 변수를 따로 주지 않아도 적용된다. 


#
# 차원 축소( Dimension Reduction )
#
install.packages("Rtsne")
library(Rtsne)
library( ggplot2)

ds <- iris[ , -5]         # 마지막은 품종(범주형)이니까 제외하고// 우리는 계속 2개만 사용했는데 이번에는 4개를 사용해서 분석. 

# 차원 축소
# 중복 데이터 제거 
dup = which(duplicated(ds))    # duplicated는 중복데이터를 찾는 함수/ which는 어디있나
dup
ds <- ds[ - dup, ]             #중복데이터 제거
ds.y <- iris$Species[ -dup ]   #중복된 데이터의 품종도 제거 (꼭 해줘야한다.)

# 차원 축소 수행 - t-SNE 함수 실행
tsne <- Rtsne(ds,                   #차원 죽소 대상 데이터 셋
              dim = 2,              #축소할 차원 2/ 3차원  (여기서는 2차원)
              perplexity = 10)      #차원 축소 과정에서 데이터 샘플링을 수행하는데 ///// perplexity = 10 :샘플링을 10번 한다. 
                                    # 샘플의 갯수(대상의 데이터수) / 3 보다 작게 지정. ( / = 나누기) 
                                    # 차원을 줄일 때 한번에 다하는것보다 조금씩 샘플링을 취해서 하는 게 좋다. 
tsne <- Rtsne(ds, dim = 2, perplexity = 10)
tsne


# 차원 축소 결과 시각화
df.tens <- data.frame(tsne$Y)    # Y변수값을 추출해서 그 Y값의 변화? 값으로 그래프를 그리겠다. 는 뜻..? 
head(df.tens)

ggplot(df.tens, aes(x = X1, y = X2, color = ds.y)) +
  geom_point(size = 2)


install.packages(c("rgl", "car"))
library(car)
library(rgl)
library(mgcv)


tsne <- Rtsne(ds, dims = 3, perplexity = 10)
df.tsne <- data.frame(tsne$Y)
head(df.tsne)

scatter3d(x = df.tsne$X1, y = df.tsne$X2, z = df.tsne$X3)


points <- as.integer(ds.y)
color <- c('red', 'green', 'blue')
scatter3d(x = df.tsne$X1, y = df.tsne$X2, z = df.tsne$X3,
          point.col = color[points], surface = FALSE)


#  차원 활용 설명 사이트
#  https://skyeong.net/186



#
#공간 시각화
#
#google map 사용
#
# 절차
# 1. R 최신버전설치
# 2. ggplot2 최신버전 설치
# 3. ggmap 설치
# 4. 구글맵 사용하기 위한 API key 획득
# 5. 구글맵을 이용한 공간 시각화 수행


library(ggmap)
register_google(key = "AIzaSyDlnUhm-Llf-JUjfPpyNG6yEkeZDwoiAi4")

gc <- geocode(enc2utf8("제주"))     # geocode : 어느 특정지점("이름")의 지도상의 경도와 위도를 알려주는 함수 
gc                                  # 형식 : tibble


cen <- as.numeric(gc)               # 경도/위도를 숫자로 변환
cen                                 # tibble은 frame같은 형식이라서 숫자로 사용하지 못한다.그래서 꼭 숫자로 바꿔줘야한다. 


# 지도 표시
map <- get_googlemap(center = cen)  # 지도 중심점(center) 좌표
ggmap(map)                          # 3D 형식 지도


gc <- geocode( enc2utf8( "한라산"))
cen <- as.numeric( gc)
map <- get_googlemap(center = cen,           #지도 중심점 좌표
                     zoom = 10,              # 지도 확대 정도
                     size = c(640, 640),     # 지도 크기
                     maptype = "roadmap")    # 지도 유형 // roadmap : 도로 중심 지도
ggmap(map)



cen <- c(126.561099, 33.253077)        # 경도, 위도 직접 입렵. // (구글맵에서는 위도, 경도 순으로 나온다) 
map <- get_googlemap(center = cen, zoom = 18, maptype = "roadmap")
ggmap(map)


# 지도 위 마커 표시
gc <- geocode(enc2utf8("제주"))
cen <- as.numeric(gc)
map <- get_googlemap(center = cen, maptype = "roadmap", marker = gc)    #마커 표시를 경도위도 위치에 넣음
ggmap(map)


# 제주 관광지를 지도위에 표시  
#   *참고* 내가 표시하고 싶은 장소의 위도와 경도를 뽑아와서 데이터 프레임으러 만든 후 바로 구글맵에 사용하면 된다.
names <- c("용두암", "성산일출봉", "정방폭포","중문관광단지","한라산1100고지", "차귀도")       # 이름 지정
addr <- c("제주시 용두암 길 15", "서귀포시 성산읍 성산리", "서귀포시 동흥동 299-3", "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2", "제주시 한경면 고산리 125")                                 # 주소 지정
gc <- geocode(enc2utf8(addr))     # 실제 주소 정보를 사용해서 경도, 위도 알아오기
gc                                # 경도, 위도 값

df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
df 
 
cen <- c(mean(df$lon), mean(df$lat))    # mean은 중심을 잡은것. 
map <- get_googlemap(center = cen, maptype = "roadmap", zoom = 10, size = c(640, 640), markers = gc)
ggmap(map)


# 지도에 관광지 이름 추가
gmap <- ggmap(map)
gmap + 
  geom_text(data = df,                    # 데이터셋
            aes(x = lon , y = lat),       # 텍스트 위치  (경도와 위도 값)
            size = 5,                     # 텍스트 크기
            label = df$name)              # 텍스트 이름  (데이터 프레임에 지정한 이름)



# 지도에 데이터 표시
dim(wind)
str(wind)

sp <- sample(1:nrow(wind), 50 )     # 50개만 샘플링
df <- wind[ sp, ]
head(df)

cen <- c(mean(df$lon), mean(df$lat))     # 경도, 위도를 사용// 지도 중심점
gc <- data.frame(lon = df$lon, lat = df$lat)
head(gc)

# 지도에 마커 표시
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 6,
                     markers = gc)
ggmap(map)

# 지도에 풍속을 원의 크기로 표시 
map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 6)

gmap <- ggmap(map)
gmap +
  geom_point(data = df,
             aes(x = lon, y = lat, size = spd),       # spd(스피드)로 사이즈 기준을 정함
             alpha = 0.5, col = "blue") +
  scale_size_continuous(range = c(1,14))              # 원크기 조절 (1부터 14범위로 원의 크기 지정)
     


# 단계 구분도
install.packages("ggiraphExtra")        #  
library( ggiraphExtra)                

dim(USArrests)
str(USArrests)
head(USArrests)

library(tibble)                         #  
crime <- rownames_to_column(USArrests, var = "state")    #  
crime$state <- tolower(crime$state)                      #  
str(crime)


library(ggplot2)
install.packages("mapproj")
library(mapproj)

state_map <- map_data("state")      
str(state_map)

ggChoropleth( data = crime,        
              mapping = aes( fill = Murder,    
                   map_id = state),            
              map = state_map)                 

      #  위에 코딩 다시 한번 보기/ 자습

#
# 한국 지도 모양을 사용하고 싶을 때 
# 한국행정지도(2014) 패키지 kormaps2014 안내
# http://rpubs.com/cardiomoon/222145
#

install.packages("devtools")                            # github에 접근하기 위한 패키지 (밑에 패키지들은 깃허브에만 있음)
devtools::install_github("cardiomoon/kormaps2014")      # github에서 가져오기 // 이게 있어야 우리나라 지도를 받을 수 있음
devtools::install_github("cardiomoon/moonBook2")        # 이게 있어야 우리나라 지도를 받을 수 있음 (위에거랑 이거랑 두개 다)

library(kormaps2014)   # 우리나라 지도에 관한 좌표
library(moonBook2)     # 우리나라 지도에 관한 좌표

areacode
str(kormap1)


# ggplot2를 이용한 단계구분도 그리기  (사이트 참고)
library(ggplot2)
theme_set(theme_gray(base_family="NanumGothic"))

ggplot(korpop1,aes(map_id=code,fill=총인구_명))+
  geom_map(map=kormap1,colour="black",size=0.1)+
  expand_limits(x=kormap1$long,y=kormap1$lat)+          # expand_limits : 범위 : 경도 & 위도
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()                                           # 회전


# kormap1 : 2014년 한국행정지도(시도별)
# kormap2 : 2014년 한국행정지도(시군구별)
# kormap3 : 2014년 한국행정지도(읍면동별)

  # 주의사항 : 나중에 다시 실행했을 때 안되면 그건 데이터 업데이트 때문일 수 도 있다. (한국지도 사이트에서)
  #            그럼 패키지 다 삭제하고 다시 설치/ 실행



