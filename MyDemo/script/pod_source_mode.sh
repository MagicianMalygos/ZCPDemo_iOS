#!/bin/bash
# 切换成源码模式

trap 'onCtrlC' INT
function onCtrlC () {
    echo 'Ctrl+C is captured'
    exit
}

#脚本运行当前目录
cur_dir=$(cd "$(dirname "$0")"; pwd)
echo '*****当前项目目录----'$cur_dir'*****'
sh clear_cocopods.sh
echo '****************Pod Update Start*************'

pods_dir=$cur_dir/Pods
echo $pods_dir
cd ~
source_dir=$(cd "$(dirname "$0")"; pwd)/HelloCode/CachePods/Source/Pods
new_source_dir=$(cd "$(dirname "$0")"; pwd)/HelloCode/CachePods/Custom/$cur_dir/Source/Pods
cd -

source_pods_dir=$source_dir/Pods
# 是否有自己的缓存
if [ -d "${new_source_dir}" ]
then
source_dir=$new_source_dir
fi

#删除已经存在的文件
if [ -d "${pods_dir}" ]
then
rm -rf "${pods_dir}"
fi
# mkdir -p "${pods_dir}"
cp -R "${source_dir}/" "${pods_dir}/"


pod update

if [ $? -ne 0 ]; then
    echo "fail"
else
    echo "success"
    sh cache_cocopods.sh
fi

echo '****************Pod Update End*************'
