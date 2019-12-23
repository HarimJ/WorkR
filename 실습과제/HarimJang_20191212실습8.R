#
# 장하림
# 20191211/ 20191212
#
#문1)
#20대 국회 개원 여·야 3당 대표 국회연설문에 대해 각각 워드클라우드를 작성하시오.
#예제소스 파일은 ‘ex_10-1.txt’, ‘ex_10-2.txt’, ‘ex_10-3.txt’이다.


#   워드클라우드는 방향성을 알아볼때 많이 사용하고 용이하다 

library(wordcloud)
library(wordcloud2)
library(KoNLP)
library(RColorBrewer)

library( dplyr)
library(ggplot2)

setwd("d:/")
text1 <- readLines('ex_10-1.txt', encoding = 'UTF-8')
text2 <- readLines('ex_10-2.txt', encoding = 'UTF-8')
text3 <- readLines('ex_10-3.txt', encoding = 'UTF-8')

text1
text2
text3

buildDictionary(ext_dic = 'woorimalsam')
pal2 <- brewer.pal(8, 'Dark2')
noun <- sapply(text1, extractNoun, USE.NAMES = F)      # 명사빈도체크 : extractNoun   ( 꼭 해야하는 단계 )
noun

 # 10-1 워드클라우드
noun2 <- unlist( noun )
wordcount1 <- table(noun2);   wordcount1
sort.noun <- sort(wordcount1, decreasing = T );  sort.noun

noun2 <- noun2[nchar(noun2) > 1]
noun2 <- gsub('◇', '', noun2)
noun2 <- gsub('부터', '', noun2)
noun2 <- gsub('을', '', noun2)
noun2 <- gsub('입니다', '', noun2)
noun2 <- gsub('10', '', noun2)
noun2 <- gsub('들이', '', noun2)
noun2 <- gsub('여러분', '', noun2)
wordcount1 <- table(noun2)

wordcloud(names(wordcount1), freq = wordcount1, scale = c(6,0.7), min.freq = 3, random.order = F, 
          rot.per = 0.1, colors = pal2)

 # 10-2 워드클라우드
buildDictionary(ext_dic = "woorimalsam", user_dic = data.frame(c('댓글', '사드배치' ,'영남' ,'김영란법'), 'ncn'), 
                replace_usr_dic = T)
no <- sapply(text2, extractNoun, USE.NAMES = F)
no2 <- unlist(no)
no2

wordcount2 <- table(no2);   wordcount2
sort.noun2 <- sort(wordcount2, decreasing =  T);   sort.noun2

no2 <- no2[nchar(no2) > 1]
no2 <- gsub('◇', '', no2)
no2 <- gsub('여러분', '', no2)
no2 <- gsub('들이', '', no2)
no2 <- gsub('하기', '', no2)
no2 <- gsub('하지', '', no2)
wordcount2 <- table(no2)

wordcloud(names(wordcount2), freq = wordcount2, scale = c(6, 0.7), min.freq = 3, random.order = F, 
          rot.per = 0.2, colors = pal2)

 # 10-3 워드클라우드
n <- sapply(text3, extractNoun, USE.NAMES = F);  n
n2 <- unlist(n)
n2

wordcount3 <- table(n2);  wordcount3 
sort.noun3 <- sort(wordcount3, decreasing = T);  sort.noun3

buildDictionary(ext_dic = "woorimalsam", user_dic = data.frame(c('더불어민주당', '역사'), 'ncn'),
                replace_usr_dic = T)
n2 <- unlist(n)

n2 <- n2[nchar(n2) > 1 ]
n2 <- gsub('◇', '', n2)
n2 <- gsub('때문', '', n2)
n2 <- gsub('여러분', '', n2)
n2 <- gsub('의', '', n2)
n2 <- gsub('20', '', n2)
wordcount3 <- table(n2)

wordcloud(names(wordcount3), freq = wordcount3, scale = c(6, 0.7), min.freq = 3, random.order = F, 
          rot.per = 0.2, colors = pal2)



#문2)
#스티브 잡스의 스탠포드 대학 졸업식 연설문에 대해 워드클라우드를 작성하시오.
#Tip. 예제소스 파일은 ‘ex_10-4.txt’이다.

st <- readLines('ex_10-4.txt', encoding = 'UTF-8')
st

sn <- sapply(st, extractNoun, USE.NAMES = F);  sn
sn2 <- unlist(sn)
wordcount4 <- table(sn2)
sort.noun4 <- sort(wordcount4, decreasing = T);  sort.noun4

buildDictionary(ext_dic = 'Woorimalsam', user_dic = data.frame('픽사', 'ncn'),
                replace_usr_dic = T)
sn2 <- unlist(sn2)

sn2 <- sn2[nchar(sn2) > 1]
sn2 <- gsub('때문','', sn2)
sn2 <- gsub('여러분','', sn2)
sn2 <- gsub('굉장','', sn2)
sn2 <- gsub('찾으세요','', sn2)
sn2 <- gsub('했습니다','', sn2)
sn2 <- gsub('10','', sn2)
sn2 <- gsub('개월','', sn2)
sn2 <- gsub('하지','', sn2)
sn2 <- gsub('뭔가','', sn2)
sn2 <- gsub('들이','', sn2)
sn2 <- gsub('점들','', sn2)
sn2 <- gsub('그것','', sn2)
wordcount4 <- table(sn2)

wordcloud(names(wordcount4), freq = wordcount4, scale = c(15, 0.2), min.freq = 3, random.order = F, 
          rot.per = 0.1, colors = pal2)



#문3) 
#오바마 대통령의 데통령 당선 연설문에 대해 워드클라우드를 작성하시오
#Tip. 예제소스 파일은 ‘ex_10-5.txt’이다.
ov <- readLines('ex_10-5.txt', encoding = 'UTF-8'); ov
nv <- sapply(ov, extractNoun, USE.NAMES = F);  nv
nv2 <- unlist(nv);  nv2
wordcount.ov <- table(nv2); wordcount.ov
sort.ov <- sort(wordcount.ov, decreasing = T); sort.ov

nv2 <- nv2[nchar(nv2) > 1]
nv2 <- gsub('당신들', '', nv2)
nv2 <- gsub('을', '', nv2)
nv2 <- gsub('이것', '', nv2)
nv2 <- gsub('사람들', '', nv2)
nv2 <- gsub('은', '', nv2)
nv2 <- gsub('이', '', nv2)
nv2 <- gsub('는', '', nv2)
nv2 <- gsub('하기', '', nv2)
nv2 <- gsub('이번', '', nv2)
nv2 <- gsub('보다도', '', nv2)
nv2 <- gsub('이라는', '', nv2)
nv2 <- gsub('에', '', nv2)
nv2 <- gsub('때문', '', nv2)
wordcount.ov <- table(nv2)

wordcloud(names(wordcount.ov), freq = wordcount.ov, scale = c(15, 0.3), min.freq = 3, random.order = F, rot.per = 0.3, colors = pal2)























