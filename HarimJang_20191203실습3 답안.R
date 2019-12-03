#
#장하림
#20191202/ 20191203

#문1) 
#어떤 학급의 성별이 다음과 같을 때 주어진 문제를 해결하기 위한 R 코드를 작성하시오.
#F F F M M F F F M M

#1. 위의 자료를 gender 벡터에 저장하시오.
gender <- c('F','F','F','M','M','F','F','F','M','M')
barplot(gn, main = 'Gender')

#2. gender에 있는 값들에 대해 도수분포표를 작성하여 출력하시오.
gender
gn <- table(gender)

#3. gender에 있는 값들에 대해 막대그래프를 작성하여 출력하시오.
barplot(gn, main = 'Gender')

#  강사님 답안
barplot( gender.table, main = 'Gender', xlab = '성별', ylab = '빈도' )


#4. gender에 있는 값들에 대해 원그래프를 작성하여 출력하시오.
pie(gn, main = 'Gender')


#문2)
#좋아하는 계절에 대한 조사 결과가 다음과 같을 때 주어진 문제를 해결하기 위한 R 코드를 작성하시오.
#여름 겨울 봄 가을 여름 가을 겨울 여름 여름 가을

#1. 위의 자료를 season 벡터에 저장하시오.
season <- c('summer','winter','spring','fall','summer','fall','winter','summer','summer','fall')

#2. season에 있는 값들에 대해 도수분포표를 작성하여 출력하시오.
sn <- table(season); sn

#3. season에 있는 값들에 대해 막대그래프를 작성하여 출력하시오.
barplot(sn, main = 'Season')

#  강사님 답안
barplot( season.table, main = '선호계절', xlab = '계절', ylab = '빈도' )


#4. season에 있는 값들에 대해 원그래프를 작성하여 출력하시오.
pie(sn, main = 'Season')


#문3)연속형 데이터의 일변량
#학생 A의 과목별 성적이 다음과 같을 때 각 문제를 해결하기 위한 R 코드를 작성하시오.

#KOR ENG ATH HIST SOC MUSIC BIO EARTH PHY ART
#90 	85 	73 	80 	 85  65    78  50    68  96

#1. 위 데이터를 score 벡터에 저장하시오(과목명은 데이터 이름으로 저장).
score <- c(90,85,73, 80, 85, 65,78,50,68,96)
names(score) <- c("KOR", "ENG", "ATH", "HIST", "SOC", "MUSIC", "BIO","EARTH","PHY", "ART")

#2. score 벡터의 내용을 출력하시오.
score

#3. 전체 성적의 평균과 중앙값을 각각 구하시오.
mean(score)
median(score)

#4. 전체 성적의 표준편차를 출력하시오.
sd(score)

###5. 가장 성적이 높은 과목의 이름을 출력하시오.
names(score)[which.max(score)]

#   강사님 답안
names( score[ score == max( score ) ] )

#6. 성적에 대한 상자그림을 작성하고, 이상치에 해당하는 과목이 있으면 출력하시오.
boxplot(score, main = 'Score')
#이상치는 NONE

#7. 다음 조건을 만족하는 위 성적에 대한 히스토그램을 작성하시오.
#(그래프 제목: 학생 성적, 막대의 색: 보라색)
hist(score, main = '학생 성적', col='purple', las = 0 )

#문4)
#R에서 제공하는 mtcars 데이터셋에 대해 다음 문제를 해결하기 위한 R코드를 작성하시오.

dim( mtcars )
str( mtcars )
head( mtcars )
tail( mtcars )
#위에 데이터자료의 분석을 먼저 해야한다. 왜? 자료의 유형(범주/일변/연속)에 따라 분석 방법, 그래프 
#종류가 달라지기 때문에 꼭 데이터 분석을 하기 전에 dataset 조사를 먼저 할것!!!!!

#1. 중량(wt)의 평균값, 중앙값, 절사평균값(절사범위: 15%), 표준편차를 각각 구하시오.
mtcars
mean(mtcars$wt)
median(mtcars$wt)
mean(mtcars$wt, trim = 0.15)
sd(mtcars$wt)

#2. 중량(wt)에 대해 summary( ) 함수의 적용 결과를 출력하시오.
attach(mtcars)
summary(wt)

#*****3. 실린더수(cyl)에 대해 도수분포표를 출력하시오.
cl <- table(cyl); cl
 
#   cly은 숫자형이지만 종류가 한정적이여서 범주형의 모습을 가진다. 
#   따라서 기본 조사를 할때 num이라고 나와서 무조건 연속형이라고 평균등을 구하면 의미가 없다. 
#   자료의 성격을 미리 확인하고 내가 뭘 알아낼 것인지 미리 파악하는게 중요***

#4. 앞에서 구한 도수분포표를 막대그래프로 출력하시오.
barplot(cl, main = 'cyl')
#   도수분포표는 빈도/개수를 파악할때 사용하는데 cyl이 num이라고 나와도 범주형의 성격을 가지고 있기
#   때문에 도수분포표를 만들고 그래프를 그림. 


#5. 중량(wt)의 히스토그램을 출력하시오.
hist(wt,main = 'wt')

#6. 중량(wt)에 대해 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는정보를 함께 출력하시오.)
boxplot(wt, main = 'WT')
boxplot.stats(wt)
     # 중량이 대략 평균 이하인 차량이 대체로 많은편이다.

#7. 배기량(disp)에 대한 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는 정보를 함께 출력하시오.)
boxplot(disp, main = 'DISP')
boxplot.stats(disp)
     # 배기량이 대략 중앙값이상인 차량이 대체로 많은편이다. 

#8. 기어수(gear)를 그룹 정보로 하여 연비(mpg) 자료에 대해 상자그림을 작성하고,
#각 그룹의 상자그림을 비교하여 관찰할 수 있는 것이 무엇인지 나타내시오.
boxplot(mpg~gear, main = 'gear/mpg')
detach(mtcars)
#mpg :1) 10 <  gear3 < 25
#     2) 15 <  gear4 < 40
#     3) 15 <= gear5 < 35
#중앙값 gear3 : 15 ~ 20
#       gear4 : 20 ~ 30
#       gear5 : 15 ~ 25
        # 기어수가 4인 자동차들이 대체로 연비가 높다.


