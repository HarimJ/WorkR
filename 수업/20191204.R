#
#7일차
#
#vector의 결측치 처리
z <- c(1,2,3,NA,5,NA,8)
sum(z)
is.na(z)
sum(is.na(z))
sum(z,na.rm = TRUE)

#결측치 대체및 제거
z1 <- z
z2 <- c(5,8,1, NA, 3, NA, 7)

#단순대입법
z1[is.na(z1)] <- 0                 #z1에 NA를 0으로 대체하고 출력
z1
#Listwise deletion - 결과 잘 생각하고 지우기
z3 <- as.vector(na.omit(z2))       #z2에 NA를 지우고 z3에 벡터로 변환
z3

#Matrix / Data Frame 결측치 처리
x <- iris
x[1,2] <- NA
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA
head(x)

# Matrix/ Data Frame 열(변수)별 결측치 확인
#1. for문 이용
for (i in 1:ncol(x)) {            #1부터 열변수 수만큼 반복해라
  this.na <- is.na(x[,i])         #i는 열지정(변수지정)후 결측지를 this.na에 대입
  cat(colnames(x)[i],             
      "\t", sum(this.na),
      '\n')
}

#2. apply() 이용
col_na <- function(y){        #함수를 먼저 만들고 이름지정
  return(sum(is.na(y)))
}
na_count <- apply(x, 2, col_na)   #각 열의 결측지 수
na_count
# 또는 이런 방법
na_count <- apply(x, 2, function(y) sum(is.na(y)))   #익명함수(이름이 없는 함수)
na_count


barplot(na_count[na_count > 0])   #결측치가 있는 것만 막대그래프를 그려라
install.packages("VIM")
require(VIM)

#결측치 자료 조합 확인용 시각화 도구
aggr(x,prop = FALSE, numbers = TRUE)
      # Combinations그래프에서 147이 결측치가 없는 데이터들 수. 
          
#두개의 변수간의 결측치 관계 확인 시각화 도구
marginplot(x[c("Sepal.Width","Sepal.Length")],
           pch = 20, col = c("darkgray","red","blue"))
      #빨간색 점이 결측치/ 회색은 그냥 데이터. 
 

#Matrix / Data Frame의 행(data)별 결측치 확인
rowSums(is.na(x))
sum(rowSums(is.na(x)) > 0)    #결측치가 포함되어 있는 행의 수

sum(is.na(x))                 #결측지 합

#결측치를 제외한 새로운 데이터셋 생성
head(x)
x[!complete.cases(x),]     #NA가 포함되 출력
y <- x[complete.cases(x),]
head(y)

#특이값, 이상치(outlier)
st <- data.frame(state.x77)
summary(st$Income)
boxplot(st$Income)
boxplot.stats(st$Income)$out     #이상치 알기

#특이값 처리 : NA로 변환 후 결측치 처리방법 이용
out.val <- boxplot.stats(st$Income)$out
st$Income[st$Income %in% out.val] <- NA    #%in% 포함유무 인수(포함되어있다면)
head(st)
newdata <- st[complete.cases(st),]         #결측치가 포함된 행을 지우고 저장  
head(newdata)

#
#데이터 가공
#
#데이터 정렬
#Vector 정렬
v1 <- c(1,7,6,8,4,2,3)
order(v1)             #matrix나 frame에 순서를 정하는 함수? 그 데이터가 전체 몇번째이냐.. 
v1 <- sort(v1)
v1
v2 <- sort(v1, decreasing = T)
v2

#Matrix/ Data Frame 정렬
head(iris)                 #맨 앞 1,2,3,4...는 입력순서
order(iris$Sepal.Length)   # 나오는 숫자의 뜻 : 첫번째 행이 전체에서 14번째 행이다. 
iris[order(iris$Sepal.Length),]                     #Ascending  // Sepal.Length기준으로 정리했을때 14번째행이다. 
iris[order(iris$Sepal.Length, decreasing = T),]     #Descending // 
iris.nes <- iris[order(iris$Sepal.Length),] 
head(iris.nes)
iris[order(iris$Species, decreasing = T, iris$Sepal.Length), ] #정렬기준을 2개설정 // 같으면 Sepal.Length기준으로 해라


#데이터 분리
sp <- split(iris, iris$Species)      #split - iris에서 품종별(species)로 나눠서 sp에 담음 (list로 만듬)
sp
summary(sp)
summary(sp$setosa)
sp$setosa

#데이터 선택
subset(iris, Species == "setosa")
subset(iris, Sepal.Length > 7.5)
subset(iris, Sepal.Length > 5.1 & Sepal.Width > 3.9)
subset(iris, Sepal.Length > 7.6, select = c(Petal.Length, Petal.Width))


