#
# 16일차
#
# 군집화 ( Clustering ) / 분류 ( Classification )
# 
# 군집화 ( Clustering ) : 주어진 대상 데이터들을 유사성이 높은 것끼리 묶어주는 기술( 군집, 범주, 그릅 )
# 
# k-means (평균) 군집화 알고리즘
# k-means : 데이터의 산점도를 그리고 내가 나누고 싶은 그릅의 수만큼 임의의 점을 찍고 산점도에 전체 점들과 내 임의의 점들의 거리를 계산한다. 
#           그리고 점들의 거리가 짧은 쪽으로 모여지면 다시 내 임의의 점을 그 모여진 데이터들의 중앙으로 옮긴다. 
#           그리고 다시 점들의 거리 계산 -> 점들 모임 -> 임의의점 다시 중앙으로 옮김 -> 반복 -> 점이 움직이지 않으면 그릅화 완성!

mydata <- iris[ , 1:4 ]    # 품종 제외
fit <- kmeans( x = mydata, center = 3)   # (center = 3) : 3개의 군집으로 나눠라 
fit

# fit 출력결과
#K-means clustering with 3 clusters of sizes 62, 50, 38      <-  3 개 군집에 속한 데이터 개수

#Cluster means:        <- 3 개 군집의 중심점 좌표
#  Sepal.Length Sepal.Width Petal.Length Petal.Width
#1     5.901613    2.748387     4.393548    1.433871                    
#2     5.006000    3.428000     1.462000    0.246000                  
#3     6.850000    3.073684     5.742105    2.071053               
#
#Clustering vector:        <- 각 데이터에 대한 군집번호
#[1] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#[71] 1 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 1 3 3 3 3 1 3 3 3 3 3 3 1 1 3 3 3 3 1 3 1 3 1 3 3 1 1 3 3 3 3 3 1 3 3 3 3 1 3
#[141] 3 3 1 3 3 3 1 3 3 1
#
#Within cluster sum of squares by cluster:
#  [1] 39.82097 15.15100 23.87947
#(between_SS / total_SS =  88.4 %)
#
#Available components:
#  
#  [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"    "size"         "iter"         "ifault"      
 
fit$cluster    # <- 각 데이터의 군집번호
fit$centers    # <- 각 센터의 좌표

library( cluster )  # 차원축소 후 군집 시각화 패키지
clusplot( mydata,       # 군집대상
          fit$cluster,  # 군집번호
          color = TRUE, # 원의 색
          shade = TRUE, # 원위 빗금표시 유무
          labels = 1,   # 관측값 출력 형태 (labels가 1이면 숫자 안나오고 2면 숫자 나오고)
          lines = 1)    # 중심선 연결 표시 (1 이면 선이 나오고 0이면 선이 안나옴)

subset( mydata, fit$cluster == 2 )   # 군집번호가 2번인 데이터만 추출


#
# 대상 데이터 표준화 후 군집화
#
#    데이터와 데이터의 거리를 계산할 때 발생하는 문제 
#    모든 변수가 거리 계산에 동등한 영향을 갖도록 하기 위해서 모든 변수의 자료 범위를 0 ~ 1 사이로 표준화한 후 거리 계산을 한다
#
#    ( x - min( A ) ) / ( max ( A ) - min ( A ) )
#    x : 변수 A의 임의의 관측값
#    max( A ), min( A )는 변수 A 관측값 중 최대/최소값
#    
#
std　<- function( x ) {
  return( ( x - min( x ) )/ ( max( x ) - min( x ) ) )
}
mydaya <- apply( iris[ , 1:4 ], 2, std )
fit <- kmeans( x = mydaya, center = 3 )
fit

#
# KNN ( K-Nearest Neighbor, K-최근접 이웃 ) 분류 알고리즘
#
library( class )
# 훈련용 / 테스트용 데이터 준비
tr.idx <- c( 1:25, 51:75, 101:125 )
ds.tr <- iris[ tr.idx, 1:4 ]    # 훈련용
ds.ts <- iris[ -tr.idx, 1:4 ]   # 테스트용 ( 훈련용 데이터가 아닌 데이터가 테스트용 데이터. 그래서 -tr.idx )
cl.tr <- factor( iris[ tr.idx, 5 ] )   # 훈련용 그룹정보
cl.ts <- factor( iris[ -tr.idx, 5 ] )  # 테스트용 그룹정보
pred <- knn( ds.tr, ds.ts, cl.tr, k = 3, prob = TRUE )   # k = 3 이면 3개를 체크해본다. 데이터 3개를 묶어서 각각 어느 그릅에 속한지 확인한다 / 
                                                         # k 값은 정해진게 아니다. 값을 계속 바꿔주면서 좀더 정확한 확률을 구한다 
pred                                                     # prob = T 여야만 많이 속한 그릅을 알려준다. 꼭 T
acc <- mean( pred == cl.ts ) 
acc
table( pred, cl.ts )


#
# 교차 검증방법 ( k-fold  cross validation ) - KNN 과 다르게 k 폴드는 검증하는 용도! 밑에 k값만 바꿔주면 된다! 
#
install.packages( "cvTools")
library( cvTools )

k = 10           
folds <- cvFolds( nrow( iris ), K = k )       # 폴드생성 //  iris 데이터를 가지고 훈련을 10번(k값)하겠다. K 는 훈련 횟수 정하기 

acc <- c()   # 폴드별 예측 정확도 저장용 벡터
for (i in 1:k) {
  ts.idx <- folds$which == i
  ds.tr <- iris[ -ts.idx, 1:4 ]
  ds.ts <- iris[ ts.idx, 1:4 ]
  cl.tr <- factor( iris[ -ts.idx, 5 ] )
  cl.ts <- factor( iris[ ts.idx, 5 ] )
  pred <- knn( ds.tr, ds.ts, cl.tr, k = 5)
  acc[ i ] <- mean( pred == cl.ts)
}
acc   # 폴드별 예측 정확도 (총 10번 돌려서 각각 나온 예측도)
mean( acc )  # 폴드평균 예측 정확도  (위에 예측도 10번의 평균을 낸 예측도)




