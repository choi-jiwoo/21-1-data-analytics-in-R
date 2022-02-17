# 국민 청원 게시글 감성 분석

## 분석 보고서 

보고서 내용은 [rpubs](https://rpubs.com/cho2jiwoo/802248)에서 확인해 보실 수 있습니다.

## 데이터

청원 게시글 데이터와 텍스트 분석시 사용된 데이터들을 압축해놓았습니다.

[data/data.zip](https://github.com/cho2ji/covid19-petitions-analysis/blob/master/data/data.zip)

### 2019/4/30~2021/1/20 국민 청원 게시글
- petition_data.csv

| Header        | Definition    |
| :------------ | ------------- |
| `id`          | 청원 번호       |
| `category`    | 청원 분류       |
| `title`       | 청원 제목       |
| `expiryDate`  | 청원 만료일      |
| `numOfAgrees` | 청원 참여인원    |

출처 : https://www1.president.go.kr/petitions

### 텍스트 분석시 사용한 파일
- 한국불용어100.txt
- customDic.txt
- del.txt
- negative.txt
- positive.txt
