FROM centos:7
MAINTAINER Satoshi <satoshi.hiranoz@gmail.com>

RUN echo 'epelリポジトリをインストール'
RUN yum install -y epel-release
