#
# 14일차
#
# 단순선형 회귀분석 ( simple linear regression analysis )
#
# 모델링 : 예측, 분류, 군집화
#        : 진짜 모델링이 필요한지 안한지 알아야한다. 그럴려면 정확한 데이터 분석이 꼭 필요하다. 
#
# Regression Equation (회귀식) : y = W x + b       <- 예측에 사용
# 
# 우리가 찾아야 하는것은 매개변수(계수) : W , b
# 예측하는데 사용한다. 
#
# < Modeling 과정 >
# 1. Model 선택 : 수식결정 -> ( 선형 방정식 선택 )
# 2. 실제 데이터 (훈련 데이터) 를 이용하여  W , b 값 (매개 값)을 결정  
#     ->  lm  함수 
# 3. 실제 데이터를 통한 예측 ( 예측은 훈련 데이터에 없는 새로운 데이터로 모델이 레이블을 추정하는 과정 )  
#     -> predict 함수 (예측!!)
# 4. ** Model 평가 **     
#     -> summary() : 결과 이해
#
# 회귀선에 오차( 선과 데이터 간에 간격차이 )가 적은 선을 찾는게 모델링의 핵심 / 성능
#
# Modeling : 현실 세계에서 일어나는 현상을 수학식으로 표현하는 행위
#
# 데이터 과학에서 
# 독립변수 x 를 설명변수 (explanatory variable), 특징 (feature)
# 종속변수 y 를 반응변수 (response variable), 레이블(label)
# x 가 입력되면 y를 맞추어야 하는 문제, y를 ground truth로 간주
#
#                              ( 훈련 data )
# 데이터 과학에서 Modeling이란 수집한 data를 이용하여 최적의 모델을 찾아내는 과정
#
# 회귀분석 (Regression Analysis)
#    관찰된 연속형 변수들에 대해 두 변수 사이의 모형을 구한 뒤 적합도를 측정해 내는 분석방법
#    시간에 따라 변화하는 데이터나 어떤 영향, 가설적 실험, 인과 관계의 모델링등의 통계적 예측에 이용될 수 있다.
#  
# 단순선형 회귀분석 ( simple linear regression analysis )
#    독립변수와 종속변수와의 관계가 선형으로 표현
#    하나의 독립변수를 다루는 분석방법
#
# 단순선형 회귀모델의 회귀식 : y = W x + b ( W , b 는 상수 )
#          W , b 는 어떻게 찾을 수 있을까?
#          x , y 로 구성된 data를 이용하여 w , b 를 찾아내는 모델
#


# 단순 회귀 분석 : 선형이 하나의 독립변수 / 예측 Model
# 주행거리와 제동거리 사이의 회귀모델
str(cars)
head(cars)

# 산점도를 통한 선형 관계 확인
plot(dist~speed, data = cars)        # dist와 speed 두 변수 중 어느게 반응인지 설명인지 찾아야 한다
plot(cars)

# 회귀모델 구하기, 
# = >  lm ( y ~ x , 훈련하는 데이터 셋 )  : 단순 회귀 분석 구하기  (회귀선 구하기)
# 종속(반응)변수 ~ 독립(설명)변수 순서로 지정
model <- lm(dist~speed, cars)        # y(dist) = W x(speed) + b      : 속도에 의해서 제동거리를 정한다. ( 그래프에 y 축이 거리. 우리는 x 값에 따른 거리를  본다 )
model
                                     
# 위에 코딩 결과 
# Call:
#   lm(formula = dist ~ speed, data = cars)
#
#   Coefficients:   <-  계수, 매개변수 
#       (Intercept)        speed  
# b값:  -17.579      w값:  3.932  
# y = 3.932 * x -17.579

abline(model)      # <-  회귀선 그리기


coef( model )                       # 매개변수(계수) - w,b 값 출력
cars
fitted( model )                     # 훈련 data 에 있는 샘플에 대한 예측값 
residuals( model )                  # 잔차 : 회귀선과 데이터(점들) 의 차이 값들 ( 오차 )
#  ↓ 잔차 제곱합을 평균제곱오차 ( MES - mean squared error )로 변환
deviance( model ) / length( cars$speed )


# 예측해보기 - 모델링 만들고 x 값 대입해보기  --> 훈련한 데이터 말고 다른 새로운 데이터를 가지고 시도해봐야한다
b <-  coef( model )[1]
w <-  coef( model )[2]

speed <- 21.5    # <-  cars에 없는 speed 값 을 대입해 보면서 예측값 구하기 
dist <- w * speed + b
dist  

