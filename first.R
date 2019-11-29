#
#R 프로그래밍 1일차
#
#first.R
#
#작성자 : harim
#
#최초작성일 :2019.11.26
#
#
print("Hello, World!!!")

number <- 10
number2 = 100

number3 <- number


numberValue <- 1                   #camel 표기법
str_value <- "R Language"          #snake 표기법  
booleanvalue <- TRUE 

numberValue <- "R script"  
numberValue <- 1

print(numberValue)
print(str_value)
print(booleanvalue)


cat("Numeric number : ", numberValue, "\n")
cat("String : ", str_value, "\n" )
cat("Booleanvalue : ", booleanvalue, "\n")

numberValue <- scan()
cat("Numeric number : ", numberValue, "\n")

number1  <- 10
number2 <- 20
resultAdd <- number1 + number2
resultSub <- number1 - number2
resultMul <- number1 * number2
resultDiv <- number1 / number2
resultRem <- number2 %% number1
resultSec <- number2 ^ 5

print(resultAdd)
print(resultSub)
print(resultMul)
print(resultDiv)
print(resultRem)
print(resultSec)

number1 <- 0
number1 <- number1 + 10
number1 
number1 <- number1 + 10
number1 
number1 <- number1 + 10
number1 

number2 <- 100
number1 <- number2 + 10
number1
number2
print((number1 + 10) * number2 /2 )

number300 <- 10
number300 <- number300 + 10
number300

number301 <- number300 * 2
number301

number1 <- 10.5
number2 <- 10
print(number1 > number2 )
print(number1 >= number2)
print(number1 < number2)
print(number1 <= number2)
print(number1 == number2)
print(number1 != number2)

print( number1 > 10 & number2 > 10)   #AND
print( number1 > 10 | number2 >10)    #OR
print(!(number1 > 10))                #NOT

number <- "100"
str <- "R Language"
result = number + str
print(result)


#
#제어구조 - 선택구조
#
#
job.type <- 'A'
if (job.type == 'B') {
  bonus <- 200     #참일때
} else {
  bonus <- 100     #거짓일때
}
cat( "job type : ", job.type, "\tbonus: ", bonus)


job.type <- 'B'
if (job.type == 'A'){
  bonus <- 200
}
cat("job type : ", job.type, "\t\tbonus : ", bonus)


score <- 85 
if (score >= 90) {
  grade <- 'A'
} else if (score >= 80){
  grade <- 'B'
} else if (score >= 70){
  grade <- 'C'
} else if (score >= 60){
  grade <- 'D'
} else {
  grade <- 'F'
}
cat ("score : ", score, "\tgrade : ", grade)


#내가한거 
number <- 102
if (number %% 2){
  result <- "는 홀수이다"
} else {
  result <- "는 짝수이다"
}  
cat("Number : ", number, result)


#강사님이 하신거
number <-10
remainder <- number %% 2

if(remainder == 0) {
  oddeven <- '짝수'
} else {
  oddeven <- '홀수'
}
cat("Number : ", number, "는", oddeven, "이다.")

#-------------------------------------------------

a <- 5
b <- 20

if (a > 5 & b > 5) {
  cat( a, " > 5 and ", b, " > 5 ")
} else {
  cat (a, " <= 5 or ", b, " <= 5 ")
}


a <- 10
b <- 20
if ( a > b) {
  c <- a
} else {
  c <- b
}
cat ( "a = ", a, "\tb = ", b, "\tc = ", c)


#위에식을 간결하게 쓰는 방법
c <- ifelse (a > b, a, b)
cat("a = ", a, "\tb = ", b, "\tc =  ", c)

#--------------------------------------------------------------------------

#임의의 수를 max에 저장후 맥스를 출력
#이럴땐 max값을 넣고 a,b,c가 max랑 비교했을때 크냐 안크냐를 비교하면 된다.
a <- 10
b <- 5
c <- 8
max <- a

if(b > max ) {
  max = b               #여기서 <- 를 사용하면 안되고 =를 사용해야한다.
}
if(c > max  ) {
  max = c               #여기서 <- 를 사용하면 안되고 =를 사용해야한다.
}
cat("a = ", a, "\t\tb = ",b, "\t\tc = ", c, "\t\tmax = ", max)

#
#
#반복구조
#
# for 문
for ( i in 1 :10) {
  print ('*')
}

multiple = 2 
for ( i in 2:9) {
  cat(multiple, 'X', i, ' = ', multiple * i, '\n')
}


#while문
i <- 1          #반복제어변수! 꼭 while을 쓸때는 꼭 써야한다. 
while (i <= 10) {
  print (i)
  i <- i +1
}

multiple <- 2
i <- 2
while ( i <= 9 ) {      #i 가 9보다 같거나 작은 범위만 참. 즉 10부터는 거짓이므로 반복제어. 
  cat(multiple, ' X ', i, ' = ', multiple * i, '\n' )
  i <- i + 1            #이 문장을 안쓰면 무한반복이 된다. 
}


#강사님이 하신것. 1:100까지 10단위씩 정렬

#1. 
lineCount <- 1            #초기화
for (i in 1:100) {
  cat( i , '')            # i와 띄어쓰기 한칸
  lineCount <- lineCount +1
  if (lineCount >10) {
    print('\n')
    lineCount <- 1      #reset
  }
}

#2
for ( i in 1:100) {
  cat(i , '')
  if ( i %% 10 == 0) {
    print ('\n')
  }
}


#실습문제!!!! 숙제!!!!!1
#1:1000까지 3의배수와 5의배수를  한줄에 10개씩 출력하고 마지막에 개수를 출력.
#내가한것
lineCount <- 1
for (i in 1:1000) {
  if( i %% 3 == 0 | i %% 5 == 0) 
    cat (i, '')
  lineCount <- lineCount +1
  if (lineCount > 21){
    print('\n')
    lineCount <- 1
      }
}

#
#위 실습 강사님 코딩답
i <- 1                    #1~1000의 변수 초기화
count <- 0                #개수출력 변수 초기화
lineCount <- 1            #10개씩 출력변수 초기화
multiple3 <- NULL         #임시변수 // 뭔가 넣기 애매할때 NULL - 아무것도 없다라는 뜻. 뭔가를 담으려고 쓰는 변수. 
multiple5 <- NULL         #임시변수 // 없어도 되는데 보기 좋게 하기 위해서 코드를 쪼개주려고 쓴 변수.
while ( i <= 1000) {
  multiple3 <- i %% 3     #판별하기
  multiple5 <- i %% 5     #판별하기
  if (multiple3 ==0 | multiple5 == 0){
    count <- count + 1    #그 배수이면 개수를 세고 - if 문 안에 있으니까 그 수를 count
    cat( i, " ")
    lineCount <- lineCount +1
    if (lineCount > 10) {
      lineCount <- 1      #10개를 출력하고 다음줄에 첫수를 다시 1로 카운트하고 다시 10개출력하기 위해서.
      print('\n')
    } 
  }
  i <- i+1
}

print('\n')
cat( '1~1000에서 3과5의 배수의 총 개수는', count, '\n' )
#
#




