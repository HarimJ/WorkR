#
# 15일차
#
# 다중선형 회귀분석 ( Multiple linear regression analysis )
#
# 다중선행 회귀모델 : 여러개의 독립변수를 다루는 회귀모델
#
# 회귀식
# y = B0 + B1X1 + B2X2 + B3X3 + ... +BnXn
#
# 독립변수가 n개인 다중선형 회귀에서 주어진 자료를 이용해 B1, B2, B3, ... , Bn 의 값을 알아내는 회귀모델
#
install.packages("car")

library( tidyverse )
library( car )

str( Prestige )
head( Prestige )

newdata <- Prestige [ , c( 1:4 )]
head( mewdata )
plot( newdata, pch = 16, col = 'blue', main = 'Matrix Scatterplot' )

model <- lm( income ~ education + prestige + women, data = newdata )     # lm( 종속변수(y)~독립변수(x) + 독립변수(x) + 독립변수(x), 훈련 DATA ) : 다중선행 B들 구하기
model
coef    # <-  결과에 Intercept 에 나오는 수가 B0 ( 단순선행식에서의 b )
# 회귀식: y = B0 + B1X1 + B2X2 + B3X3
# income = (-253.8) + ( 177.2 *newdata$education ) + ( 141.4 * newdata$prestige ) + ( -50.9 * newdata$women ) 

fitted( model )
residuals( model )

# <선형 회귀분석>
# 1. Model 결정
# 2. 계수 결정 ( 회귀식 완성 ) <- 훈련DATA 사용 (x,y) // 가설 검정을 해야한다 (summary() 를 사용해서), 안맞을 경우 독립변수(x)를 다시 설정
# 3. 예측 <- Test DATA (x 값만) 
# 4. 실제값으로 예측

deviance( model )  # 잔차
deviance( model ) / length( newdata$education )  # 평균 제곱 오차차
summary( model )
# 여기서는 prestige 와 women 만 ***을 받아 관련성이 높다
# Adjusted R-squared = 설명력 <- ( 0 ~ 1값중 1에 가까워질수록 현실 설명력이 높다 :  예측값의 실제값 오차가 작아질 가능성이 높다 )      
 
newdata2 <- Prestige[ , c( 1:5 ) ]
model2 <- lm( income~., data = newdata2 )    # lm(y~.) : 안에 있는 변수 다 사용하기 (y 값 제외)
summary( model2 )

library( MASS )
model3 <- stepAIC( model2 )  # setpAIC() : 각 독립변수들에 영향력이 적은걸 자동으로 제거해서 결과를 도출해 주는 함수 
summary( model3 ) # 영향력 낮은설 제외하고 높은것만 도출 
                  # model2 보다 model3의 Adjusted R-squared 값이 더 높아졌다. 즉 영향력이 높은것만 추출하면 설명력이 높아지니 영향력 낮은건 빼주자 


#
# Logistic Regression ( 로지스틱 회귀분석 )
#      회귀모델에서 종속변수의 값의 형태가 범주형인 경우 예측모델
#
#      주어진 data로부터 어던 범주를 예측하는 분야를 회귀와 구분하여 분류(calssification) 이라고 한다.
#
#      로지스틱 회귀도 기본적으로 회귀 기법이기 때문에 종속변수는숫자로 표현되어야 한다.
#      예) YES 와 NO 는 0 과 1로 setosa, versicolor, virginica 는 1, 2, 3과 같은 숫자로 바꾼 후에 로지스틱 회귀 적용
#
# **** 로지스틱에서는  y 값이 범주형이여야만 한다. ( 리니어와 차이점 ) *********

iris.new <- iris
iris.new$Species <- as.integer( iris.new$Species )   # 범주형을 숫자형으로 변환
head( iris.new )

iris_model <- glm( Species~., data = iris.new )     # glm() : 로지스틱 에서 사용하는 (lm) // lm과 같은 기능
iris_model
coef( iris_model )
summary( iris_model )

# one-hot encoding....? (0과 1로 바꿔라)
unknown <- data.frame( rbind(c( 5.1, 3.5, 1.4, 0.2 )))
names( unknown ) <- names( iris )[1:4]
unknown

pred <- predict( iris_model, unknown )
pred 
pred <- round( pred, 0 )       # 반올림.....
levels( iris$Species )[pred]   # <- 1번에 해당하는 꽃종류 이름

#-----------------------
test <- iris[ , 1:4 ]

pred <- predict( iris_model, test )
pred <- round( pred, 0 )

answer <- as.integer( iris$Species )
pred == answer      # 맞는지 안맞는지 확인
acc <- mean( pred == answer )
acc     # 예측 성공률 (97%)




