FROM satoshizzz/centos-ssh:latest
#FROM centos:latest
MAINTAINER Satoshi <xxxx@gmail.com>

RUN echo 'epelリポジトリをインストール'
RUN yum install -y epel-release


RUN echo 'npmインストール'
RUN yum install -y npm --enablerepo=epel
RUN npm -v

RUN echo 'nコマンド経由でnodejsインストール'
RUN npm install -g n
RUN n stable

RUN echo 'js2coffeeをインストール'
RUN npm install -g js2coffee

RUN echo 'expressインストール'
RUN npm install -g express
RUN npm install -g express-generator

ENV project_name=${project_name:-'myApp'}
RUN echo $project_name'プロジェクト作成'; \
	express /var/$project_name; \
	cd /var/$project_name; \
	echo 'coffeescriptに変換'; \
	find . -type f -name "*.js" | while read f; do js2coffee "$f" > "${f%.*}.coffee"; done; \
	find . -type f -name "*.js" | xargs rm -f; \
	echo 'coffee scriptインストール'; \
	echo 'package.jsonにcoffeescirpt追加'; \
	npm install coffee-script --save; \
	echo '依存モジュールインストール'; \
	npm install; \
	sed -i -e "2i require('coffee-script/register');" bin/www;

RUN echo 'RUN時に起動'
#RUN echo 'RUN時のコマンドに以下を指定する'
#RUN echo "/bin/sh -c 'cd /var/$project_name && npm start && /usr/sbin/sshd -D'"
CMD /usr/sbin/sshd && cd /var/$project_name && npm start
RUN echo '終了'