#!/bin/sh
set -e

mergedListFile="/scripts/docker/merged_list_file.sh"
remoteListFile="/jds/jd_scripts/remote_crontab_list.sh"

echo "附加功能1，使用jds仓库的gen_code_conf.list文件"
cp /jds/jd_scripts/gen_code_conf.list "$GEN_CODE_LIST"

echo "附加功能2，拉取monk-coder仓库的代码，并增加相关任务"
if [ ! -d "/monk/" ]; then
    echo "未检查到monk-coder仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/Aaron-lv/monk-coder_backup /monk
else
    echo "更新monk-coder脚本相关文件..."
    git -C /monk reset --hard
    git -C /monk pull origin dust --rebase
fi

if [ -n "$(ls /monk/car/*_*.js)" ]; then
  cp -f /monk/car/*_*.js /scripts
fi
if [ -n "$(ls /monk/i-chenzhe/*_*.js)" ]; then
  cp -f /monk/i-chenzhe/*_*.js /scripts
fi
if [ -n "$(ls /monk/member/*_*.js)" ]; then
  cp -f /monk/member/*_*.js /scripts
fi
if [ -n "$(ls /monk/normal/*_*.js)" ]; then
  cp -f /monk/normal/*_*.js /scripts
fi
sed -i "/^$/d" $remoteListFile
cat $remoteListFile >> $mergedListFile

# 修改赚金豆定时
sed -i "s/12 8,18 \* \* \* spnode \/scripts\/jd_syj.js/2 8,18 \* \* \* spnode \/scripts\/jd_syj.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/12 8,18 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_syj.js/2 8,18 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_syj.js/g" /scripts/docker/merged_list_file.sh
# 修改闪购盲盒定时
sed -i "s/47 8 \* \* \* spnode \/scripts\/jd_sgmh.js/50 8,23 \* \* \* spnode \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/47 8 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_sgmh.js/50 8,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
# 修改京东赚赚定时
sed -i "s/6 0,11 \* \* \* spnode \/scripts\/jd_jdzz.js/10 0-4 \* \* \* spnode \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/6 0,11 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_jdzz.js/10 0-4 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
# 修改京东家庭号定时
sed -i "s/10 6,7 \* \* \* spnode \/scripts\/jd_family.js/30 6,15 \* \* \* spnode \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/10 6,7 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_family.js/30 6,15 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
# 修改美丽颜究院定时
sed -i "s/41 7,12,19 \* \* \* spnode \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* spnode \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/41 7,12,19 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
# 修改环球挑战赛定时
sed -i "s/5 6,22 \* \* \* spnode \/scripts\/jd_global.js/30 6,22 \* \* \* spnode \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/5 6,22 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_global.js/30 6,22 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
# 修改京东国际盲盒定时
sed -i "s/35 7,12,23 \* \* \* spnode \/scripts\/jd_global_mh.js/40 7,12,23 \* \* \* spnode \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/35 7,12,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_global_mh.js/40 7,12,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
# 修改京东极速版红包定时
sed -i "s/45 0,23 \* \* \* spnode \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* spnode \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/45 0,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); spnode \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh

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
