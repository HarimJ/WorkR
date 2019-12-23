#
# 장하림
#
# 20191217/ 201912/17
#
#문1)
#trees 데이터셋에 대해 다음의 문제를 해결하는 R 코드를 작성하시오.

#(1) 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하는 다중선형 회귀 모델을 만드시오.
str(trees)
trees_model <- lm(Volume~Girth + Height, data = trees )
trees_model

#(2) 다중선형 회귀모델을 이용하여 trees 데이터셋의 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하시오.
newdata_t <- data.frame(rbind(trees[,1:2]))
names( newdata_t ) <- names(trees)[1:2]
newdata_t
trees_pred <- predict( trees_model, newdata_t )

#(3) (2)에서 예측한 볼륨과 실제 trees 데이터셋의 볼륨(Volume)이 얼마나 차이가 나는지 보이시오. (예측값, 실제값, 예측값-실제값을 나타낸다.)
fitted( trees_model )
trees_pred
residuals( trees_model )

deviance( trees_model )
summary( trees_model )

#문2)
#mtcars 데이터셋에서 다른 변수들을 이용하여 연비(mpg)를 예측하는 다중 회귀모델을 만드시오.

#(1) 전체 변수를 이용하여 연비(mpg)를 예측하는 회귀모델을 만들고 회귀식을 나타내시오.
str(mtcars)
mt_model <- lm(mpg~., data = mtcars)
mt_model
summary(mt_model)

#(2) 연비(mpg)를 예측하는 데 도움이 되는 변수들만 사용하여 예측하는 회귀모델을 만들고 회귀식을 나타내시오.
library(MASS)
mt_model2 <- stepAIC( mt_model )
summary( mt_model2 )

#(3) (1), (2)에서 만든 예측모델의 설명력(Adjusted R-squared)을 비교하시오.
# mt_model (전체 데이터)는 설명력이 0.8066으로 약 81%였는데 mt_model2 (도움되는 변수들)는 설명력이 0.8336으로 약 83%로 증가했다


#문3) 
#UCLA 대학원의 입학 데이터를 불러와서 mydata에 저장한 후 다음 물음에 답하시오.

mydata <- read.csv( "https://stats.idre.ucla.edu/stat/data/binary.csv" )
View(mydata)
str(mydata)
head(mydata)

#(1) gre, gpa, rank를 이용해 합격 여부(admit)를 예측하는 로지스틱 모델을 만드시오(0: 불합격, 1:합격).
data.new <- mydata
data.new$admit <- as.integer( data.new$admit )
head(data.new)

my_model <- glm(admit~gre + gpa + rank, data = data.new )
my_model
coef(my_model)
summary( my_model )

un <- data.frame(rbind(mydata[, 2:4]))
names(un) <- names(mydata)[2:4]
un

pred_m <- predict( my_model, un )
pred_m <- round(pred_m, 0 )
pred_m
# levels(mydata$admit)[pred_m]    <-  ? NULL ? 

# ?? (2) mydata에서 합격 여부(admit)를 제외한 데이터를 예측 대상 데이터로 하여 (1)에서 만든 모델에 입력하여 합격 여부를 예측하고 실제값과 예측값을 나타내시오.
fitted(my_model)
mydata$admit
residuals(my_model)

#(3) 만들어진 모델의 예측 정확도를 나타내시오.
answer <- as.integer( mydata$admit )
pred_m == answer
acc <- mean( pred_m == answer)
acc

# 71%

# 3번에 2번 ( 예측값, 실제값 구별 - 정확하게 어떤건지 ? 정리 )
# 예시 ) compare <- data.frame( pred, cars[,2], pred-cars[,2] )  <- 예측, 실제, 오차( 예측 - 실제 )
# residual 함수는 실제 값과 예측과 얼마나 차이나는지 알려주는것. 즉 예측값에서 얼마를 더해야 (?) 실제값이 되는 지 알려준다... (실제 - 예측)

