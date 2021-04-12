# covid19-petitons-analysis
코로나19 팬데믹 이전 청와대 국민 청원과 이후 청원의 유형 변화 분석

21-1 데이터 애널리틱스 - R기반 통계 중간보고서

## Github 시작하기
참고 : https://falsy.me/%EA%B9%83%ED%97%88%EB%B8%8C-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-1-%EC%A0%80%EC%9E%A5%EC%86%8C-%EB%A7%8C%EB%93%A4%EA%B8%B0-push-%ED%95%98%EA%B8%B0/

## Github으로 협업
참고 : https://gmlwjd9405.github.io/2017/10/27/how-to-collaborate-on-GitHub-1.html

### • 처음 설정
1. git clone [중앙 원격 저장소 URL]

처음 한번만 git clone 명령어로 중앙 원격 저장소를 자신의 로컬 저장소로 복제

2. git checkout -b [branch name]

**모든 코드 작업은 생성한 자신의 branch에서 이뤄지고 나중에 master에 병합**

코드 추가를 위해 작업할 branch 생성 후 이동

### • 코드 작업
1. git add

branch에 생성/수정한 코드를 commit

2. git push

자신이 작업한 branch를 중앙 원격 저장소에 올리기

### • 코드 작업물 병합

참고 : https://wayhome25.github.io/git/2017/07/08/git-first-pull-request-story/

1. pull request

깃허브 repository 페이지에서 작업한 코드에 대해 master branch에 병합 요청

2. merge

깃허브 repository 페이지에서 병합 요청된 branch 들을 master branch와 병합

### • 코드 작업전 중앙 원격 저장소와 자신의 로컬 저장소 동기화

1. git checkout master

master branch로 이동

2. git pull origin master

**코드 작성 전 필수!! 동기화가 안되어 있으면 충돌 발생**

중앙 원격 저장소에 변경사항이 생기면 자신의 로컬 저장소를 동기화
