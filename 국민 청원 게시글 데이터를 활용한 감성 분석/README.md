# 국민 청원 게시글 감성 분석

## 분석 보고서 

보고서 내용은 [rpubs](https://rpubs.com/cho2jiwoo/802248)에서 확인해 보실 수 있습니다.

## 데이터

청원 게시글 데이터와 텍스트 분석시 사용된 데이터들을 압축해놓았습니다.

[data/data.zip](https://github.com/choi-jiwoo/21-1-data-analytics-in-R/tree/master/%EA%B5%AD%EB%AF%BC%20%EC%B2%AD%EC%9B%90%20%EA%B2%8C%EC%8B%9C%EA%B8%80%20%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%A5%BC%20%ED%99%9C%EC%9A%A9%ED%95%9C%20%EA%B0%90%EC%84%B1%20%EB%B6%84%EC%84%9D/data/data.zip)

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
