#!/bin/sh

if [[ -f /usr/bin/jd_bot && -z "$DISABLE_SPNODE" ]]; then
   CMD="spnode"
else
   CMD="node"
fi

echo "处理jd_crazy_joy_coin任务..."
if [ ! $CRZAY_JOY_COIN_ENABLE ]; then
   echo "默认启用jd_crazy_joy_coin,杀掉jd_crazy_joy_coin任务，并重启"
   eval $(ps -ef | grep "jd_crazy_joy_coin" | grep -v "grep" | awk '{print "kill "$1}')
   echo '' >/scripts/logs/jd_crazy_joy_coin.log
   $CMD /scripts/jd_crazy_joy_coin.js |ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
   echo "默认jd_crazy_joy_coin,重启完成"
else
   if [ $CRZAY_JOY_COIN_ENABLE = "Y" ]; then
      echo "配置启用jd_crazy_joy_coin,杀掉jd_crazy_joy_coin任务，并重启"
      eval $(ps -ef | grep "jd_crazy_joy_coin" | grep -v "grep" | awk '{print "kill "$1}')
      echo '' >/scripts/logs/jd_crazy_joy_coin.log
      $CMD /scripts/jd_crazy_joy_coin.js |ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
      echo "配置jd_crazy_joy_coin,重启完成"
   else
      eval $(ps -ef | grep "jd_crazy_joy_coin" | grep -v "grep" | awk '{print "kill "$1}')
      echo "已配置不启用jd_crazy_joy_coin任务,不处理"
   fi
fi

# 修改十元街定时
sed -i "s/12 8,18 \* \* \* node \/scripts\/jd_syj.js/2 8,18 \* \* \* node \/scripts\/jd_syj.js/g" /scripts/docker/merged_list_file.sh
# 修改闪购盲盒定时
sed -i "s/47 8 \* \* \* node \/scripts\/jd_sgmh.js/50 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
# 修改京东赚赚定时
sed -i "s/6 0,11 \* \* \* node \/scripts\/jd_jdzz.js/10 0-4 \* \* \* node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
# 修改京东家庭号定时
sed -i "s/10 6,7 \* \* \* node \/scripts\/jd_family.js/30 6,15 \* \* \* node \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
# 修改美丽颜究院定时
sed -i "s/41 7,12,19 \* \* \* node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
# 修改环球挑战赛定时
sed -i "s/5 6,22 \* \* \* node \/scripts\/jd_global.js/30 6,22 \* \* \* node \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
# 修改京东国际盲盒定时
sed -i "s/35 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/40 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
# 修改京东极速版红包定时
sed -i "s/45 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh

# 京喜工厂
sed -i "s/http:\/\/qr6pzoy01.hn-bkt.clouddn.com\/factory.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/raw.githubusercontent.com\/gitupdate\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/gitupdate\/updateTeam@master\/shareCodes\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
# 领京豆
sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/gitupdate\/updateTeam@master\/shareCodes\/jd_updateBeanHome.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateBeanHome.json/g" /scripts/jd_bean_home.js
# 签到领现金
sed -ie "32,33s/^[^\]*/  \`eU9YaOvnM_4k9WrcnnAT1Q@eU9Yar-3M_8v9WndniAQhA@eU9YaO-2YPUn-TzQwycVgw@ZnQya-i1Y_UmpGzUnnEX@eU9YaOiwMKklo2eGyCFG1A@eU9YaOmzbvwhozzRyCcXgg@fkFwauq3ZA@aUNmM6_nOP4j-W4@eU9Yau3kZ_4g-DiByHEQ0A\`,/g" /scripts/jd_cash.js
sed -i "s/http:\/\/qr6pzoy01.hn-bkt.clouddn.com\/jd_cash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/gitupdate\/updateTeam@master\/shareCodes\/jd_updateCash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
# 东东小窝
sed -i "s/https:\/\/cdn.jsdelivr.net\/gh\/gitupdate\/updateTeam@master\/shareCodes\/jd_updateSmallHomeInviteCode.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateSmallHomeInviteCode.json/g" /scripts/jd_small_home.js
sed -i "s/https:\/\/raw.githubusercontent.com\/LXK9301\/updateTeam\/master\/jd_updateSmallHomeInviteCode.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateSmallHomeInviteCode.json/g" /scripts/jd_small_home.js
# 京东赚赚
sed -i "s/http:\/\/qr6pzoy01.hn-bkt.clouddn.com\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
sed -i "s/https:\/\/raw.githubusercontent.com\/gitupdate\/updateTeam\/master\/shareCodes\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
