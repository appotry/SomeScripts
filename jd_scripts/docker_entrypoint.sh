#!/bin/sh
set -e

function initNodeEnv() {
  echo "安装执行脚本需要的nodejs环境及依赖"
  apk add --update nodejs moreutils npm curl jq
}

#获取配置的自定义参数,如果有为
if [ "$1" ]; then
  initNodeEnv
  run_cmd=$1
fi
[ -f /scripts/package.json ] && before_package_json=$(cat /scripts/package.json)

if [ -f "/scripts/logs/pull.lock" ]; then
  echo "存在更新锁定文件，跳过git pull操作..."
else
  echo "设定远程仓库地址..."
  cd /scripts
  git remote set-url origin "$REPO_URL"
  git reset --hard
  echo "git pull拉取最新代码..."
  git -C /scripts pull --rebase
  if [ ! -d /scripts/node_modules ]; then
    echo "容器首次启动，执行npm install..."
    npm install --loglevel error --prefix /scripts
  else
    if [[ "${before_package_json}" != "$(cat /scripts/package.json)" ]]; then
      echo "package.json有更新，执行npm install..."
      npm install --loglevel error --prefix /scripts
    else
      echo "package.json无变化，跳过npm install..."
    fi
  fi
fi

#任务脚本shell仓库
cd /jds
git pull origin master --rebase

#默认启动telegram交互机器人的条件
#确认容器启动时调用的docker_entrypoint.sh
#必须配置TG_BOT_TOKEN、TG_USER_ID，
#且未配置DISABLE_BOT_COMMAND禁用交互，
#且未配置自定义TG_API_HOST，因为配置了该变量，说明该容器环境可能并不能科学的连到telegram服务器
if [[ -n "$run_cmd" && -n "$TG_BOT_TOKEN" && -n "$TG_USER_ID" && -z "$DISABLE_BOT_COMMAND" && -z "$TG_API_HOST" ]]; then
    ENABLE_BOT_COMMAND=True
else
    ENABLE_BOT_COMMAND=False
fi

echo "------------------------------------------------执行定时任务任务shell脚本------------------------------------------------"
sh /jds/jd_scripts/shell_default_script.sh "$ENABLE_BOT_COMMAND" "$run_cmd"
echo "--------------------------------------------------默认定时任务执行完成---------------------------------------------------"

if [ "$run_cmd" ]; then
  if [ "$ENABLE_BOT_COMMAND" == "True" ]; then
    if [ "$run_cmd" == 'jdbot' ]; then
      # 启动jdbot安装依赖等操作操作放到后台，不耽阻塞定crontab启动工作
      echo "后台启动jdbot程序..."
      sh "$BOT_DIR/jdbot.sh" >>"$LOGS_DIR/jdbot_start.log" 2>&1 &
    fi
    echo "启动crontab定时任务主进程..."
    crond -f
  else
    echo "启动crontab定时任务主进程..."
    crond -f
  fi
else
  echo "默认定时任务执行结束。"
fi
