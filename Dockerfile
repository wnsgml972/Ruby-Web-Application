# 1. ubuntu 설치 (패키지 업데이트 + 만든사람 표시)
FROM       ubuntu:16.04
MAINTAINER subicura@subicura.com
RUN        apt-get -y update

# 2. ruby 설치
## 2.1 명령어 최적화 qq 옵션을 통해 로그를 출력하지 않게 변경
RUN apt-get -y -qq install ruby
RUN gem install bundler

# 3. 소스 복사
# 3.1 Build 리팩토링 Gemfile을 먼저 복사함
COPY Gemfile* /usr/src/app/
# 3.2 Gem 패키지 설치 (실행 디렉토리 설정)
WORKDIR /usr/src/app
# 3.3 패키지 설치, --no-rdoc, --no-ri 옵션으로 필요없는 문서 생성하지 않아 이미지 용량 줄임
RUN bundle install --no-rdoc --no-ri
# 3.3 app 소스 복사
COPY . /usr/src/app

# 4. Sinatra 서버 실행 (Listen 포트 정의)
EXPOSE 4567
CMD    bundle exec ruby app.rb -o 0.0.0.0
