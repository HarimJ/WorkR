#
# 장하림
#
# 20191216/ 20191216
#

#문1)
#state.x77 데이터셋에서 문맹률(Illiteracy)을 이용해 범죄율(Murder)을 예측하는 단순선형 회귀모델을 만드시오. 그리고 문맹률이 0.5, 1.0, 1.5일 때 범죄율을 예측하여 보시오.
state.x77
str(state.x77)
state.x77 <- as.data.frame(state.x77)

plot(Murder~Illiteracy, data = state.x77)
model <- lm(Murder~Illiteracy, state.x77)
model

abline(model)

# 예측해보기

df <- data.frame( Illiteracy = c(0.5,1.0,1.5) )
predict(model, df)

plot(df$Illiteracy, predict(model, df), col = 'red', cex = 2, pch = 20 )
abline(model)


#문2)
#trees 데이터셋에서 나무둘레(Girth)로 나무의 볼륨(Volume)을 예측하는 단선형 회귀모델을 만드시오. 그리고 나무 둘레가 8.5, 9.0, 9.5일 때, 나무의 볼륨(Volume)을 예측하여 보시오.
str(trees)
plot(Volume~Girth, trees)
model2 <- lm(Volume~Girth, trees)
model2
abline(model2)

dg <- data.frame(Girth = c(8.5, 9.0, 9.5))
predict(model2, dg)
plot(dg$Girth, predict(model2, dg), col = 'steelblue', cex = 2, pch = 20)
abline(model2)



#문3) 
#pressure 데이터셋에서 온도(temperature)로 기압(pressure)을 예측하는 단순선형 회귀모델을 만드시오. 그리고 온도가 65, 95, 155일 때 기압을 예측하여 보시오.
str(pressure)
plot(pressure~temperature, pressure)
model3 <- lm(pressure~temperature, pressure)
model3
abline(model3)

ds <- data.frame(temperature = c(65, 95, 155))
predict(model3, ds)
plot(ds$temperature, predict(model3, ds), col = 'green', cex = 2, pch = 20)
abline(model3)










