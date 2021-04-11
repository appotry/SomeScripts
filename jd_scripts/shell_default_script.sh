#!/bin/sh
set -e

echo "增加一个命令组合spnode ，使用该命令spnode jd_xxxx.js 执行js脚本会读取${COOKIE_LIST}里面的jd cookie账号来执行脚本"
(
  cat <<EOF
#!/bin/sh
set -e

first=\$1
cmd=\$*
echo \${cmd/\$1/}
if [ \$1 == "conc" ]; then
    for job in \$(cat \$COOKIE_LIST | grep -v "#" | paste -s -d ' '); do
        { export JD_COOKIE=\$job && node \${cmd/\$1/}
        }&
    done
elif [ -n "\$(echo \$first | sed -n "/^[0-9]\+\$/p")" ]; then
    echo "\$(echo \$first | sed -n "/^[0-9]\+\$/p")"
    { export JD_COOKIE=\$(sed -n "\${first}p" \$COOKIE_LIST) && node \${cmd/\$1/}
    }&
elif [ -n "\$(cat \$COOKIE_LIST  | grep "pt_pin=\$first")" ];then
    echo "\$(cat \$COOKIE_LIST  | grep "pt_pin=\$first")"
    { export JD_COOKIE=\$(cat \$COOKIE_LIST | grep "pt_pin=\$first") && node \${cmd/\$1/}
    }&
else
    { export JD_COOKIE=\$(cat \$COOKIE_LIST | grep -v "#" | paste -s -d '&') && node \$*
    }&
fi
EOF
) >/usr/local/bin/spnode

chmod +x /usr/local/bin/spnode

echo "第1步定义定时任务合并处理用到的文件路径..."
defaultListFile="/scripts/docker/$DEFAULT_LIST_FILE"
echo "└──默认文件定时任务文件路径为 ${defaultListFile}"
if [ "$CUSTOM_LIST_FILE" ]; then
  customListFile="/scripts/docker/$CUSTOM_LIST_FILE"
  echo "└──自定义定时任务文件路径为 ${customListFile}"
fi
mergedListFile="/scripts/docker/merged_list_file.sh"
echo "└──合并后定时任务文件路径为 ${mergedListFile}"

echo "第2步将默认定时任务列表添加到并后定时任务文件..."
cat "$defaultListFile" >$mergedListFile

echo "第3步判断是否存在自定义任务任务列表并追加..."
if [ "$CUSTOM_LIST_FILE" ]; then
  echo "└──您配置了自定义任务文件：$CUSTOM_LIST_FILE，自定义任务类型为：$CUSTOM_LIST_MERGE_TYPE..."
  if [ -f "$customListFile" ]; then
    if [ "$CUSTOM_LIST_MERGE_TYPE" == "append" ]; then
      echo "└──合并默认定时任务文件：$DEFAULT_LIST_FILE 和 自定义定时任务文件：$CUSTOM_LIST_FILE"
      echo -e "" >>$mergedListFile
      cat "$customListFile" >>$mergedListFile
    elif [ "$CUSTOM_LIST_MERGE_TYPE" == "overwrite" ]; then
      echo "└──配置了自定义任务文件：$CUSTOM_LIST_FILE，自定义任务类型为：$CUSTOM_LIST_MERGE_TYPE..."
      cat "$customListFile" >$mergedListFile
    else
      echo "└──配置配置了错误的自定义定时任务类型：$CUSTOM_LIST_MERGE_TYPE，自定义任务类型为只能为append或者overwrite..."
    fi
  else
    echo "└──配置的自定义任务文件：$CUSTOM_LIST_FILE未找到，使用默认配置$DEFAULT_LIST_FILE..."
  fi
else
  echo "└──当前只使用了默认定时任务文件 $DEFAULT_LIST_FILE ..."
fi

echo "第4步判断是否配置了默认脚本更新任务..."
if [ $(grep -c "default_task.sh" $mergedListFile) -eq '0' ]; then
  echo "└──合并后的定时任务文件，未包含必须的默认定时任务，增加默认定时任务..."
  echo -e >>$mergedListFile
  echo "55 */1 * * * docker_entrypoint.sh >> /scripts/logs/default_task.log 2>&1" >>$mergedListFile
