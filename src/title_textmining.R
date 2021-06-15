#install.packages('"pacman"')
#install.packages('stringr')
#install.packages('tidymodels')
#install.packages(rJava)
#install.packages('C:\\Users\\seo\\Downloads\\NLP4kec_1.4.0.zip', repos=NULL)
#install.packages('sna')
#install.packages('network')
#install.packages('GGally')
library(network)
library(GGally)
library(tidymodels)
library(tidytext)
library(NLP4kec)
library(rJava)
library(stringr)
library(tm)
library(dplyr)
library(readr)
library(sna)
library(ggplot2)



before <- read_csv("before_covid_petition.csv")
after <- read_csv("after_covid_petition.csv")

str(before)
str(after)

before_cat <- before[grep("자영업|소상공인", before$title),]
after_cat <- after[grep("자영업|소상공인", after$title),]

bna %>% summarise(sum=sum(numOfAgrees))
ana %>% summarise(sum=sum(numOfAgrees))

# 함수선언-------------------------------

generateIDs <- function(obj, index = 'id') {
  
  # 객체의 종류에 따라 길이 계산 
  if (obj %>% class() == 'data.frame') {
    n <- nrow(x = obj)
  } else {
    n <- length(x = obj)
  }
  
  # id 생성
  id <- str_c(
    index, 
    str_pad(
      string = 1:n, 
      width = ceiling(x = log10(x = n)), 
      side = 'left', 
      pad = '0') )
  
  return(id)
}  
#---------------------------------------

# 텍스트 데이터 전처리
## 결측치
sum(is.na(before_cat))
sum(is.na(after_cat))

## 중복행 제거
print(nrow(before_cat))
before_cat<- unique(before_cat)
print(nrow(before_cat))

print(nrow(after_cat))
after_cat<- unique(after_cat)
print(nrow(after_cat))

## 텍스트 공백 제거, 추후 형태소 분석기로 다시 구분
before_cat<- sapply(before_cat, str_remove_all, '\\s+')
class(before_cat)
before_cat<- as.data.frame(before_cat, stringsAsFactors = FALSE)
colnames(before_cat)<- c('title')

after_cat<- sapply(after_cat, str_remove_all, '\\s+')
after_cat<- as.data.frame(after_cat, stringsAsFactors = FALSE)
colnames(after_cat)<- c('title')


## 의미없는 텍스트 제거
before_cat_range<- before_cat$title %>%
  nchar %>%
  range
print(before_cat_range)

before_cat$title[nchar(x= before_cat$title) < 5]

after_cat_range<- after_cat$title %>%
  nchar %>%
  range
print(after_cat_range)

after_cat$title[nchar(x= after_cat$title) < 5]

# 데이터 전처리 2 (형태소 분석을 위한 전처리)
## id 칼럼 붙이기

before_cat$id <- generateIDs(obj= before_cat, index='doc')
names(before_cat)<- c("title","id")

after_cat$id <- generateIDs(obj= after_cat, index='doc')
names(after_cat)<- c("title","id")

# 형태소 분석
Parsed_bcat<- r_parser_r(before_cat$title, language= "ko")
Parsed_bcat[1:10]

Parsed_acat<- r_parser_r(after_cat$title, language= "ko")
Parsed_acat[1:10]

# corpus생성
corp_b<- VCorpus(VectorSource(Parsed_bcat))
inspect(corp_b[1])

corp_a<- VCorpus(VectorSource(Parsed_acat))
inspect(corp_a[1])

# 특수문자 & 숫자 제거
corp_b<- tm_map(corp_b, removePunctuation)
corp_b<- tm_map(corp_b, removeNumbers)

corp_a<- tm_map(corp_a, removePunctuation)
corp_a<- tm_map(corp_a, removeNumbers)

#==================
# DTM by TFIDF
dtmTfIdf1 <- DocumentTermMatrix( x = corp_b, control = list( removeNumbers = TRUE, wordLengths = c(2, Inf), weighting = function(x) weightTfIdf(x, normalize = TRUE) ))  
dtmTfIdf1

dtmTfIdf2 <- DocumentTermMatrix( x = corp_a, control = list( removeNumbers = TRUE, wordLengths = c(2, Inf), weighting = function(x) weightTfIdf(x, normalize = TRUE) ))  
dtmTfIdf2

## dtm 차원축소
dim(dtmTfIdf1)
dtmTfIdf1 <- removeSparseTerms(x =  dtmTfIdf1, sparse = as.numeric(x = 0.99))
dim(dtmTfIdf1)
dtmTfIdf1

dim(dtmTfIdf2)
dtmTfIdf2 <- removeSparseTerms(x =  dtmTfIdf2, sparse = as.numeric(x = 0.99))
dim(dtmTfIdf2)
dtmTfIdf2

# 상관행렬 만들기
corTerms1<- dtmTfIdf1 %>% as.matrix() %>% cor() 
glimpse(corTerms1)

corTerms2<- dtmTfIdf2 %>% as.matrix() %>% cor() 
glimpse(corTerms2)


# 네트워크맵
## 네트워크 객체 추출

dim(corTerms1)
netTerms1 <- network(x = corTerms1, directed = FALSE)
netTerms2 <- network(x = corTerms2, directed = FALSE)

# 상관관계 일정 수치 이상인 데이터만 사용
corTerms1_1<- corTerms1
corTerms1_1[corTerms1 <= 0.2] <- 0
netTerms1 <- network(x = corTerms1_1, directed = FALSE)
netTerms1
plot(netTerms1, vertex.cex = 1)

corTerms2_1<- corTerms2
corTerms2_1[corTerms2 <= 0.45] <- 0
netTerms2 <- network(x = corTerms2_1, directed = FALSE)
netTerms2
plot(netTerms2, vertex.cex = 1)

# 매개중심성 계산
btnTerms1 <- betweenness(netTerms1) 
btnTerms1[1:10]

netTerms1 %v% 'mode' <-
  ifelse(
    test = btnTerms1 >= quantile(x = btnTerms1, probs = 0.90, na.rm = TRUE), 
    yes = 'Top', 
    no = 'Rest')

btnTerms2 <- betweenness(netTerms2) 
btnTerms2[1:10]

netTerms2 %v% 'mode' <-
  ifelse(
    test = btnTerms2 >= quantile(x = btnTerms2, probs = 0.90, na.rm = TRUE), 
    yes = 'Top', 
    no = 'Rest')

nodeColors <- c('Top' = 'gold', 'Rest' = 'lightgrey')



#그래프 작성
set.edge.value(netTerms1, attrname = 'edgeSize', value = corTerms1 * 3)
ggnet2(
  net = netTerms1,
  mode = 'fruchtermanreingold',
  layout.par = list(cell.jitter = 0.001),
  size.min = 3,
  label = TRUE,
  label.size = 3,
  node.color = 'mode',
  palette = nodeColors,
  node.size = sna::degree(dat = netTerms1),
  edge.size = 'edgeSize')+
  labs(title = "코로나 전 자영업 소상공인 단어-네트워크맵")

set.edge.value(netTerms2, attrname = 'edgeSize', value = corTerms2 * 3)
ggnet2(
  net = netTerms2,
  mode = 'fruchtermanreingold',
  layout.par = list(cell.jitter = 0.001),
  size.min = 3,
  label = TRUE,
  label.size = 3,
  node.color = 'mode',
  palette = nodeColors,
  node.size = sna::degree(dat = netTerms2),
  edge.size = 'edgeSize')+
  labs(title = "코로나 후 자영업 소상공인 단어-네트워크맵")

