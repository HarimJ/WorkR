#
# 12일 차
#
# 워드클라우드( Word cloud )
#
# 한글 워드클라우드 절차
# 1. Java 실행환경 구축
# 2. 자료 수집 ( Text 자료 )
#    2.1 text file 형태로 수집  -  메모장으로 열어서 읽을 수 있으면 text file 이다 // 읽을 수 없으면 binary 형태 파일
#                               -  직접 데이터 수집을 한다 ( 스크랩해서 메모장으로 저장 ) 
#    2.2 web scraping 이용하여 수집  -  직접 웹페이지에서 정보를 가져오는것 
# 3. 명사 추출
Sys.setenv( JAVA_HOME = "C:/Program Files/Java/jre1.8.0_231") 

# 필요시 설치
install.packages("wordcloud")          # word cloud
install.packages( "wordcloud2" )       # word cloud
install.packages( "KoNLP" )            # 한국어 처리 - 꼭 설치!!
install.packages( "RColorBrewer" )     # 색상 선택

library( wordcloud )
library( wordcloud2 )
library( KoNLP )
library( RColorBrewer )

library( dplyr )
library( ggplot2 )

setwd("d:/")
text <- readLines('mis_document.txt', encoding = 'UTF-8')   # readLines 는 한 줄씩 읽는 함수
text                                                        # 항상 text file 마지막 줄에는 공백줄 한줄 이상이 꼭 필요하다. !! (안하면 오류)

# '우리말씀' 한글 사전 로딩
buildDictionary( ext_dic = 'woorimalsam' )
pal2 <- brewer.pal( 8, 'Dark2' )                            # 색상 팔레트 생성
noun <- sapply(text , extractNoun, USE.NAMES = F)           # extracNoun : 명사 추출 / USE.NAMES = F : 행 이름 은 쓰지 않겠다 (T면 그 추출한 단어 문장이 같이 나옴) 
noun                                                        # !! 다운받은 사전에 없는 단어는 추출이 안되니 꼭 추출 내용과 원본을 확인해야한다. !!

# 4. 추출된 단어 ( 주로 명사 )에 대한 빈도수 계산 및 시각화
noun2 <- unlist( noun )                                     # list에서 -> vector로 변환  (그 전 noun은 list형식이었음)
wordcount <- table( noun2 )                                 # 각 명사별 갯 수
sort.noun <- sort(wordcount, decreasing = T )[ 1:10 ]       # 빈도수가 높은것부터 낮은것 순으로 , 10개만
sort.noun
sort.noun <- sort.noun[ -1 ]                                # sort.noun을 보면 처음은 공백으로 나오니 그 공백 제거
barplot( sort.noun, names.arg = names(sort.noun),
         col = 'steelblue', main = '빈도수 높은 단어',
         ylab = '단어 빈도수')


  # 그래프를 가로로 뉘워서 표현
df <- as.data.frame(sort.noun)
df
ggplot(df, aes(x = df$noun2, y = df$Freq)) +  
  geom_bar(stat = "identity",         # y 축을 넣으면 stat = identity를 꼭 넣어야 한다. (x 축만 있을때는 자동 빈도수 나온다) 뜻: y 축에 y 값을 넣겠다.  
           width = 0.7,
           fill = 'steelblue') +
  ggtitle('빈도수 높은 단어') +
  theme(plot.title = element_text(size = 25, face = 'bold', colour = 'steelblue', hjust = 0, vjust = 1)) +    # v/hjust는 문자 좌표 (v:수직, h:수평)
  labs(x = '명사', y = '단어빈도수') + 
  geom_text(aes(label = df$Freq), hjust = -0.3) +           # 빈도 표시
  coord_flip()



# 5. word cloud 작성
pal3 <- brewer.pal( 9, 'Blues' ) [5:9]    # 단어 색 지정. /// 이 라인 지우고 밑에 pal2로 하면 형형색색!
wordcloud( names(wordcount),              # 단어 (출력할 단어)
           freq = wordcount,              # 단어 빈도
           scale = c(6,0.7),              # 단어폰트크기( 최대, 최소)
           min.freq = 3,                  # 단어최소빈도 - 빈도수 중에 최소 몇('3') 이상 표현
           random.order =  F,             # 단어출력위치 - 랜덤(T) 하게 하지말고 F 이면 빈도수 높을 수록 중앙에 위치
           rot.per = 0.1,                 # 90도회전단어비율 - 0.1은 10%
           colors = pal3 )                # 단어 색
     # 빈도수가 클수록 글자 크기가 커짐


