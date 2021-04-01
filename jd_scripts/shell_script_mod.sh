#!/bin/sh

## 克隆i-chenzhe仓库
if [ ! -d "/dust/" ]; then
    echo "未检查到dust仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/monk-coder/dust.git /dust
else
    echo "更新dust脚本相关文件..."
    git -C /dust reset --hard
    git -C /dust pull origin dust --rebase
fi

cp -f /dust/car/*_*.js /scripts
cp -f /dust/i-chenzhe/*_*.js /scripts
cp -f /dust/normal/*_*.js /scripts
cat /jds/jd_scripts/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

if [ ! -f "/scripts/jd_live_lottery_social.js" ]; then
    echo "未检查到live_lottery脚本..."
else
    echo "检查到live_lottery脚本..."
    echo "# 直播间抽奖" >> /scripts/docker/merged_list_file.sh
    echo "20 23 */4 * * node /scripts/jd_live_lottery_social.js >> /scripts/logs/jd_live_lottery_social.log 2>&1" >> /scripts/docker/merged_list_file.sh
fi
