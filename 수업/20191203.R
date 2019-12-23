#
#6일차
#
#다중변수 자료 탐색
#두 변수 사이의 산점도
#산점도(scatter plot) - 2변수로 구성된 자료의 분포를 알아보는 그래프
#                       관측값들의 분포를 통해 2변수 사이의 관계파악
#이변량
wt <- mtcars$wt
mpg <- mtcars$mpg
plot(wt,mpg, main = '중량-연비 그래프',
     xlab = '중량', ylab = '연비',
     col = "red", pch = 19)


#(이변량) 같은 결과 다른 방법들 1,2,3
wt <- mtcars$wt
mpg <- mtcars$mpg
plot(wt,mpg, main = '중량-연비 그래프',
     xlab = '중량', ylab = '연비',
     col = "red", pch = 19)

plot(mtcars[,c("wt","mpg")], main = '중량-연비 그래프',
     xlab = '중량', ylab = '연비',
     col = "red", pch = 19)

plot(mpg~wt, data = mtcars, main = '중량-연비 그래프',
     xlab = '중량', ylab = '연비',
     col = "red", pch = 19)


#다변량
#여러 변수들간의 산점도
vars <- c("mpg","disp","drat","wt")     #vector생성/ 변수이름
target <- mtcars[,vars]                 #변수 4개를 뽑아낸것. 
head(target)                    
pairs(target, main = "multi plots")     #다변량의 산점도 그리기 
                                        #대각선이 변수들. 선을 중심으로 대칭관계 
                                        # 즉 x와 y의 위치가 서로 반대됨. 

#그룹정보가 있는 두변수의 산점도
iris.2 <- iris[, 3:4]
point <- as.numeric(iris$Species)   #품종이 3개라서 범주형이라서 숫자형으로 바꿈.
point                               #숫자형으로 변경하고 출력
color <- c("red","green","blue")    #각 숫자에 색을 넣음
plot(iris.2, main = "Iris plot", pch = c(point), col = color[point])
#pch에서 그 번호대로 마킹을 하겠다 해서 pch = c(point) 
#color도 이미 각 번호에 색을 지정해서 그대로 col = color[point]
#범주형은 그룹으로도 볼수 있다. iris에서 종류가  3개니까 그룹으로. 
#
#해석 : 빨강종류는 길이도 작고 넓이도 작다. 그외 파란종류는 길고 넓다. 


#상관분석
beers <- c(5,2,9,8,3,7,3,5,3,5)         #몇잔
bal <- c(0.1,0.03,0.19,0.12,0.04,0.0095,0.07,0.06,0.03,0.05)  #농도
tbl <- data.frame(beers,bal)
tbl
plot(bal~beers, data = tbl)           #산점도

res <- lm(bal~beers, data = tbl)      #회귀식(lm) -> y = xw + b
res
abline(res)                           #회귀선
cor(tbl[,1:2])                        #이변량 상관계수 (r)
cor(iris[,1:4])                       #다변량 상관계수

#상관분석 순서
#
#1.상관분석 대상 변수선정
#2.산점도 작성 (관측값 분포 확인) : plot()
#3.회귀식 도출 : lm()
#      (회귀식 : 두 변수의 선형관계를 가장 잘 나타낼 수 있는 선의 식)
#      (y = xw + b)
#4.회귀선을 산점도에 표시 : abline()
#      (회귀선 : 관측값들의 추세를 가장 잘 나타낼 수 있는 선)
#5.상관계수 계산 : cor()
#6.상관분석 결과 해석
#
#이게 절대적인것이 아니라 강사님의 방법이므로 참고하기. 


#
#시계열 Data - 선그래프
month <- 1:12
late <-c(5,8,7,9,4,6,12,13,8,6,6,4)
plot(month,late, main = "지각생통계",
     type = "l", lty = 1, lwd = 1, xlab = "Month", ylab = "late cnt")
