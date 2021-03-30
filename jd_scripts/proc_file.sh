#!/bin/sh

if [[ -f /usr/bin/jd_bot && -z "$DISABLE_SPNODE" ]]; then
   CMD="spnode"
else
   CMD="node"
fi

echo "处理jd_crazy_joy_coin任务。。。"
if [ ! $CRZAY_JOY_COIN_ENABLE ]; then
   echo "默认启用jd_crazy_joy_coin杀掉jd_crazy_joy_coin任务，并重启"
   eval $(ps -ef | grep "jd_crazy" | grep -v "grep" | awk '{print "kill "$1}')
   echo '' >/scripts/logs/jd_crazy_joy_coin.log
   $CMD /scripts/jd_crazy_joy_coin.js | ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
   echo "默认jd_crazy_joy_coin重启完成"
else
   if [ $CRZAY_JOY_COIN_ENABLE = "Y" ]; then
      echo "配置启用jd_crazy_joy_coin，杀掉jd_crazy_joy_coin任务，并重启"
      eval $(ps -ef | grep "jd_crazy" | grep -v "grep" | awk '{print "kill "$1}')
      echo '' >/scripts/logs/jd_crazy_joy_coin.log
      $CMD /scripts/jd_crazy_joy_coin.js | ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
      echo "配置jd_crazy_joy_coin重启完成"
   else
      eval $(ps -ef | grep "jd_crazy" | grep -v "grep" | awk '{print "kill "$1}')
      echo "已配置不启用jd_crazy_joy_coin任务，不处理"
   fi
fi

## 修改京东赚赚定时
sed -i "s/6 0,11 \* \* \* node \/scripts\/jd_jdzz.js/10 \* \* \* \* node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
## 修改闪购盲盒定时
sed -i "s/47 8 \* \* \* node \/scripts\/jd_sgmh.js/50 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
## 修改京东家庭号定时
sed -i "s/10 6,7 \* \* \* node \/scripts\/jd_family.js/30 6,15 \* \* \* node \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
## 修改美丽颜究院定时
sed -i "s/41 7,12,19 \* \* \* node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
## 修改摇京豆定时
sed -i "s/6 0,23 \* \* \* node \/scripts\/jd_club_lottery.js/5 0,20,23 \* \* \* node \/scripts\/jd_club_lottery.js/g" /scripts/docker/merged_list_file.sh
## 修改超级直播间红包雨定时
sed -i "s/30,31 20-23\/1 \* \* \* node \/scripts\/jd_live_redrain.js/0,30 20-23\/1 \* \* \* node \/scripts\/jd_live_redrain.js/g" /scripts/docker/merged_list_file.sh

## 修改环球挑战赛定时
sed -i "s/5 6,22 \* \* \* node \/scripts\/jd_global.js/30 6,22 \* \* \* node \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
## 修改京东国际盲盒定时
sed -i "s/35 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/40 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
## 修改京东极速版红包定时
sed -i "s/45 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh

# 京喜工厂参团
sed -i "s/if (cookiesArr \&\& cookiesArr.length < 2) return/if (cookiesArr \&\& cookiesArr.length < 6) return/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/raw.githubusercontent.com\/LXK9301\/updateTeam\/master\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
# 京东赚赚
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
# 签到领现金
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_cash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateCash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -ie "32,33s/^[^\]*/  \`eU9YaOvnM_4k9WrcnnAT1Q@eU9Yar-3M_8v9WndniAQhA@eU9YaO-2YPUn-TzQwycVgw@ZnQya-i1Y_UmpGzUnnEX@eU9YaOiwMKklo2eGyCFG1A@eU9YaOmzbvwhozzRyCcXgg@fkFwauq3ZA@aUNmM6_nOP4j-W4@eU9Yau3kZ_4g-DiByHEQ0A@f0JyJuW7bvQ@IhM0bu-0b_kv8W6E@eU9YKpnxOLhYtQSygTJQ@-oaWtXEHOrT_bNMMVso@eU9YG7XaD4lXsR2krgpG\`,/g" /scripts/jd_cash.js
