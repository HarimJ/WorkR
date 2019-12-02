#
#5일차
#
setwd("D:/WorkR")
df <- read.table(file = "airquality.txt", header = T )
df
class(df)
dim(df)
str(df)
head(df, 3)
tail(df, 3)

install.packages("xlsx")
install.packages("rJava")

library(rJava)
library(xlsx)

df.xlsx <- read.xlsx(file = "airquality.xlsx", sheetIndex = 1,
                     encoding = "UTF-8")
df.xlsx
class(df.xlsx)
str(df.xlsx)
head(df.xlsx, 3)
tail(df.xlsx, 3)

score <- c(76, 84, 69, 50, 95, 6, 82, 71, 88, 84)
which(score == 69)          #69가 있는 값의 위치는 어디냐
which(score >= 85)
max(score)
which.max(score)
min(score)
which.min(score)

idx <- which(score >= 60)
score[ idx] <-  61
score

idx <- which(iris [, 1:4] > 5.0, arr.ind = TRUE)
idx