plot(month,late, main = "지각생통계",
     type = "b", lty = 1, lwd = 1, xlab = "Month", ylab = "late cnt")
plot(month,late, main = "지각생통계",
     type = "o", lty = 1, lwd = 1, xlab = "Month", ylab = "late cnt")
plot(month,late, main = "지각생통계",
     type = "s", lty = 1, lwd = 1, xlab = "Month", ylab = "late cnt")
#type = 그래프모양 , lty = 선의모양, lwd = 선의두께
#x축에 시간의 좌표룰 표시한게 시계열 데이터.


#복수의 선 그래프
late1 <- c(5,8,7,9,4,6,12,13,8,6,6,4)
late2 <- c(4,6,5,8,7,8,10,11,6,5,7,3)
plot(month, late1, main = "지각생통계",
     type = "b", lty = 1, col = "red", xlab = "Month", ylab = "late cnt", 
     ylim = c(1,15))
lines(month,late2, type = "b", col = "blue")


#
#자료 탐색 실습 - 탐색적 데이터 분석
#
#0단계 : 문제 정의 - 
#1단계 : 분석 대상 데이터셋 준비
#        BostonHousing 데이터셋(mlbench pac.)
install.packages("mlbench")
library(mlbench)
data("BostonHousing")
#crim : 1인당 범죄율
#rm : 주택 1 가구당 방의 수
#dis : 보스턴 5개 지역센터까지의 거리
#tax : 재산세율
#medv : 주택가격
dim(BostonHousing)
class(BostonHousing)
str(BostonHousing)
head(BostonHousing)
tail(BostonHousing)
myds <- BostonHousing[,c("crim","rm","dis","tax","medv")]
myds
#2단계: 파생변수 추가 :  grp변수 추가(주택가격상중하)
grp <- c()                   #빈 벡터
for (i in 1:nrow(myds)) {    #nrow(myds) : 1부터 myds에 있는 모든 값들까지 반복해라  
  if(myds$medv[i] >= 25.0) {
    grp[i] <- 'H'
  } else if (myds$medv[i] <= 17.0){
    grp[i] <- 'L'
  } else {
    grp[i] <- 'M'
  }
}
grp <- factor(grp)          #빅벡터안에 값을 넣고 factor로 만듬
grp <- factor(grp, levels = c("H","M","L"))   #level순서를 내가 정함. 안하면 R이 자동지정
myds <- data.frame(myds,grp)
head(myds)


#3단계 : 데이터셋의 형태와 기본적인 내용 파악
str(myds)
head(myds)
table(myds$grp)    #범주형에대한 도수분포표를 구함


#4단계 : 히스토그램에 의한 관측값의 분포 확인
par(mfrow = c(2,3))        #가상화면 만들기 (몇개의 계층으로 몇개할래? )
for (i in 1:5) {           #5개 변수만큼. 아니면 ncol로 해도된다. 
     hist(myds[,i],
          main = colnames(myds)[i],
          col = "yellow")  
}
par(mfrow = c(1,1))        #가상화면 복귀 


#5단계 : 상자그림에 의한 관측값의 분포 확인과 이상치 확인
par(mfrow = c(2,3))      
for (i in 1:5) {            
  boxplot(myds[,i],
       main = colnames(myds)[i])  
}
par(mfrow = c(1,1)) 


#6단계 : 그룹별 관측값 분포 확인
boxplot(myds$crim~myds$grp, main = '1인당범죄율')      #그룹성격은 뒤에!!(grp)
boxplot(myds$rm~myds$grp, main = "방의 개수")


#7단계 : 다중 산점도를 통한 변수 간 상관 관계 확인
pairs(myds[,-6])


#8단계 : 그룹 정보를 포함한 변수 간 상관 관계 확인
point <- as.integer(myds$grp)
pairs(myds[,-6], pch = point,
      col = color[point])

#9단계 : 변수 간 상관계수 확인
cor(myds[,-6])
