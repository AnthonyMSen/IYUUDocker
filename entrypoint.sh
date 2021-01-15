#!/bin/sh
set -e

export LANG="zh_CN.UTF-8"

if [ ! -e /IYUU/iyuu.php ] 
then
        echo "容器启动，未发现代码，正在clone中..."
        git clone https://gitee.com/ledc/IYUUAutoReseed.git /IYUU
fi

# echo "Container start , Pull the latest code..."
# echo "容器启动，git 拉取最新代码..."
# cd /IYUU && git fetch --all >> /logs/update_iyuu.log
# cd /IYUU && git reset --hard origin/master >> /logs/update_iyuu.log

echo "Load the latest crontab task file..."
echo "加载最新的定时任务文件..."
crontab /crontab_list.sh

echo "Start crontab task main process..."
echo "启动crondtab定时任务主进程..."
crond -f
