# 라이브러리
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(reshape2)
library(data.table) # setdt() 사용하기 위해
library(plyr) #desc()를 사용하기 위해서 필요하다.

# 코로나 전후 청원데이터 불러오기
before <- read_csv("before_covid_petition_enc.csv")
after <- read_csv("after_covid_petition_enc.csv")
total<- rbind(before, after)

# category 확인
sort(unique(before$category))
sort(unique(after$category))
length(unique(before$category))

# 간단한 데이터 확인
summary(before)
summary(after)

# 카테고리별 청원건수 빈도와 비율 확인후 데이터프레임 생성
before_df<- cbind(freq= sort(table(before$category), decreasing =T), relative= prop.table(table(before$category)))
after_df<- cbind(freq= sort(table(after$category), decreasing =T), relative= prop.table(table(after$category)))
before_df<- data.frame(before_df)

## rownames가 카테고리로 되어있어 카테고리를 열 변수로 빼고 새로운 행이름을 설정
setDT(before_df, keep.rownames = TRUE)[]
## 변수명이 rn으로 빼진 카테고리 변수명을 category로 재설정
before_df<- rename(before_df, category=rn)
## df에 period 변수 생성
before_df<- before_df %>%
  mutate(period="before")

after_df<- data.frame(after_df)
setDT(after_df, keep.rownames = TRUE)[]
after_df<- rename(after_df, category=rn)
after_df<- after_df %>%
  mutate(period="after")

# 카테고리별 청원동의 인원수 변수 생성
temp<- before %>%
  group_by(category) %>%
  summarise(AgreeSum= sum(numOfAgrees))
before_df<- merge(before_df, temp, by='category')

temp2<- after %>%
  group_by(category) %>%
  summarise(AgreeSum= sum(numOfAgrees))
after_df<- merge(after_df, temp2, by='category')

total_df= rbind(after_df,before_df)

# 막대 그래프
# 빈도 건수
ggplot(total_df, aes(x= category, y= freq, fill=period))+
  geom_bar(stat="identity",position= position_dodge2(reverse = TRUE))+
  scale_fill_brewer(palette="Set2")+
  labs(title="코로나 전후 카테고리 별 청원 건수")+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5, face='bold', size = 15))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5 ))+
  theme(legend.text = element_text(size = 8))+
  guides(fill=guide_legend(reverse=TRUE))

ggsave("category_freq_bar.jpg", dpi = 300)   # ggplot를 저장합니다.

# 비율
ggplot(total_df, aes(x= category, y= relative, fill=period))+
  geom_bar(stat="identity",position= position_dodge2(reverse = TRUE))+
  scale_fill_brewer(palette="Set2")+
  labs(title="코로나 전후 카테고리 별 청원 비율")+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5, face='bold', size = 15))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5 ))+
  theme(legend.text = element_text(size = 8))+
  guides(fill=guide_legend(reverse=TRUE))

ggsave("category_rela_bar.jpg", dpi = 300)   # ggplot를 저장합니다.


# 파이 그래프
ggplot(before_df, aes(x="", y= -freq, fill= reorder(category,-freq)))+
  geom_bar(stat="identity")+
  coord_polar("y")+
  theme_void()+
  labs(title="코로나 전 카테고리 별 청원 건수")+
  theme(plot.title = element_text(hjust = 0.6, face='bold', size = 15))

ggsave("category_freq_before_pie.jpg", dpi = 300)   # ggplot를 저장합니다.

ggplot(after_df, aes(x="", y= -freq, fill= reorder(category,-freq)))+
  geom_bar(stat="identity")+
  coord_polar("y")+
  theme_void()+
  labs(title="코로나 후 카테고리 별 청원 건수")+
  theme(plot.title = element_text(hjust = 0.6, face='bold', size = 15))

ggsave("category_freq_after_pie.jpg", dpi = 300)   # ggplot를 저장합니다.

# 다른 파이차트
## plot the outside pie and shades of subgroups
lab <- with(before_df, sprintf('%s: %s',category, freq))
pie(before_df$freq, border = NA,
    labels = lab, cex = 0.5)


# scatter plot
ggplot(total_df, aes(x= freq, y= AgreeSum, color=category)) +
  geom_point()+
  labs(title="청원건수에 따른 청원동의 인원수")+
  theme(plot.title = element_text(hjust = 0.6, face='bold', size = 15))+
  theme_bw()
ggsave("agreesum_freq_scatter.jpg", dpi = 300) 
