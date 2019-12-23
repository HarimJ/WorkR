#
# 10일차
#
install.packages("tidyverse")
library(tidyverse)

dim(mpg)
str(mpg)
head(mpg)
View(mpg)

ggplot(data = mpg) +                               #ggplot은 꼭 2개의 함수를 써야한다. (ggplot, geom) 먼저는 기본, 다음은 그릴려는 그래프 함수. 두개는 꼭 + 로 연결한다. 
  geom_point(mapping = aes(x = displ, y = hwy))    #point는 산점도로 표시하라는 뜻, aes는 맵핑. 어디에 뭐를 넣어라 . 
 

month <- c(1,2,3,4,5,6)
rain <- c(55,50,45,50,60,70)
df <- data.frame(month, rain)
df

ggplot(df, aes(x = month, y = rain)) + geom_bar(stat = "identity",      #aes는 mapping지정하는 함수라서 ggplot에 써도 되고 geom에 써도 된다. 
                                                width = 0.7,            #stat는 어느 데이터(y)를 막대?로 쓸거냐, 넓이, 색.
                                                fill = "steelblue")     #identity는 고정값으로 y를, 막대 길이를 y값으로 정한다는 뜻

ggplot(df, aes(x = month, y = rain)) + geom_bar(stat = "identity",      #여기서 color는 꼭 변수 종류대로 값을 줘야 인식을 할 수 있다. 즉, "빨강", "초록" ,,, 이런식으로 !!
                                                width = 0.7,            
                                                fill = "steelblue") +
ggtitle("월별 강수량") +                                                                   #그래프 이름 정하기
theme(plot.title = element_text(size = 25, face = "bold", color = "steelblue")) +          #그래프 태마(형식), 글꼴크기, 글꼴, 색
labs(x = "월", y = "강수량") + coord_flip()                                                #x,y 좌표는 똑같은데 그냥 방향을 누운 방향으로.    


ggplot(iris, aes(x = Petal.Length)) + geom_histogram(binwidth = 0.5)    #binwidth는 y값의 count(한 블록) 기준. / 즉, 꽃잎의 단위를 0.5단위로 계산해라. 

ggplot(iris, aes(x = Sepal.Width, fill = Species, color = Species)) +   #색을 품종별로 지정.(fill = 품종 <- 막대 색. color = 막대 경계선 
  geom_histogram(binwidth = 0.5, position = "dodge") +                  #position = 막대를 어떻게 넣을지. 여기서는 막대를 품종별로 각각 그려라. 
  theme( legend.position = "top")                                       #그래프 테마, 위에다가 넣어라.// theme은 다르게 분리해 놓면 좋다. 


# ggplot2 Scatter Chart
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) + geom_point()    #geom에 아무것도 넣지 않으면 기본판이 나온다(점, 격자판)

ggplot(data = iris) + geom_point(mapping = aes(x = Petal.Length, y = Petal.Width))      #위에 것과 같은데 방식차이. 
                                                                                        #즉 꼭 필요한것은 data, mapping(x와 y)은 제일 기본 정보. 
# - 업그레이드 버전
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width, color = Species, shape = Species)) + geom_point( size = 3) +  #점모양,점 크기
  ggtitle("꽃잎의 길이와 폭") + 
  theme(plot.title = element_text(size = 25, face = "bold", color = "red")) 



# ggplot Box plot
ggplot(data = iris, mapping = aes(y = Petal.Length)) + geom_boxplot(fill = "yellow")    #boxplot은 가로가 아니라 범위 = y가 중요하니까 y만 지정도 ok.

ggplot(data = iris, mapping = aes(y = Petal.Length, fill = Species)) + geom_boxplot()   #종류별로 box그리기



# ggplot Line chart                  선그래프는 보통 시계열 그래프일때 많이 사용한다. 
year <- 1937 : 1960
cnt <- as.vector(airmiles)
df <- data.frame(year, cnt)
df
head(df)
ggplot(df, aes(x = year, y = cnt)) + geom_line(col = "red")



# ggplot 작성 graph 꾸미기(공통)
str(economics)

# 1. 사선(회기선? - abline)
ggplot(economics, aes(x = date, y = psavert)) +
  geom_line() + 
  geom_abline(intercept = 12.18671, slope = -0.0005444)       #intercept : y절편값,  slope : 기울기