# 6. 전처리 과정 수행
#
#    6.2 생략된 단어를 사전에 등재
buildDictionary( ext_dic = 'woorimalsam', 
                 user_dic = data.frame('정치', 'ncn'),      # ncn : 단어를 명사로 지정// ( 즉, '정치'를 명사로 지정한다)
                 replace_usr_dic = T)
noun <- sapply(text, extractNoun, USE.NAMES = F)
noun2 <- unlist(noun)

#    6.1 불필요한 단어 삭제
noun2 <- noun2[nchar(noun2) > 1]       # 단어 길이를 1개 이상 추출 
noun2 <- gsub('하지', '', noun2)       # 삭제할 단어 지정 - 직접 지정해야한다. // '하지'를 ''로 바꿔라.  마지막 noun2는 사용할 데이터 (gsub은 치환 함수?)
noun2 <- gsub('때문', '', noun2)       # '때문' 을 ''로 바꿈
wordcount <- table(noun2)



# 7. word cloud 작성   -   삭제할것, 등재할것 확인후 다시 클라우드 작성해서 출력. 
wordcloud( names(wordcount),              
           freq = wordcount,              
           scale = c(6,0.7),              
           min.freq = 3,                  
           random.order =  F,            
           rot.per = 0.1,                 
           colors = pal2 )  


#
# 애국가
#
library( KoNLP )
useSystemDic()      # system 사전
useSejongDic()      # 
useNIADic()         # 

#
# 1. 사전 설정
#
useSejongDic()

# 2. 텍스트 데이터 가져오기
word_data <- readLines( '애국가(가사).txt')
word_data

# 3. 명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2

  # !! 직접 결과 확인 (예/ '남산위에' 라고 추출되면 '남산' 이라는 단어가 명사로 지정되어 있지 않다는 뜻이므로 내가 직접 사전에 지정해야함) !!

# 3.1 제대로 추출되지 않은 단어를 사용자 사전에 등록
add_words <- c("백두산",'남산','철갑','가을','하늘','달')
buildDictionary(user_dic = data.frame( add_words ,
                                       rep('ncn', length(add_words))),
                replace_usr_dic = T)
get_dictionary('user_dic')

# 3.2 단어 추가 후 다시 명사 추출
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2


# 4. 행렬을 벡터로 변환
undata <- unlist(word_data2)
undata


# 5. 사용 빈도 확인
word_table <- table(undata)
word_table


# 6. 필터링 : 두 글자 이상 단어만 선별, 공백이나 한 자리 문자를 걸러냄
undata2 <- undata [ nchar( undata ) >= 2 ]
undata2
word_table2 <- table(undata2)
word_table2

# 7. 데이터 정렬
sort(word_table2, decreasing = T)

 # 애국가 형태 분석 완료
 # 가장 기본적인 전처리만 수행, 100% 정확한 데이터라 볼 수 없음


# 8. word cloud 작성 후 분석
library(wordcloud2)
wordcloud2( word_table2)


# 8.1 배경 밎 색상 변경
wordcloud2(word_table2,
           color = 'random-light',
           backgroundColor = 'black')


# 8.2 모양 변경
wordcloud2(word_table2, fontFamily = '맑은고딕',
           size = 1.2, color = 'random-light', backgroundColor = 'black', shape = 'star')


# 8.3 선택 색상 반복
wordcloud2(word_table2, size = 1.6, color = rep_len(c('red', 'blue'), nrow(word_table2)))
wordcloud2(demoFreq, size = 1.6, color = rep_len(c('red','blue'), nrow(word_table2)))      # 다른 데이터로 예시


# 8.4 일정 방향 정렬
wordcloud2(word_table2, 
           minRotation = - pi / 6,
           maxRotation = - pi / 6,
           rotateRatio = 1)
wordcloud2(demoFreq,
           minRotation = - pi / 6,
           maxRotation = - pi / 6,
           rotateRatio = 1 )


