#
#장하림
#20191129 / 20191202

#문1)
#1
score <- matrix(c(10,40,60,20,21,60,70,30), nrow = 4, ncol = 2);    score
colnames(score) <- c("m","f");                                      score

#2
colnames(score) <- c("male", "female");   score

#3
score[2,]

#4
score[,2]

#5
score[3,2]

#문2)R에서 제공하는 state.x77 데이터셋을 이용하여 작성

#1. state.x77을 변환하여 st에 data frame으로 작성
st <- as.data.frame(state.x77)

#2. st의 내용을 출력
st

#3. st의 열 이름 출력
variable.names(st)

#4. st의 행 이름 출력
row.names(st)

#5. st의 행의 개수와 열의 개수 출력
dim(st)

#6. st의 요약 정보 출력
str(st)
#7. st의 행별 합계와 평균 출력
apply(st[1:50,],1, sum)
apply(st[1:50, ],1, mean)

#8. st의 열별 합계와 평균 출력
apply(st[, 1:8],2, sum)
apply(st[, 1:8],2, mean)

#9. Florida 주의 모든 정보 출력
st["Florida",]

#10. 50개 주의 수입(Income) 정보만 출력
st[,"Income"]

#11. Texas 주의 면적(Area)을 출력
st["Texas", "Area"]

#12. Ohio 주의 인구(Population)와 수입(Income) 출력
st["Ohio",c("Population","Income")]

#13. 인구가 5,000 이상인 주의 데이터만 출력
st.1 <- subset(st, Population > 5000) 
st.1

#******14. 수입이 4,500 이상인 주의 인구, 수입, 면적을 출력
st.2 <- subset(st,Population & Area & Income > 4500)
st.2


#15. 수입이 4,500 이상인 주는 몇 개인지 출력
length(rownames(st.2))


#16. 전체 면적(Area)이 100,000 이상이고, 결빙일수(Frost)가 120 이상인 주의 정보 출력
st.3 <- subset(st, Area >= 100000 & Frost >= 120)
st.3

#17. 인구(Population)가 2,000 미만이고, 범죄율(Murder)이 12미만인 주의 정보 출력
st.4 <- subset(st, Population < 2000 & Murder < 12)
st.4

#******18. 문맹률(Illiteracy)이 2.0 이상인 주의 평균 수입은 얼마인지 출력
stt <- subset(st, Illiteracy >= 2.0)
stt
mean(stt$Income)


#19. 문맹률(Illiteracy)이 2.0 미만인 주와 2.0 이상인 주의 평균 수입의 차이 출력
a <- subset(st, Illiteracy < 2.0); a
b <- subset(st, Illiteracy >= 2.0);b


#20. 기대수명(Life Exp)이 가장 높은 주는 어디인지 출력
c <- subset(st, max(Life Exp))


#21 Pennsylvania 주보다 수입(Income)이 높은 주들 출력