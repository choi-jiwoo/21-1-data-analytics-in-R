# 서울시 골목상권별 카페 매출액 분석

## 분석보고서

[21_1_Data_Analytics_in_R_finals_report.Rmd](https://github.com/cho2ji/21-1-data-analytics-in-R/blob/master/%EC%84%9C%EC%9A%B8%EC%8B%9C%20%EA%B3%A8%EB%AA%A9%EC%83%81%EA%B6%8C%EB%B3%84%20%EC%B9%B4%ED%8E%98%20%EB%A7%A4%EC%B6%9C%EC%95%A1%20%EB%B6%84%EC%84%9D/21_1_Data_Analytics_in_R_finals_report.Rmd)

## 데이터

분석에 사용한 골목상권 데이터, 상권코드좌표 데이터, 시군구 데이터를 압축해 놓았습니다.

[data/data.zip](https://github.com/choi-jiwoo/21-1-data-analytics-in-R/tree/master/%EC%84%9C%EC%9A%B8%EC%8B%9C%20%EA%B3%A8%EB%AA%A9%EC%83%81%EA%B6%8C%EB%B3%84%20%EC%B9%B4%ED%8E%98%20%EB%A7%A4%EC%B6%9C%EC%95%A1%20%EB%B6%84%EC%84%9D/data)

### 골목상권

"서울시 우리마을가게 상권분석서비스"에서 제공

| 한글명       | 영문파일명                         |
|------------|---------------------------------|
| 2019 추정매출| estimatedSales2019.csv          |
| 2020 추정매출| estimatedSales2020.csv          |
| 추정유동인구  | estimatedFloatingPopulation.csv |
| 상주인구     | settledPopulation.csv           |
| 직장인구     | numOfEmployee.csv               |
| 상권변화지표  | districtState.csv               |
| 소득소비     | earningsSpendings.csv           |
| 집객시설     | infrastructure.csv              |

출처 : https://data.seoul.go.kr/

### 서울시 행정구역 시군구 정보 (좌표계: WGS1984)

- sig_code.csv

출처 : https://data.seoul.go.kr/dataList/OA-11677/S/1/datasetView.do

### 서울시 우리마을가게 상권분석서비스(상권영역)

- seoulGolmok.csv

출처 : https://data.seoul.go.kr/dataList/OA-15560/S/1/datasetView.do

### 대한민국 최신 행정구역(SHP)

- [SIG/](https://github.com/cho2ji/21-1-data-analytics-in-R/tree/master/%EC%84%9C%EC%9A%B8%EC%8B%9C%20%EA%B3%A8%EB%AA%A9%EC%83%81%EA%B6%8C%EB%B3%84%20%EC%B9%B4%ED%8E%98%20%EB%A7%A4%EC%B6%9C%EC%95%A1%20%EB%B6%84%EC%84%9D/SIG)

출처 : http://www.gisdeveloper.co.kr/?p=2332
