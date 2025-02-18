#!/bin/bash

#字体颜色
BLACK=$(tput setaf 0)   #黑色
RED=$(tput setaf 1)     #红色
GREEN=$(tput setaf 2)   #绿色
YELLOW=$(tput setaf 3)  #黄色
BLUE=$(tput setaf 4)    #蓝色
MAGENTA=$(tput setaf 5) #洋红色
CYAN=$(tput setaf 6)    #青色
WHITE=$(tput setaf 7)   #白色

#背景颜色
BLACKB=$(tput setab 0)   #黑色
REDB=$(tput setab 1)     #红色
GREENB=$(tput setab 2)   #绿色
YELLOWB=$(tput setab 3)  #黄色
BLUEB=$(tput setab 4)    #蓝色
MAGENTAB=$(tput setab 5) #洋红色
CYANB=$(tput setab 6)    #青色
WHITEB=$(tput setab 7)   #白色

# 清除
RESET=$(tput sgr0)

version=$1

if [ -z $version ]; then
  echo -e "${RED} 请输入正确的版本号 ${RES}"
  exit 64
fi

docker images | grep ubuntu-chrome-jdk8 &>/dev/null
if [ $? -eq 0 ]; then
  docker rmi ubuntu-chrome-jdk8:lastest
fi

echo "${CYAN}清理以前的镜像 ${RESET}"
docker images | grep kurisu003/ubuntu-chrome-jdk8 &>/dev/null
if [ $? -eq 0 ]; then
  docker rmi kurisu003/ubuntu-chrome-jdk8:lastest
fi

echo "${CYAN}开始制作docker镜像 ${RESET}"
docker build -t ubuntu-chrome-jdk8:lastest -f ./Dockerfile .

docker images | grep kurisu003/ubuntu-chrome-jdk8 &>/dev/null
if [ $? -eq 0 ]; then
  echo "${YELLOW}开始给镜像打上tag ${RESET}"
  docker tag ubuntu-chrome-jdk8:lastest kurisu003/ubuntu-chrome-jdk8:lastest
  docker tag ubuntu-chrome-jdk8:lastest kurisu003/ubuntu-chrome-jdk8:$version

  echo "${MAGENTA}推送镜像到远程仓库 ${RESET}"
  docker push kurisu003/ubuntu-chrome-jdk8:lastest
  docker push kurisu003/ubuntu-chrome-jdk8:$version

echo "${RED}删除带版本号的镜像 ${RESET}"
  docker rmi kurisu003/ubuntu-chrome-jdk8:$version
fi

