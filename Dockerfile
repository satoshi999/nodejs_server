FROM centos:7
MAINTAINER Satoshi <xxxx@gmail.com>

RUN echo 'epelリポジトリをインストール'
RUN yum install -y epel-release
