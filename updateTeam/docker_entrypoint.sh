#!/bin/sh
set -e

#获取配置的自定义参数
if [ $1 ]; then
    run_cmd=$1
fi

# echo "更新updateTeam仓库文件..."
# cd /scripts
# git reset --hard
# git pull origin master --rebase
# cp -f /scripts/*.js /runscripts
# cp -f /scripts/*.json /runscripts

echo "更新jds仓库文件..."
cd /jds
git reset --hard
git pull origin master --rebase
echo "npm install 安装最新依赖..."
npm install --loglevel error --prefix /run

echo "------------------------------------------------执行定时任务任务shell脚本------------------------------------------------"
sh -x /jds/updateTeam/default_task.sh
echo "--------------------------------------------------默认定时任务执行完成---------------------------------------------------"

if [ $run_cmd ]; then
    echo "启动crondtab定时任务主进程..."
    crond -f
else
    echo "默认定时任务执行结束。"
fi
echo -e "\n\n"
