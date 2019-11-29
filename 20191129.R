#
#4일차
#
#함수 반환값 (return값) 이 여러 개일 때의 처리
myfunc <- function(x,y) {
  val.sum <- x + y
  val.mul <- x * y
  
  return( list( sum = val.sum, mul = val.mul ) )     #function은 return값이 하나였지만 list를 사용해서 두개를 나올수있게 함./리턴은 하나지만 리스트로 나옴. 
}

result <- myfunc ( 5, 8 )
s <- result$sum
m <- result$mul
cat ('5 + 8 = ', s, '\n')
cat ('5 * 8 = ', m, '\n')

#Matrix 생성 - 기본적으로 다 열우선 
z <- matrix( 1:20, nrow = 4)      #행만 정해주고 그럼 열은 R이 알아서 생성. (열우선)
z

z <- matrix( 1:20, ncol = 4)      #열만 정해주고 그럼 행은 R이 알아서 생성. (열우선)
z

z <- matrix( 1:20, nrow = 4, ncol = 5)
z

z <- matrix(1:20, nrow = 4, ncol = 5, byrow = T)   #byrow를 T로 했으니까 행우선으로. 
z


x <- 1:4
x
y <- 5:8
y
z <- matrix(1:20, nrow = 4, ncol = 5)
z

m1 <- cbind(x,y)    #cbind면 열로보겠다. - 변수로 보겠다. 
m1
m2 <- rbind(x,y)    #rbind면 행으로 보겠다. - 관측치로. 
m2
m3 <- rbind(m2,x)
m3
m4 <- cbind(z,x)
m4


#Matrix에서 cell의 값 추출
z
z[2,3]
z[1,2]
z[2,]      #열의 위치가 없으니까, 그 행 전체를 출력
z[,4]      #그열 전체출력

z[2,1:3]  
z[1,c(1,2,4)]
z[1:2,]
z[,c(1,4)]


#matrix에서 행/열에 이름 지정
score <- matrix(c( 90, 85,69,78,
                   85,96,49,95,
                   90,80,70,70),
                nrow = 4, ncol = 3)
score
rownames(score) <- c("Hong", "Kim", "Lee","Yoo")
colnames(score) <- c("English", "Math", "Science")
score
score['Hong', 'Math']
score['Kim', c('Math','Science')]
score['Lee',]
score[,'English']
rownames(score)
colnames(score)
colnames(score)[2]

#Data Frame 생성
city <- c("seoul", "Tokyo", "Washington")
rank <- c(1,3,2)
city.info <- data.frame(city, rank)
city.info

name <- c("Hong", "Kim", "Lee")
age <- c(22,20,25)
gender <- factor(c("M","F", "M"))
blood.type = factor(c("A","O","B"))
person.info <- data.frame(name, age, gender, blood.type)
person.info

person2.info <- data.frame(name = c("Hong", "Kim","Lee"),
                           age = c(22,20,25),
                           gender = factor(c("M","F","M")),
                           blood.type = factor(c("A", "O","B")))
person2.info

city.info[1,1]
city.info[1,]
city.info[,1]                    #처음 변수내용
city.info[ city.info$city, ]     #city전체내용
city.info[, "rank"]

person.info$name
person.info[person.info$name == "Hong",]                      #만족하는것에 대한 관측치
person.info[person.info$name == "Hong", c("name", "age")]     #만족하는 것에 name과 age

data()

iris

iris[, c(1:2)]
iris[, c(1,3,5)]
iris[, c("Sepal.Length", "Species")]
iris[1:5]
iris[1:5, c(1,3) ]

#Matrix 와 Data Frame에서 사용하는 함수
dim(person.info)               #**많이 사용하는 함수 - 관측치와 변수의 수 알려줌/// 처음수 = 관측치 수, 나중수 = 변수 수
dim(iris)
nrow(person.info)                 
nrow(m3)
ncol(person.info)
ncol(m3)
head(iris)                     #**많이 사용하는 함수 - 앞에 6개(자동) 
tail(iris)                     #**많이 사용하는 함수 - 뒤에 6개(자동)
str(iris)                      #**많이 사용하는 함수 - data가 어떻게 저장되어졌는지 알아보는 것./ data저장형식, 관측치수, 변수의 수 / 
str(city.info)                                      #- $로 표시된것 - 변수명 : num은 숫자형. (이 타입이 어떤건지 잘 확인해야한다.!!)
str(person.info)                                    #data.frame으로 만들면 name처럼 factor형으로 자동 바꿔버리는 경우가 있다. 그러니 꼭 str로 확인.!!!
unique(iris[,5])               #중복된 데이터를 하나씩만 뽑아라
table(iris[, "Species"])               #**많이 사용하는 함수
table(person.info[ , "blood.type"])    #종류별로 카운트를 세주는 함수. A형 한개, B형 한개, O형 한개. 
table(person.info[, "gender"])         #F한명, M두명


#Matrix/Data Frame 사용 함수
#행별/열별 합계와 평균 계산
colSums(iris [, -5]);  apply(iris[, 1:4],2, sum)       #변수의 합계 5는 제외해라. 왜? factor형이니까.==같은내용== apply에서는 data.set, 1:4만큼, 2:컬럼방향 동작. 
colMeans(iris[,-5]);   apply(iris[, 1:4],2, mean)
rowSums(iris[,-5]);    apply(iris[, -5],1, sum)
rowMeans(iris[,-5]);   apply(iris[, -5],1, mean)

apply(iris[,-5],2,median)    #열에 중앙값을 구하겠다.  

#행/열 방향 전환
z <- matrix(1:20, nrow = 4, ncol = 5)
z
t(z)     #행과 열의 값을 바군다. 바꾸면 4열 5행. (전체바꿈)

#조건에 맞는 행과 열의 값 추출(Data Frame만 가능)!!!!!
IR.1 <- subset(iris, Species == "setosa")                     #부분추출. 품종이 setosa만 추출. 
IR.1
IR.2 <- subset(iris, Sepal.Length > 5.0 & Sepal.Width > 4.0)  #부분추출
IR.2
IR.2[,c(2,4)]    #변수지정 


#Matrix/Data Frame 산술연산
a <- matrix (1:20, 4,5);   a   
b <- matrix(21:40, 4,5);   b

2 * a
b - 5
2 * a + 3 * b

a + b
b - a
b / a
a * b

#Matrix/Data Frame 자료구조 확인/변환
class(iris);                 str(iris)         #data.frame에 결과분석
class(state.x77);            str(state.x77)    #matrix에 결과분석
is.matrix(iris)
is.data.frame(iris)
is.matrix(state.x77)
is.data.frame(state.x77)

st <- data.frame(state.x77)         #matrix에서 data.frame로 바꿈
str(st)
head(st)
class(st)
dim(st)

iris.m <- as.matrix(iris[,1:4])    #data.fram에 1부터 4까지를 matrix로 바꿈
head(iris.m)
class(iris.m)
str(iris.m)

head(st)
Population   #변수명만 쓰면 오류
attach(st)   #attach는 그 변수 이름을 직접적으로 사용하고 싶으면 변수명을 '직접' 사용이 가능하다 (변수는 세로!열. 같은형의 데이터들 = 즉 벡터)
Population
detach(st)   #다시 attach전으로 돌려놓을때. 풀어놓기. 
Population
