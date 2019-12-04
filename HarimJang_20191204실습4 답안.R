#
#장하림
#20191203/ 20191204
#
#문1)
#다음은 직장인 10명의 수입과 교육받은 기간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#수입과 교육기간 사이에 어떤 상관관계가 있는지 설명하시오.

#수입 	 121 99 41 35 40 29 35 24 50 60
#교육기간 19  20 16 16 18 12 14 12 16 17

Income <- c(121, 99, 41, 35, 40, 29, 35, 24, 50, 60)
Edu <- c(19 , 20, 16, 16, 18, 12, 14, 12, 16, 17)

plot(Edu~Income, main = "Income  & Edu",
     xlab = '수입', ylab = '교육기간', col = "gray", pch = 8)

Idu <- data.frame(Income, Edu)

res <- lm(Edu~Income, data = Idu); res

abline(res)
cor(Income, Edu)

#상관계수가 0.79로 0.5보다 높아 상관 관계가 높다는것을 알 수 있다. 
#교육기간이 길수록 수입이 많은 편이다. 

#문2)
#다음은 대학생 10명의 성적과 주당 TV 시청시간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#성적과 TV 시청시간 사이에 어떤 상관관계가 있는지 설명하시오.

#성적 	 77.5 60 50 95 55 85 72.5 80 92.5 87.5
#시청시간 14   10 20  7 25  9 15   13  4   21

score <- c(77.5, 60, 50, 95,55, 85, 72.5, 80, 92.5, 87.5)
TV <- c(14,10, 20, 7, 25,  9, 15,13, 4,21)

plot(score~TV,main = 'TV시청 시간과 성적의 관계',
     xlab = '성적', ylab = 'TV시청시간', col = 'orange', pch = 12)

st <- data.frame(score,TV)

r <- lm(score~TV, data = st);r
abline(r)
cor(score, TV)

#상관계수가 -0.62로 음의 상관관계가 비교적 높은것을 알수 있다. 
#즉, TV시청 시간이 길어질 수록 성적은 낮아지는 결과를 알수있다. 

#문3) 
#R에서 제공하는 mtcars 데이터셋에서 mpg와 다른 변수들 간의 상관계수를 구하시오.
#어느 변수가 mpg와 가장 상관성이 높은지 산점도와 함께 설명하시오.			
mtcars
str(mtcars)
pairs(mtcars, main = 'mtcars')

cor_mpg <- cor(mtcars)[-1,'mpg']
cor_mpg
a <- abs(cor_mpg)
names(cor_mpg)[which.max(a)]
#wt가 mpg와 -0.86으로 음의상관관계가 가장 높다. 

####강사님 답안
head( mtcars )

cor( mtcars )
cor( mtcars )[ 1, ]   # <- ?? 



#문4)
#다음은 2015년부터 2026년도까지의 예상 인구수 추계자료이다. 연도를 x
#축으로 하여 선그래프를 작성하시오.
#이런 데이터가 시계열 데이터/

#연도		총인구 (천명)		연도		총인구 (천명)
#2015		51014				2021		52123
#2016		51245				2022		52261
#2017		51446				2023		52388
#2018		51635				2024		52504
#2019		51811				2025		52609
#2020		51973				2026		52704

year <- c(2015:2026)
population <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)

plot(year~population,main = "인구수 추계자료",
     type = 'l', lty = 1, lwd = 4, xlab = '연도',ylab = '인구수')


#문5)
#R에서 제공하는 trees 데이터셋에 대해 다음 문제를 해결하기 위한 R 코드를 작성하시오.
trees
str(trees)
head(trees)
tail(trees)

#(1) 나무의 지름(Girth)과 높이(Height)에 대해 산점도와 상관계수를 보이시오.
tbl <- data.frame(trees$Girth, trees$Height)
tbl

plot(trees.Girth ~ trees.Height, data = tbl, main = '지름과 높이')
ree <- lm(trees.Girth ~ trees.Height, data = tbl)
abline(ree)
cor(trees[,1:2])
#또는 
cor( trees$Girth, trees$Height )

#(2) trees 데이터셋에 존재하는 3개 변수 간의 산점도와 상관계수를 보이시오.
pairs(trees)       #plot(trees)도 가능. 
cor(trees)






