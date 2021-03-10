#!/bin/sh

##删掉收益太低的惊喜农场脚本任务
sed -i "/jd_jxnc/d" /scripts/docker/merged_list_file.sh

## 克隆i-chenzhe仓库
if [ ! -d "/i-chenzhe/" ]; then
    echo "未检查到i-chenzhe仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/i-chenzhe/qx /i-chenzhe
else
    echo "更新i-chenzhe脚本相关文件..."
    git -C /i-chenzhe reset --hard
    git -C /i-chenzhe pull --rebase
fi
cp -f /i-chenzhe/*_*.js /scripts

## 百变大咖秀
echo "# 百变大咖秀" >> /scripts/docker/merged_list_file.sh
echo "10 10,11 * * 1-4 node /scripts/jd_entertainment.js >> /scripts/logs/jd_entertainment.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 粉丝互动
echo "# 粉丝互动" >> /scripts/docker/merged_list_file.sh
echo "3 10 * * * node /scripts/jd_fanslove.js >> /scripts/logs/jd_fanslove.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 母婴-跳一跳
echo "# 母婴-跳一跳" >> /scripts/docker/merged_list_file.sh
echo "5 8,14,20 2-7 3 * node /scripts/jd_jump_jump.js >> /scripts/logs/jd_jump_jump.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 超级摇一摇
echo "# 超级摇一摇" >> /scripts/docker/merged_list_file.sh
echo "3 20 * * * node /scripts/jd_shake.js >> /scripts/logs/jd_shake.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东小魔方
echo "# 京东小魔方" >> /scripts/docker/merged_list_file.sh
echo "10 10 * * * node /scripts/jd_xmf.js >> /scripts/logs/jd_xmf.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东超市-大转盘
echo "# 京东超市-大转盘" >> /scripts/docker/merged_list_file.sh
echo "3 10 * * * node /scripts/z_marketLottery.js >> /scripts/logs/jd_marketLottery.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 超级品类日
echo "# 超级品类日" >> /scripts/docker/merged_list_file.sh
echo "13 8,10 8-15 3 * node /scripts/z_superDay.js >> /scripts/logs/jd_superDay.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 京东试用
if [ $jd_try_ENABLE = "Y" ]; then
    wget -O /scripts/jd_try.js https://raw.githubusercontent.com/ZCY01/daily_scripts/main/jd/jd_try.js
    echo "# 京东试用" >> /scripts/docker/merged_list_file.sh
    echo "30 10 * * * node /scripts/jd_try.js >> /scripts/logs/jd_try.log 2>&1" >> /scripts/docker/merged_list_file.sh
fi
