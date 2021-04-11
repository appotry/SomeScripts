# 每3天的23:50分清理一次日志
50 23 */3 * * rm -rf /logs/*.log

# 京喜工厂自动开团
0 * * * * cd /runscripts && node jd_jxFactoryCreateTuan.js >> /logs/jd_jxFactoryCreateTuan.log 2>&1
# 抢京豆邀请码
0 * * * * cd /runscripts && node jd_updateBeanHome.js >> /logs/jd_updateBeanHome.log 2>&1
# 领现金
0 * * * * cd /runscripts && node jd_updateCash.js >> /logs/jd_updateCash.log 2>&1
# 东东小窝邀请码
0 * * * * cd /runscripts && node jd_update_home.js >> /logs/jd_update_home.log 2>&1
# 赚京豆小程序
0 * * * * cd /runscripts && node jd_zzUpdate.js >> /logs/jd_zzUpdate.log 2>&1