#데이터 Sampling
#숫자를 임의로 추출 (vector) 
     #- 일부 자료만 추출해서 먼저 해보기 (너무 많은 변수들이 있으면 이렇게 시도해본다)
     #비복원 추출 - 이미 했던 샘플링을 다음번 샘플링에는 넣지 않고 버리기
     #복원 추출 - 했던 샘플링을 다시 넣고 샘플링 추출. 그럼 같은 자료가 겹쳐서 나오기도 함
x <- 1:100
y <- sample(x,size = 10, replace = FALSE) #replace 가 false면 비복원 추출
y

#행을 임의로 추출
idx <- sample(1:nrow(iris), size = 50, replace = FALSE)    #샘플링대상, 샘플링수, 샘플링방법
iris.50 <- iris[idx,]
dim(iris.50)
head(iris.50)

sample(1:20, size = 5)    #복원추출해서 데이터가 매번 다르게 나오지만 겹쳐서 나온다. 
sample(1:20, size = 5)
sample(1:20, size = 5)

set.seed(100)           #set.seed(임의) :같은 값을 보여준다. 동일한 값을 원하면 이걸 사용한다. 
sample(1:20, size = 5)
set.seed(100)
sample(1:20, size = 5)
set.seed(100)
sample(1:20, size = 5)

#데이터 조합
combn(1:5, 3)     #combination(조합) - 조합할 수의 범위, 조합할 수의 개수(임의의 수 3개를 뽑는다)
                  #                  - 3수를 뽑는 조합/ 10개를 추출한건 R이 자동으로 뽑은것. 

x = c("red", "green", "blue", "black","white")
com <- combn(x,2)   #2개를 뽑겠다. 2개를 뽑는 조합을 com에다 담겠다.즉, 변수가 조합.  
com

for(i in 1:ncol(com)){
  cat(com[ , i], "\n")
}


#데이터 집계 - aggregate
agg <- aggregate(iris[,-5], by = list(iris$Species), FUN = mean)
agg   #aggregate는 집계함수. iris에서 품종빼고 집계, 품종으로 나열해라. 평균을 구핼. 

agg <- aggregate(iris[,-5], by = list(iris$Species), FUN = sd)
agg         

head(mtcars)
agg <- aggregate(mtcars, by = list(cyl = mtcars$cyl, vs = mtcars$vs), FUN = max)
agg


#데이터 병합 - merge
x <- data.frame(name = c("a","b","c"), mat = c(90,80,40))
y <- data.frame(name = c("a","b","d"), korean = c(75, 60, 90))
z <- merge(x,y,by = c("name"))      #merge : 병합한다. 공통변수는 생략한다
z                                   #merge는 공통된 내용만 통합해 출력한다

merge(x,y)
merge(x,y,all.x = T)   #x 기준으로 같은변수와 x를 준다.  - 변수추가(가로가 늘어남)
merge(x,y,all.y = T)   #y 기준으로 같은변수와 y를 준다.  - 변수추가(가로가 늘어남)
merge(x,y, all = T)    #공통내용과 모든 x,y를 출력 (NA로) - 단순통합/ 데이터추가(세로가 늘어남)

x <- data.frame(name = c("a","b","c"), mat = c(90,80,40))
y <- data.frame(sname = c("a","b","d"), korean = c(75, 60, 90))
merge(x, y, by.x = c("name"), by.y = c("sname"))

#
#dplyr package
#
install.packages("dplyr")
library(dplyr)

#%>% : pipe 연산자. (ctrl + shift + M)

df <- data.frame(var1 = c(1,2,1), var2 = c(2,3,2))
df

#rename(): 이름 변경
df <- rename(df, v1 = var1, v2 = var2)
df

#파생변수 추가
df$sum <- df$v1 +df$v2    #df안에 sum이라는 변수를 추가하는것
df

df[2,1] <- 5
df


df <- data.frame(id = c(1,2,3,4,5,6), class = c(1,1,1,1,2,2), math = c(50,60,45,30,25,50),
                 english = c(98,97,86,98,80,89), science = c(50,60,78,58,65,98))
df

#filter() : 행 추출 !!! 행!!!
df %>% filter(class == 1)    #df를 파이프(pipe)
df %>% filter(class == 2)
df %>% filter(class != 1)
df %>% filter(class != 2)

df %>% filter(science >70)
df %>% filter(math < 50)

df %>% filter(class == 1 & math >= 50)
df %>% filter(math >= 50 | english >= 90)
df %>% filter(class %in% c(1,3,5))     #class에 1,3,5 포함된걸 추출해라. 여기서는 3,5반이 없으니까 1반만 출력 

#split과 비슷하게 분리한 상태/ 별도의 데이터프레임으로 만들수 있다 (split은 리스트로 출력) 
class1 <- df %>% filter(class == 1)
class2 <- df %>% filter(class == 2)
class1
class2

