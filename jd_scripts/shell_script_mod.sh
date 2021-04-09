#!/bin/sh

mergedListFile="/scripts/docker/merged_list_file.sh"
remoteListFile="/scripts/docker/remote_crontab_list.sh"

# 克隆monk-coder仓库
if [ ! -d "/monk-coder_backup/" ]; then
    echo "未检查到monk-coder仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/Aaron-lv/monk-coder_backup /monk-coder_backup
else
    echo "更新monk-coder脚本相关文件..."
    git -C /monk-coder_backup reset --hard
    git -C /monk-coder_backup pull origin dust --rebase
fi
cp -f /monk-coder_backup/car/*_*.js /scripts
cp -f /monk-coder_backup/i-chenzhe/*_*.js /scripts
cp -f /monk-coder_backup/member/*_*.js /scripts
cp -f /monk-coder_backup/normal/*_*.js /scripts
sed -i "/^$/d" $remoteListFile
cat $remoteListFile >> $mergedListFile