# 모델이 맞는지 예측 정확도 확인해보기 ( predict )
df <- data.frame( speed = c( 21.5, 25.0, 25.5, 26.0, 26.5, 27.0, 27.5, 28.0 ) )     # y 값을 예측해봐야 하니까 x 값만 넣고 만들기
predict( model, df )  # 예측 수행 함수  <-  위에 ("dist <- w * speed + b") 코딩을 대신해서 쓸 수 있는 predict 함수
plot(df$speed, predict( model, df ), col = 'red', cex = 2, pch = 20 )    # 예측값 표시하기

abline(model)

# 정리
speed <-cars[ , 1 ]
pred <- w * speed + b   # 예측값 
pred

compare <- data.frame( pred, cars[,2], pred-cars[,2] )    # 전체 출력
compare

colnames(compare) <- c( '예상', '실제', '오차' )

head(fitted(model), 3)   # 예측
head(residuals(model),3) # 추정된 값과의 차이
head(compare, 3)

summary(model)
# 평균은클수록, 분산은 작을수록, 데이터 크기가 클수록 신뢰도가 커진다. -> t - 통계량 (t - statistics) / t - 값 (t - value)
# t - 값이 크면 대립가설에 대한 신뢰도가 강해진다.
# t - 값이 작으면 대랍가설에 대한 신뢰도가 약해진다.
# 데이터를 통해 '대립가설이 통계학적으로 유의미하다(가설이 맞다)' 라는 것을 중명하고 확인하는 작업을 t-검정 (t-test)라 한다.
#
# '귀무가설이 참이라고 가정했을 때, 표본으로 부터 얻어지는 통계치가 나타날(관측될) 확률' 을 계산하는데 이 때 계산된 확률값을  p값이라 한다.
# p 값이 매우 낮으면, 이러한 표본통계값은 우연히 나타나기 어려운 케이스이기 때문에, 우리는 귀무가설을 채택하지 않고 (기각하고), 대안적인 가설인 가설, 즉 대립가설을 채택한다. 
# p 값이 높으면 귀무, 낮으면 대립 채택. 보통 기준은 0.05
#
# (귀무가설은 무조건 옳다, 많다, 등등)
# (대립가설은 귀무가설이 틀렸을때 ? , 반대) 
# lm 은 기본적으로 대립가설을 채택하는 쪽으로 사용된다. ('두 변수에는 아무런 관계가 없다라'는 전제하에 )

 # summary 출력값
#Call:
#  lm(formula = dist ~ speed, data = cars)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-29.069  -9.525  -2.272   9.215  43.201 
#
#Coefficients:  
#          Estimate Std.  Error   t value  Pr(>|t|)    
#(Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#  speed         3.9324     0.4155   9.464 1.49e-12 ***     <-  '***' 은 speed가 dist에 영향을 많이 준다. ( * 이 많을수록 상관관계가 높다는 뜻. )
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 15.38 on 48 degrees of freedom
#Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
#F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12



# 예시 - cars
str( cars )
head( cars )
car_model <- lm( dist~speed, data = cars )     # lm(y~x, data set)
coef( car_model )
plot( car_model )
abline(car_model, col = 'red')
summary( car_model )     # summary 를 잘 보는게 중요하다 - p 값이 0.05보다 작으므로 유의미하다 라고 할수 있다. 즉, 상관이 있다. 귀무가설 채택



# 예시 - women
str( women )
head( women )
women_model <- lm( weight~height, data = women )
coef( women_model )
plot( women_model )
abline(women_model, col = 'red')
summary( women_model )    # 0.05 보다 작아서 통계적으로 유의미하다. 상관이 있다. 귀무가설 채택 



# cars 와 women 비교해보기

# cars
#Coefficients:
#          Estimate Std.   Error   t value  Pr(>|t|)    
#(Intercept) -17.5791     6.7584  -2.601   0.0123 *      <- ' 0.0123' : 데이터가 퍼져있다 // women  과 비교했을때 숫자가 높으므로 회기선 기준으로 보다 더 퍼져있다
#  speed         3.9324     0.4155   9.464 1.49e-12 ***


# women
#Coefficients:
#           Estimate Std.  Error  t value  Pr(>|t|)    
#(Intercept) -87.51667    5.93694  -14.74 1.71e-09 ***   <- '1.71e-09' : 데이터가 모여져 있다  // cars와 비교햇을 때 숫자가 더 낮으므로 보다 더 회기선 기준으로 모여있다
#  height        3.45000    0.09114   37.85 1.09e-14 ***



  #  !!!! ( p값을 보고)  x , y 가 서로 관련이 없으면,  예측 모델을 만들 필요가 없다. !!!!
 