#subset은 함수고/ pipe는 계속해서 연결해주는 연결기능!!! 연결이 최고야최고
#한문장으로 연결해주는 pipe 


#select() : 변수 추출 !!!변수!!!
df %>% select(math)
df %>% select(science)
df %>% select(class, math, science)
df %>% select(-math)

#dplyr 함수 조합
df %>% 
  filter(class == 1) %>% 
  select(science)

df %>% 
  select(id, science) %>% 
  head

df %>% 
  select(id, science) %>% 
  sum

df %>% 
  select(id, science) %>% 
  max

# arrange() : 정렬
df %>% arrange( science)        #기본 오름차순
df %>% arrange(desc(science))   #desc : 내림차순 


#mutate() :  파생변수 추가
df %>% 
  mutate(total = math + english + science) %>% 
  head


df %>% 
  mutate(total = math + english + science, 
         average = (math + english + science) / 3) %>% 
  head


df %>%  mutate(grade = ifelse(science >= 60, 'pass', 'fail')) %>% 
  head


df %>% 
  mutate(total = math + english + science, 
         average = (math + english + science) / 3) %>% 
  mutate( grade = ifelse(average >= 90, 'pass', 
                         ifelse(average < 60, 'fail',
                                'normal'))) %>% 
  head


df %>% 
  mutate(total = math + english + science, 
         average = (math + english + science) / 3) %>% 
  arrange(desc(average)) %>% 
  head



#sort를 하면 입력순서가 바뀐다. 그럼 나중에 입력순서를 모를수도 있다. 
#그래서 다른 변수에다가 따로 순서바꾼걸 저장하면 된다. (if you need)
df.sort <- df %>% 
  mutate(total = math + english + science, 
         average = (math + english + science) / 3) %>% 
  arrange(desc(average)) %>% 
  head
df.sort


#summarise () : 집단별 요약
#group_by () : 집단별 나누기
#
df %>% summarise( mean_math = mean(math))

df %>% 
  group_by(class) %>%          #같은 class를 묶음 
  summarise(mean_math = mean(math),
            mean_english = mean(english),
            mean_science = mean(science),
            n = n())           #n = 빈도수를 계산하는 함수. (table과 비슷)
#     출력결과에 <db>는 더블, 즉 숫자라는 뜻 


install.packages("ggplot2")
str(ggplot2 ::mpg)   #패키지명 :: 데이터셋이름 = :: 하면 library필요없이 바로 불러쓰겠다. 
mpg <- data.frame(ggplot2 :: mpg)
dim(mpg)
str(mpg)
head(mpg)
View(mpg)    #전제 데이터를 엑셀 시트처럼 보여준다. *주의* v는 꼭 대문자 V

mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise( mean_cty = mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer, drv) %>% 
  filter(class == 'suv') %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

#데이터 합치기
#left_join() : 가로로 합치기 (변수추가)
#inner_join() : 가로로 합치기 (변수추가)
#full_join() : 가로로 합치기 (변수추가)
#bind_rows() : 세로로 합치기 (data 추가)
df1 <- data.frame(id = c(1,2,3,4,5),
                  midterm = c(60, 80,70,90,85))
df2 <- data.frame(id = c(1,2,3,4,5),
                  final = c(60, 80,70,90,85))
total <- left_join(df1,df2,by = 'id')
total

df1 <- data.frame(id = c(1,2,3),
                  address = c("서울","부산","제주"),
                  stringsFactors = F)      #stringFactor=F이면 factor로 변하는걸 막아주는 함수. 
df2 <- data.frame(id = c(1,2,4),
                  gender = c("남","여","남"))
df_left <- left_join(df1,df2, by = 'id')     #둘중 왼쪽, df1기준으로 추가
df_left

df_inner <- inner_join(df1,df2, by = 'id')   #둘중 공통된것만 추가(merge랑 같음)
df_inner

df_full <- full_join(df1,df2, by = 'id')     #둘다 출력
df_full


df1 <- data.frame(id = c(1,2,3,4,5),
                  test = c(60, 80,70,90,85))
df2 <- data.frame(id = c(1,2,3,4,5),
                  test = c(60, 80,70,90,85))
df_all <- bind_rows(df1,df2)                 #세로로 합치기.둘다 출력. (행 추가)
df_all


install.packages("psych")     
library(psych)

summary(mtcars)
describe(mtcars)     #summary 함수랑 비슷. describe가 더많은 내용을 보여준다. 
                     #n = 관측치...기타등등. 찾아보기

install.packages("descr")
require(descr)

df <- data.frame(id = c(1,2,4),
                  gender = c("남","여","남"))
table(df$gender)     #table은 도수분포표. 
freq(df$gender)      #도수분포 + 막대그래프까지 동시에 실행. // descr패키지에 있다. 
freq(df$gender, plot = F)   #plot = F 하면 막대그래프 안나옴. 
