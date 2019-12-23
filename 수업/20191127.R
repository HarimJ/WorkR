#
# break/next 
#
sum <- 0
for (i in 1:10) {
  sum <- sum + i
  if (1 >= 5) {
    break      #반복을 빠져나가라 
  }
}
sum

sum <- 0
for (i in 1:10) {
  if (i %% 2 == 0) {
    next       #다시 반복제어문으로 (위로)돌아가라/ 즉 짝수는 빼라. 그 다음 반복문을 써라.  
  }
  sum <- sum + i
}
sum

#
#산술 내장 함수

log(10) + 5       #로그함수//return값에 5를 더해라
log(10, base = 2)  
sqrt(25)          #제곱근
max(5,3,2)        #가장 큰 수
min(3,9,5)        #가장 작은 수
abs( -10 )        #절대값
factorial(5)      #팩토리얼
sin( pi / 2 )     #삼각함수

#
# 사용자 정의 함수
#
mymax <- function(x,y) {        #함수정의
  num.max <- x
  if ( y > num.max) {
    num.max <- y
  }
  return (num.max)
}
mymax(10, 15)                   #함수호출
a <- 10
b <- 15
c <- 8
max <- mymax(a,b)
max <- mymax(max, c)
max


#사용자 정의 함수 매개변수 초기값 설정
mydiv <- function(x,y = 2) {           #y에 기본값으로 2를 정의한다./ 만약 y값이 안들어오면 기본값을 사용하겠다는 의미.// 지정하고 싶은 수는 항상 오른쪽에 지정해야한다. (x말고 y에)
 result <- x/y  
  
  return(result)
}

#다양한 호출방법
mydiv(x = 10, y = 3)
mydiv(10,3)
mydiv(10)

#외부 파일에 있는 함수 호출
setwd("D:\workR")           #경로지정
source("mylib.R")           #Lib 파일 지정

#함수 호출
my_max(10,5)
my_div(10,2)


#
#vector 도입
#
#scalar형 변수 사용
a <- 10
b <- 5
c <- 8
d <- 25
e <- 3
f <- 71
g <- 87
h <- 55
i <- 1
j <- 6
max <- a
if (b >max) {max <- b}
if(c > max) {max <- c}
if (d > max) {max <- d}
if (e > max) {max <- e}
if (f > max) {max <- f}
if (g > max) {max <- g}
if (h > max) {max <- h}
if (i > max) {max <- i}
if (j > max) {max <- j}
max

#vector 사용
v <- c(10, 5, 8, 25, 3, 71, 87, 55, 1, 6)
max <- v[1]
for (i in 2:length(v)) {
  if (v [i] > max) {
    max <- v [i]
  }
}
max

#vector 생성
x <- c(1,2,3)
y <- c("a","b","c")
z <- c(TRUE, FALSE, FALSE, TRUE)
x; y; z

class(x)
class(y)
class(z)

w <- c(1,2,3,"a","b","c")      #scalar단위가 다를경우 R이 강제로 같은 단위로 바꾼다.// 여기서는 숫자를 문자로도 바꿨다.  
w
class(w)


v1 <- 50:90;  v1
v2 <- c(1,2,3,50:90); v2
class(v1)
class(v2)

v3 <- seq(1, 101, 3);               v3      #seq(시작수, 끝수, 간격)
v4 <- seq(0.1, 1.0, 0.1);           v4   

v5 <- rep(1, times = 5);            v5      #times는 반복횟수
v6 <- rep(1:5, times = 3);          v6
v7 <- rep(c(1,5,9), times = 3);     v7


#벡터 원소값에 이름 지정
 score <- c(90,85,70)
 score
 names(score)
 names(score) <- c("Hong", "Kim", "Lee")
 names(score)
 score

 #벡터 원소 접근
score [1]
score [2]
score [3]
score [ "Hong" ]
score [ "Kim" ]
score [ "Lee" ]

d <- c(1,4,3,7,8)
d[1]; d[2]; d[3]; d[4]; d[5]; d[6]    #6번은 NA: 결측지(missing value) - '읽을 수 없다.' 
                                      #NULL - '아무것도 없다.'
                                      #NaN - '계산 할 수 없다.'
                                      #inf - 무한대(infinity)

#이렇게 잘 안쓰지만 개념정리용
for (i in 1:length (score)) {    
  print(score[i])
}
score_names <- c("Hong", "Kim","Lee")
for (i in 1:length(score)) {
  print(score[score_names[i]])
}
#위에걸 한줄로 요약한 코딩// 위에 형태로는사용하지 말고 밑에 한줄처럼 이용하기.
score[c("Hong", "Kim", "Lee")]

