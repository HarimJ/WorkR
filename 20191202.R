#
#5일차
#
setwd("D:/WorkR")
df <- read.table(file = "airquality.txt", header = T )
df
class(df)
dim(df)
str(df)
head(df, 3)
tail(df, 3)

install.packages("xlsx")
install.packages("rJava")

library(rJava)
library(xlsx)

df.xlsx <- read.xlsx(file = "airquality.xlsx", sheetIndex = 1,
                     encoding = "UTF-8")
df.xlsx
class(df.xlsx)
str(df.xlsx)
head(df.xlsx, 3)
tail(df.xlsx, 3)

score <- c(76, 84, 69, 50, 95, 6, 82, 71, 88, 84)
which(score == 69)          #69가 있는 값의 위치는 어디냐
which(score >= 85)
max(score)
which.max(score)
min(score)
which.min(score)

idx <- which(score >= 60)      #60보다 큰 값을 불러 저장
score[ idx ] <-  61            # 그 값들을 다 61로 변경
score

idx <- which(iris [, 1:4] > 5.0, arr.ind = TRUE)   #TRUE이면 행과 열의 것을 가져온다? / 
idx                                                #arr.ind를 써야 좌표값이 주어진다 

#
#단일변수 (일변량) 범주형 자료 탐색 : 산술연산이 필요하지 않은/ 개수만 필요한 도수분포표!! 
#
favorite <- c('WINTER','SUMMER','SPRING','FALL','SPRING','WINTER','WINTER','FALL','WINTER','FALL')
favorite
class(favorite)
table(favorite)
table(favorite) / length(favorite)    #해당하는 도수분포에 비율구하기 
ds <- table(favorite)
ds
barplot(ds, main = 'favorite season')

ds.new <- ds[c(2,3,1,4)]              #위치변경 - 읽기 쉽게:)
ds.new
barplot(ds.new, main = 'favorite season')

pie( ds, main = 'favorite season')
pie( ds.new, main = 'favorite season')

favorite.color <-  c(2,3,2,1,1,2,2,1,3,2,1,3,2,1,2)     #숫자형이지만 범위가 정해진 범주형이다. 
ds <- table( favorite.color); ds
barplot(ds, main = "favorite color")
colors <- c('orange','pink','lightblue')
names(ds) <- colors;  ds
barplot(ds, main = 'favorite color', col = colors)
pie(ds, main = 'favorite color', col = colors)

#
# 단일변수(일변량) 연속형 자료탐색
#
weight <- c(60, 62,64,65,68,69)
weight.heavy <- c(weight, 120); weight.heavy
#평균
mean(weight); mean(weight.heavy)
#중앙값
median(weight); median(weight.heavy)
#절사평균 - 가장 크고 가장 낮은 값을 제외시킨 평균을 낸다. 
mean(weight, trim = 0.2)   #trim = 하위, 상위 몇프로를 제외한다. 
mean(weight.heavy, trim = 0.2)
#사분위수 - 4분위로 나눠서 하위부터 25% : 1사분위// 50% : 2사분위 // 75% :3사분위 
#즉 2사분위가 절반. 0%라고 나오는게 최소값. 100%는 최대값. 
quantile(weight.heavy)
quantile(weight.heavy, (0 : 10)/10)
summary( weight.heavy)
#산포(distribution)   #값이 얼마나 퍼져있는냐, 얼마나 모여있는냐./ 
#분산
var(weight)     
#표준편차
sd(weight)            #편차값이 적으면 데이터가 모여져있다는ㄸ

#값의범위(최소값과 최대값)
range(weight)
#최대값과 최소값의 차이
diff(range(weight))

#histogram :  연속형 자료의 분포를 시각화
#연속형 자효에서는 구간으 나누고 구간에 속한 값들의 개수를 세는 방법으로 사용
str(cars)
dist <- cars[,2]
hist(dist, main = 'Histogram for 제동거리', 
     xlab = '제동거리', ylab = '빈도수',
     border = 'blue', col = 'green',
     las = 2, breaks = 5)               #las는 x,y축 숫자들 방향정하기 (0~3까지있음)

#상자그림(boxplot, 상자수염그림)
#  사분위수를 시각화하여 그래프 형태로 표시
#  상자그림은 하나의 그래츠로 데이터의 분포
#  형태를 포함한 다양한 정보를 전달
#  자료의 전반적인 분포를 이해하는데 도움
#  구제적인 최소/최대/중앙값을 알기는 어렵다. 
boxplot(dist, main = '자동차 제동거리')

boxplot.stats(dist)          #구체적인 값을 알고싶을때
boxplot.stats(dist)$stats    #정상범위 사분위수
boxplot.stats(dist)$n        #관측치 개수
boxplot.stats(dist)$conf     #중앙값 신뢰구간
boxplot.stats(dist)$out      #이상치(특이값)목록


#일변량중 그룹으로 구성된 자료의 상자그림
boxplot(Petal.Length~Species,             #그릅을 지을때 품종병 길이를 보고싶을때 꼭 ~ 한다. 순서가 중요.
        data = iris, main = '품종별 꽃잎의 길이')
boxplot(iris$Petal.Length~iris$Species,
        main = ' 품종별 꽃잎의 길이')


#한 화면에 여러 그래프 작성
par(mfrow = c(1,3)) #1 X 3 가상화면 분할
barplot(table(mtcars$carb), main = 'C',
        xlab = "carburetors", ylab = 'freq',
        col = "blue")
barplot(table(mtcars$cyl), main = 'Cyl',
        xlab = "cyl", ylab = 'freq',
        col = "red")
barplot(table(mtcars$gear), main = 'G',
        xlab = "gear", ylab = 'freq',
        col = "green")
par(mfrow = c(1,1)) #가상화면 분할 해제// 분할하고 해제하는게 일치해야한다. 

#-------여기부터 위(43번)에까지 일변량의 범주형/ 연속형 데이터 분석을 해봄--------#




