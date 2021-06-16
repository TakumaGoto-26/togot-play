FROM amazonlinux:2016.09

# docker build -t dev-schoo:latest -f schoo.Dockerfile .

ENV ruby_ver="2.1.5"
ENV bundler_ver="1.7.9"
ENV user_name="schoo"

# set locale
RUN yum -y update && yum reinstall -y glibc-common && yum clean all
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git make autoconf automake patch wget net-tools curl curl-devel sudo sysvinit-tools lsof
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2 mariadb mariadb-devel redis crontabs
RUN yum -y install ibus-kkc vlgothic-*
RUN yum clean all

# editor install
RUN yum install -y vim && yum clean all

# add user
RUN useradd -m schoo && echo "schoo:schoo" | chpasswd
RUN echo -e "schoo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R schoo:schoo /home/schoo

# docker centos対応
# c.f) https://qiita.com/mats16/items/59615a169a45884c2548
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# --------------------------------------------------------------------------------------------
USER schoo

RUN sudo yum -y update
# install ruby
RUN sudo yum -y install ruby22 ruby22-devel
#RUN sudo yum -y install nodejs --enablerepo=epel
RUN sudo gem install bundler -v 1.7.9 --no-document --force
RUN sudo yum clean all

# nginx用
RUN sudo yum -y update
RUN sudo yum -y install nginx
ADD setting/nginx/nginx.conf /etc/nginx/nginx.conf
ADD setting/nginx/app.conf /etc/nginx/conf.d/default.conf
RUN sudo yum clean all

# MySQL
RUN sudo yum -y install mysql56 mysql56-devel

# PHP
RUN sudo yum -y update
RUN sudo yum install -y php54 php54-devel php54-mbstring php54-mysql php54-xml php54-mcrypt php54-zip php54-pecl-redis php54-pecl-apc php54-pecl-apc-devel php54-pecl-xdebug php54-fpm
RUN sudo yum clean all
ADD setting/php/php.ini /etc/php.ini
ADD setting/php/php-fpm.conf /etc/php-fpm.conf
ADD setting/php/www.conf /etc/php-fpm.d/www.conf

# tmp
RUN mkdir -p /home/schoo/tmp

# npm
# https://qiita.com/leomaro7/items/2c3a767bbbb6cc535b19
# RUN sudo curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
RUN sudo curl -sL https://rpm.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo yum install -y gcc-c++ make
RUN sudo yum install -y nodejs

RUN mkdir -p /home/schoo/share/htdocs
WORKDIR /home/schoo/share/htdocs

# 起動用のscript
ADD setting/start.sh /home/schoo/start.sh
RUN sudo chmod +x /home/schoo/start.sh