else
  sed -i "/default_task.sh/d" $mergedListFile
  echo "#脚本追加默认定时任务" >>$mergedListFile
  echo "55 */1 * * * docker_entrypoint.sh >> /scripts/logs/default_task.log 2>&1" >>$mergedListFile
fi

echo "第5步判断是否配置了随即延迟参数..."
if [ "$RANDOM_DELAY_MAX" ]; then
  if [ "$RANDOM_DELAY_MAX" -ge 1 ]; then
    echo "└──已设置随机延迟为 $RANDOM_DELAY_MAX , 设置延迟任务中..."
    sed -i "/\(jd_bean_sign.js\|jd_carnivalcity.js\|jd_blueCoin.js\|jd_joy_reward.js\|jd_car_exchange.js\)/!s/node/sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node/g" $mergedListFile
  fi
else
  echo "└──未配置随即延迟对应的环境变量，故不设置延迟任务..."
fi

echo "第6步判断是否配置自定义shell执行脚本..."
sh -x /jds/jd_scripts/shell_mod_script.sh

echo "第7步执行proc_file.sh脚本任务..."
sh -x /scripts/docker/proc_file.sh

echo "第8步判断是否配置了不运行的脚本..."
if [ $DO_NOT_RUN_SCRIPTS ]; then
    echo "您配置了不运行的脚本：$DO_NOT_RUN_SCRIPTS"
    arr=${DO_NOT_RUN_SCRIPTS//&/ }
    for item in $arr; do
        sed -ie "s/^[^\]*${item}.js*/#&/g" $mergedListFile
    done
fi

echo "第9步增加 |ts 任务日志输出时间戳..."
sed -i "/\( ts\| |ts\|| ts\)/!s/>>/\|ts >>/g" $mergedListFile

sed -i "/\(>&1 &\|> &1 &\)/!s/>&1/>\&1 \&/g" $mergedListFile

echo "第10步判断是否需要生成${COOKIE_LIST}文件"
if [ 0"$JD_COOKIE" = "0" ]; then
  if [ -f "$COOKIE_LIST" ]; then
    echo "└──未配置JD_COOKIE环境变量，${COOKIE_LIST}文件已存在,请将cookies写入${COOKIE_LIST}文件，格式每个Cookie一行"
  else
    echo '' >"$COOKIE_LIST"
    echo "└──未配置JD_COOKIE环境变量，且${COOKIE_LIST}文件不存在，已为你生成,请将cookies写入${COOKIE_LIST}文件，格式每个Cookie一行"
  fi
else
  if [ -f "$COOKIE_LIST" ]; then
    echo "└──cookies.conf文件已经存在跳过,如果需要更新cookie请修改${COOKIE_LIST}文件内容"
  else
    echo "└──环境变量 cookies写入${COOKIE_LIST}文件,如果需要更新cookie请修改cookies.list文件内容"
    echo "$JD_COOKIE" | sed "s/\( &\|&\)/\\n/g" >"$COOKIE_LIST"
  fi
fi

echo "第11步加载最新的定时任务文件..."
crontab -l >/scripts/befor_cronlist.sh
crontab $mergedListFile

echo "第12步将仓库的docker_entrypoint.sh脚本更新至系统/usr/local/bin/docker_entrypoint.sh内..."
cat /jds/jd_scripts/docker_entrypoint.sh >/usr/local/bin/docker_entrypoint.sh

echo "最后加载最新的附加功能定时任务文件..."
echo "└──替换任务列表的node指令为spnode"
sed -i "s/ node / spnode /g" $mergedListFile
sed -i "/jd_carnivalcity/s/>>/>/g" $mergedListFile
crontab $mergedListFile

# echo "第11步打包脚本文件到/scripts/logs/scripts.tar.gz"
# apk add tar
# tar -zcvf /scripts/logs/scripts.tar.gz --exclude=scripts/node_modules --exclude=scripts/logs/*.log  --exclude=scripts/logs/*.gz /scripts
#!/bin/sh
