#
#장하림
#20191209 / 20191210
#

#문1)
#R에서 제공하는 mtcars 데이터셋에서 gear(기어의 수)에 대해 ggplot으로 막대그래프를 작성하시오. 
#단, 제목과 x축 레이블은 ‘기어의 수’, y축 레이블은 ‘빈도수’로 나타내시오.
library(tidyverse)

data("mtcars")
mt <- data.frame(mtcars)
ggplot(data = mt ) + geom_bar(mapping = aes(x = gear)) +
  labs(x = "기어의 수", y = "빈도수수")

#문2)
#R에서 제공하는 mtcars 데이터셋에서 cyl(실린더의 수)에 대해 막대 색이 초록색인 막대그래프를 ggplot으로 작성하시오.

ggplot(data = mt) + 
  geom_bar(mapping =aes(x = cyl), fill = "green" )

#문3)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 구간 간격이 5.0인 히스토그램을 ggplot으로 작성하시오.
ggplot(data = mt) +
  geom_histogram(mapping = aes(x = mpg ), binwidth = 5.0)


#문4)
#R에서 제공하는 trees 데이터셋의 Girth(나무 둘레)에 대해 ggplot으로 히스토그램을 작성하시오. 
#여기에서는 히스토그램의 제목, x축 레이블, y축 레이블을 한글로 표시하시오. (구간 간격은 3.0, 막대의 색은 steelblue로 한다.)
str(trees)
ggplot(data = trees) +
  geom_histogram(mapping = aes(x = Girth), binwidth = 3.0, fill = "steelblue") +
  labs(x = "나무 둘레", y = "빈도수")


#문5)
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)를 x축으로 하고, wt(중량)를 y축으로 하는 산점도를 ggplot으로 작성하시오. 
#(단, 점의 색은 gear의 수에 따라 다르게 표시한다.)
ggplot(data = mt) + 
  geom_point(mapping = aes(x = mpg, y = wt, color = gear))


#문6) 
#R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 ggplot으로 상자그림을 작성하되, 
#cyl(실린더 수)에 따라 그룹을 나누어 작성하시오.
str(mt)
cyl.1 <- as.factor(mt$cyl)
ggplot(data = mt, mapping = aes(y = mpg, fill = cyl.1)) + 
  geom_boxplot()

#문7) 
#다음은 2015년부터 2026년도까지의 예상 인구수 추계 자료이다. 연도를 x축으로 하여 ggplot으로 선그래프를 작성하시오.
year <- 2015:2026
ppl <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)
yp <- data.frame(year, ppl)
ggplot(data = yp) +
  geom_line(mapping = aes(x = year, y = ppl))


#문8)
#다음과 같이 데이터셋 us를 생성한 후 물음에 답하시오. 
#여기서 state.x77은 미국 50개 주의 통계정보가, state.division은 미국 50개 주의 지역 구분
#(예: 북부, 중부, 남부……) 정보가 저장된 데이터셋이다.

us <- data.frame(state.x77, state.division)

#(1) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 Population(인구수), 타일의 색은 Income(소득)으로 나타내고,각각의 타일에는 주의 이름을 표시하시오. 
#마지막으로 이 트리맵에서 관찰할 수 있는 것이 무엇인지 설명하시오
us
us <- data.frame(us, stname = rownames(us))
treemap(us, index = c("stname"), vSize = "Population" , vColor = "Income", type = "value")

    #인구수는 California가 가장 많고 다음으로는 New York이다. 수입이 가장 많은 주는 Arizona


#(2) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
#또한, 타일의 면적은 HS.Grad(고등학교 졸업률), 타일의 색은 Murder(범죄률)로 나타내고, 
#각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할 수 있는 것이 무엇인지 설명하시오.
treemap(us, index = c("stname"), vSize = "HS.Grad", vColor = "Murder", type = "value")
  
    #Utah가 가장 고등학교 졸업률이 높고, Georgia와 Alabama가 범죄율이 가장 높다. 


#(3) us 데이터셋에 대해 x축은 Income(소득), y축은 Illiteracy(문맹률), 원의 크기는
#Population(인구수), 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오. 
#또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.
symbols(us$Income, us$Illiteracy, circles = us$Population, bg = "green", xlab = "수입", ylab = "문맹률" )
text(us$Income, us$Illiteracy, rownames(us),cex = 0.6, col = "brown")

   #인구수는 뉴욕이 가장 많고, 수입은 Alska가 가장 높고 Mississippi가 가장 낮다. 문맹률은 Louisiana가 가장 높다.
   #그래프 모양이 음의 상관 관계 모습을 보이고 있다. 즉 수입이 많을 수록 문맹률은 떨어진다. 

#4) us 데이터셋에 대해 x축은 Illiteracy(문맹률), y축은 Murder(범죄률), 원의 크기는 Area(면적),
# 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오.
#또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.
symbols(us$Illiteracy, us$Murder, circles = us$Area, bg = "green", xlab = "문맹률", ylab = "범죄률")
text(us$Illiteracy, us$Murder, rownames(us), cex = 0.7, col = "brown")

   #면적은Alaska가 가장 크고, South Dakota가 문맹률과 범죄률이 가장 낮다. Louisiana가 문맹률이 가장 높고, 범죄률은
   #Alabama가 가장 높다. 
   #그래프 모양이 양의 상관 관계를 보이고 있다. 대체로 문맹률이 높을 수록 범죄률도 높다는걸 알수있다. 