# 2. 평행선 (주로 시계열 데이터 - hline/ vline)
ggplot(economics, aes(x = date, y = psavert)) + 
  geom_line() + 
  geom_hline(yintercept = mean(economics$psavert))            #평균값을 수평선 기준값으로 지정 


# 3.  수직선 (주로 시계열 데이터 - hline/ vline)
x_inter <- filter(economics, psavert == min(economics$psavert))$date    #filter로 행을 먼저 추출.// psavert의 최소값의 date 를 뽑아라   
ggplot(economics, aes(x = date, y = psavert)) + 
  geom_line() +
  geom_vline(xintercept = x_inter)                          


# 텍스트 추가
ggplot(airquality, aes(x = Day, y = Temp)) + 
  geom_point() + 
  geom_text(aes ( label = Temp, vjust = 0, hjust = 0))       #label = temp 면 기온으로 이름을 넣어라. // v,hjust는 글자(여기선 숫자) 위치



# 영역 지정 및 화살표 표시 및 글자넣기  - annotate는 개별로 layer넣기. 
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +                                                                                  # annotate는 지정범위 정하기. rect는 범위모양(네모) 
  annotate( "rect", xmin = 3, xmax = 4, ymin = 12, ymax = 21, alpha = 0.5, fill = "skyblue") +    # alpha는 투명도 조절 :  0.1 ~ 1 사이 . 1에 가까울수록 불투명
  annotate("segment", x = 2.5, xend = 3.7, y = 10, yend = 17, color = "red", arrow = arrow()) +   # 화살표 지정하기 (화살표 길이 정하기)
  annotate("text", x = 2.5, y = 10, label = "point")                                              #내용 입력하기. 글 추가 
    # annotate는 개별로 layer넣기. 




# treemap - 지도같은 사각형 그래프
install.packages("treemap")
library(treemap)

data(GNI2014)
dim(GNI2014)
str(GNI2014)
head(GNI2014)
View(GNI2014)

treemap( GNI2014, index = c("continent", "iso3"),   #계층구조 - 대륙 및에 iso(국가)로 나눠라. 
         vSize = "population",                      #타일크기 - 인구수로 
         vColor = "GNI",                            #타일컬러 - 색이 진할 수록 높고 연할수록 낮다. 
         type = "value",                            #타일컬러링 방법 - 색상의 형태는 숫자로? 해라. 
         bg.labels = "yellow",                      #레이블배경색 - 글씨 배경색
         title = "World's GNI" )                    #제목


# 다른 예시 
st <- data.frame(state.x77)
st <- data.frame(st, stname = rownames(st))
treemap(st, 
        index = c("stname"),
        vSize = "Area",
        vColor = "Income",
        type = "value",                             #색상의 형태는 숫자로? 해라.  
        title = "미국 주별 수입")



# 산점도에 Bubble 추가 (Bubble chart)
symbols( st$Illiteracy, st$Murder,              #원의 x,y 좌표
         circles = st$Population,               #원의 반지름
         inches = 0.3,                          #원크기 조절값
         fg = "white",                          #원 태두리 색
         bg = "lightgray",                      #월 바탕색
         lwd = 1.5,                             #원 테두리 선 두께
         xlab = "rate of Illiteracy",  
         ylab = "Crime(murder) rate",  
         main = "Illteracy and Crime") 
text(st$Illiteracy, st$Murder,                  #텍스트 출력, x,y좌표
     rownames(st),                              #출력할 text
     cex = 0.6, col = "brown")                  #폰트크기, 폰트컬러



#   https://www.r-graph-gallery.com/     <-  그래프 참고 사이트 (ggplot 기반)
#   https://ggplot2.tidyverse.org/index.html  <-  ggplot (등등) 참고 사이트




#ggplot 활용 예시 - 버블/  갭마인더
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)

# Interactive version
p <- data %>%
  mutate(gdpPercap=round(gdpPercap,0)) %>%
  mutate(pop=round(pop/1000000,2)) %>%
  mutate(lifeExp=round(lifeExp,1)) %>%
  
  # Reorder countries to having big bubbles on top
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  
  # prepare text for tooltip
  mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>%
  
  # Classic ggplot
  ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19), name="Population (M)") +
  scale_color_viridis(discrete=TRUE, guide=FALSE) +
  theme_ipsum() +
  theme(legend.position="none")
pp <- ggplotly(p, tooltip="text")
pp













