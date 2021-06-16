FROM ruby:2.5.4

ENV HOME /root
USER root

# 日本語環境
RUN apt-get update
RUN apt-get install -y locales
ENV LANG C.UTF-8

# UTC -> JST
RUN apt-get install -y tzdata
RUN mv /etc/localtime /etc/localtime.bak
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 必要なもの諸々
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev git wget vim bison openssl curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev sudo libreadline-dev tree
#default-libmysqlclient-dev
# mysql
RUN apt-get update -qq && apt-get install -y mysql-client

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get update -qq && apt-get install -y nodejs

# ==========================================================================================
# 作業用のユーザ作成
# ==========================================================================================
## add user
ENV user schoo
RUN useradd -m schoo && echo "schoo:schoo" | chpasswd
RUN echo "schoo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER schoo
ENV HOME /home/schoo

# ==========================================================================================
# dockerにログインした時のユーザを指定
# ==========================================================================================
USER schoo
WORKDIR /home/schoo

# firebase
RUN sudo npm install -g firebase-tools