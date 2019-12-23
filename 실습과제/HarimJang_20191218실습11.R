#
# 장하림
# 20191218 / 20191218
#

#문1)
#R에서 제공하는 state.x77 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
#
#• 군집의 수는 5로 한다.
#• state.x77은 각 변수(열)의 값들의 단위의 차이가 많이 나기 때문에 0~1 표준화를 실시한 후 군집화를 실행한다.

# 군집화
data <- data.frame(state.x77)
fit <- kmeans( x = data, center = 5 )
fit

# 표준화
st <- function( x ){
  return( ( x - min( x ) ) / (max( x ) - min( x ) ) )
}

data <- apply( data, 2, st)
fit <- kmeans( x = data, center = 5 )
fit

# 그래프 그리기
library( cluster )
clusplot( data, fit$cluster, color = T, shade = T, labels = 1, lines = 1)


#문2)
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
#
#• 군집의 수는 2로 한다.
#• Sonar 데이터셋에서 마지막에 있는 Class 열은 제외하고 군집화를 실행한다.
#

library( mlbench )
data( "Sonar" ) 			# 데이터셋 불러오기
head( Sonar )

mydata <- Sonar[ , -61]
head(mydata)

fit2 <- kmeans( x = mydata, center = 2 )
fit2

clusplot( mydata, fit2$cluster, color = T, shade = T, labels = 2, lines = 1)


#문3) 
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.
#
#. Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
#. Sonar 데이터셋에서 홀수 번째 데이터(관측값)를 훈련용 데이터로 하고, 짝수번째 데이터(관측값)를 테스트용 데이터로 한다.
#. k-최근접 이웃에서 k를 3, 5, 7로 다르게 하여 예측 정확도를 비교한다.

library( class )
t <- (seq(2, nrow(Sonar),2))
tr <- Sonar[-t, 1:60 ]   # 훈련용
ts <- Sonar[t, 1:60 ]    # 테스트용
cl.tr <- factor( Sonar[ -t, 61 ] )
cl.ts <- factor( Sonar [ t, 61 ] )
pred <- knn( tr, ts, cl.tr, k = 7, prob = T )
pred
acc <- mean( pred == cl.ts )   
acc
table( pred, cl.ts )

# k = 3 일때 : acc =  0.83
# k = 5 일때 : acc =  0.75
# k = 3 일때 : acc =  0.71

#문4) 
#mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.

#. Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
#. k-최근접 이웃에서 k는 3으로 한다.
#. 5-fold 교차 검증 방법으로 예측 정확도를 측정한다.

library( cvTools )

k = 5
folds <- cvFolds( nrow( Sonar ), K = k)

acc <- c()
for (i in 1:k) {
  t <- folds$which == i
  ds.tr <- Sonar[-t, 1:60]
  ds.ts <- Sonar[t, 1:60]
  cl.tr <- factor(Sonar[-t, 61])
  cl.ts <- factor(Sonar[t, 61])
  pred <- knn( ds.tr, ds.ts, cl.tr, k = 3)
  acc[i] <- mean(pred == cl.ts)
}
acc
mean(acc)
# mean(acc) : 0.8894309 (89%)







