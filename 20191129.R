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


