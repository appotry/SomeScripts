#!/bin/sh

# diy sh
wget -O /scripts/docker/diy.sh https://raw.githubusercontent.com/FKPYW/SomeScripts/master/Scripts/diy.sh
echo "# diy sh" >> /scripts/docker/merged_list_file.sh
echo "58 * * * * sh -x /scripts/docker/diy.sh >> /scripts/logs/diy.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 宠汪汪邀请助力
wget -O /scripts/docker/diy.sh https://raw.githubusercontent.com/FKPYW/SomeScripts/master/Scripts/jd_joyrun.js
echo "# 宠汪汪邀请助力" >> /scripts/docker/merged_list_file.sh
echo "2 9-20/2 * * * node /scripts/jd_joyrun.js >> /scripts/logs/jd_joyrun.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 修改闪购盲盒定时
sed -i "s/27 8 \* \* \* node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 8 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
## 修改京东赚赚定时
sed -i "s/10 11 \* \* \* node \/scripts\/jd_jdzz.js/10 \* \* \* \* node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/10 11 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_jdzz.js/10 \* \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
## 修改美丽颜究院定时
sed -i "s/1 7,12,19 \* \* \* node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/1 7,12,19 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh

# 百变大咖秀
wget -O /scripts/jd_entertainment.js https://raw.githubusercontent.com/i-chenzhe/qx/main/jd_entertainment.js
echo "# 百变大咖秀" >> /scripts/docker/merged_list_file.sh
echo "10 10,11 * * 1-4 node /scripts/jd_entertainment.js >> /scripts/logs/jd_entertainment.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 粉丝互动
wget -O /scripts/jd_getFanslove.js https://github.com/i-chenzhe/qx/blob/main/jd_getFanslove.js
echo "# 粉丝互动" >> /scripts/docker/merged_list_file.sh
echo "3 10 * * * node /scripts/jd_fanslove.js >> /scripts/logs/jd_fanslove.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 母婴-跳一跳
wget -O /scripts/jd_jump-jump.js https://raw.githubusercontent.com/i-chenzhe/qx/main/jd_jump-jump.js
echo "# 母婴-跳一跳" >> /scripts/docker/merged_list_file.sh
echo "5 8,14,20 2-7 3 * node /scripts/jd_jump-jump.js >> /scripts/logs/jd_jump-jump.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 超级摇一摇
wget -O /scripts/jd_shake.js https://github.com/i-chenzhe/qx/blob/main/jd_shake.js
echo "# 超级摇一摇" >> /scripts/docker/merged_list_file.sh
echo "3 20 * * * node /scripts/jd_shake.js >> /scripts/logs/jd_shake.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 京东小魔方
wget -O /scripts/jd_xmf.js https://github.com/i-chenzhe/qx/blob/main/jd_xmf.js
echo "# 京东小魔方" >> /scripts/docker/merged_list_file.sh
echo "10 10 * * * node /scripts/jd_xmf.js >> /scripts/logs/jd_xmf.log 2>&1" >> /scripts/docker/merged_list_file.sh

# 京喜工厂参团
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/raw.githubusercontent.com\/LXK9301\/updateTeam\/master\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/\(.*\/\/.*joinLeaderTuan.*\)/  await joinLeaderTuan();/g" /scripts/jd_dreamFactory.js
# 京东赚赚
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
# 签到领现金助力json
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_cash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateCash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
# 签到领现金助力码
sed -ie "32,33s/^[^\]*/  \`eU9YaOvnM_4k9WrcnnAT1Q@eU9Yar-3M_8v9WndniAQhA@eU9YaOiwMKklo2eGyCFG1A@fkFwauq3ZA@aUNmM6_nOP4j-W4@eU9Yau3kZ_4g-DiByHEQ0A@f0JyJuW7bvQ@IhM0bu-0b_kv8W6E@eU9YKpnxOLhYtQSygTJQ@-oaWtXEHOrT_bNMMVso@eU9YG7XaD4lXsR2krgpG\`,/g" /scripts/jd_cash.js
# 修改助力开关
sed -i "s/helpAu = true;/helpAu = false;/g" /scripts/jd_*.js
sed -i "s/helpAuthor = true;/helpAuthor = false;/g" /scripts/jd_*.js