#
#벡터에서 여러 개의 값을 한번에 추출
d <- c(1,4,6,7,8)
d[ c(1,3,5)]       #1,3,5번째 수를 불러오는것
d[1:3]             #1~3번의 수를 불러오라
d[seq(1,5,2)]      #1부터5까지 2씩 증가한 값
d[-2]              #-는 제외. 즉 2번째 값을 제외한 나머지
d[-c(3:5)]         #3부터 5까지는 제외하고 나머지를 불러와라

GNP <- c(2090, 2450, 960)
GNP
names(GNP) <- c("Korea", "Japan", "Nepal")
GNP
GNP[1]
GNP["Korea"]
GNP[c("Korea", "Nepal")]


#벡터 요소값 변경 - 읽기/쓰기 중에서 쓰기 활동
v1 <- c(1,5,7,8,9)
v1
v1[2] <- 3
v1
v1[c(1,5)] <- c(10,20)  #1번과 5번 인덱스를 바꿔라. 
v1

#벡터간 연산 - 두벡터의 길이가 같아야 한다. (원소의 개수)
x <- c(1,2,3)
y <- c(4,5,6)
x+y
x*y
z <- x+y
z


#벡터에 적용 가능한 함수 - pg.129
d <- c(1,2,3,4,5,6,7,8,9,10)
sum(d)                               #합계
sum(2 * d)
length(d)                            #벡터의 요소 개수(길이)
mean(d[1:5])                         #평균
mean(d)
median(d[1:5])                       #중앙값
median(d)
max(d)                               #최대값
min(d)                               #최소값
sort(d)                              #정렬
sort(d, decreasing = FALSE)          
sort(d, decreasing = TRUE)
range(d)                             #값의 범위(최소값~최대값)
var(d)                               #분산
sd(d)                                #표준편차

v <- sum(d)/length(d)
v

#벡터에 논리연산 적용
d >= 5
d[d>5]
sum(d>5)         #d > 5수들의 개수들을 카운트하는 것. --->?? 왜 length는 안되지?
sum(d[d>5])      #그 조건에 맞는 수들의 합. 
d == 5

cond <- d >5 & d < 8 
cond
d[cond]

all(d > 5)       #모두 이 조건에 맞느냐
any(d > 5)       #범위중에 조건에 맞는게 하나이상이 있으면 TRUE

head(d)          #앞에서부터 출력 - 범위 지정 안하면 자동으로 6개
tail(d)          #뒤에서부터 출력
head(d, 3)       #앞에서부터 3개 출력
tail(d, 3)       #뒤에서부터 3개 출력


x <- c(1,2,3)
y <- c(4,5,6)
z <- c(3,1,2)

w <- c(x,y)
w
union(x,y)       #합집합
intersect(x,y)   #교집합
setdiff(x,y)     #차집합 - 먼저있는 집합에서 뒤에 집합을 빼는것. (즉 공통된 원소 뺀 앞집합)
setequal(x,y)    #x,y에 동일한 요소가 있는지 확인
setequal(x,z)


#--------------------------------------------------------------------
#
#List
ds <- c(90, 85, 70, 84)
my.info <- list(name = 'Hong', age = 30, status = TRUE, score = ds)      #name이 key, Hong이 value... 이런식. // score의 타입은 벡터
my.info
my.info[ 1 ]         #대괄호 1개를 쓰면 key와 value 두개다 나온다. 
my.info[[ 1 ]]       #대괄호 2개를 쓰면 value만 나온다. 
my.info$name         #리스트 안에있는 변수를 출력하려면 꼭 $를 써야한다. 그 key안에 있는 값이 뭐냐. 
my.info[[ 4 ]]       #score는 벡터니까 그 안에 값들 전체가 나온다. 
my.info[[ 4 ]] [1]   #4개의 인덱스에서 첫번째 값을 말해라. 


#Factor 형
bt <- c('A', 'B', 'B', 'O', 'AB', 'A')     #문자형 벡터
bt.new <- factor( bt )                     #factor형 벡터
bt
bt.new
bt[ 5 ]
bt.new[ 5 ]
levels(bt.new)                             #factor 형 벡터일때 쓰는것. 가질수 있는 값의 범위. 
as.integer(bt.new)                         #변환 함수 : as // 변수안에 있는 값들을 integer로 변환하라. /// factor형으로 바꾸면 안될때 integer로 바꿔주는걸 한다. 
bt.new[ 7 ] <- 'B'                         #7번째에 B를 넣어준다. 
bt.new[ 8 ] <- 'C'                         #C는 범위안에 포함되지 않어서 오류가 나온다. 
bt.new



