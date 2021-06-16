FROM ruby:2.6

# 日本語環境
RUN apt-get update
RUN apt-get install -y locales
ENV LANG C.UTF-8

# UTC -> JST
RUN apt-get install -y tzdata
RUN mv /etc/localtime /etc/localtime.bak
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 必要なもの諸々
RUN apt-get update -qq && apt-get install -y build-essential \
  libpq-dev \
  git \
  wget \
  vim \
  bison \
  openssl \
  curl \
  git-core \
  zlib1g \
  zlib1g-dev \
  libssl-dev \
  libyaml-dev \
  libsqlite3-0 \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt-dev \
  autoconf \
  libc6-dev \
  ncurses-dev \
  sudo \
  libreadline-dev \
  tree \
  chrpath \
  libssl-dev \
  libxft-dev \
  libfreetype6 \
  libfreetype6-dev \
  libfontconfig1 \
  libfontconfig1-dev \
  nodejs \
  chromium \
  chromium-common \
  chromium-driver \
  ruby-selenium-webdriver

# ==========================================================================================
# making working dir
# ==========================================================================================
RUN mkdir -p /app/log
ADD src /app
RUN cd /app && gem install bundler && bundle
WORKDIR /app