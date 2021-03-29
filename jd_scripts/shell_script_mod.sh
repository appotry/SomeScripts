#!/bin/sh

## 克隆i-chenzhe仓库
if [ ! -d "/dust/" ]; then
    echo "未检查到dust仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/monk-coder/dust.git /dust
else
    echo "更新dust脚本相关文件..."
    git -C /i-chenzhe reset --hard
    git -C /i-chenzhe pull origin dust --rebase
fi
cp -f /dust/i-chenzhe/*.js /scripts
cp -f /dust/normal/*.js /scripts
cat /dust/i-chenzhe/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

echo "# 店铺大转盘" >> /scripts/docker/merged_list_file.sh
echo "20 0,10,23 * * * node /scripts/monk_shop_lottery.js >> /scripts/logs/monk_shop_lottery.log 2>&1" >> /scripts/docker/merged_list_file.sh

if [ ! -d "/scripts/jd_live_lottery_social.js" ]; then
    echo "未检查到live_lottery脚本..."
else
    echo "检查到live_lottery脚本..."
    echo "# 直播间抽奖" >> /scripts/docker/merged_list_file.sh
    echo "20 11,23 * * * node /scripts/jd_live_lottery_social.js >> /scripts/logs/jd_live_lottery_social.log 2>&1" >> /scripts/docker/merged_list_file.sh
fi
