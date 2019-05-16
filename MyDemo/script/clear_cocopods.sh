# 切换成源码模式

#脚本运行当前目录
cur_dir=$(cd "$(dirname "$0")"; pwd)

sudo rm -fr ~/Library/Caches/CocoaPods/

lock=$cur_dir'/Podfile.lock'
pods_dir=$cur_dir'/Pods'

#删除已经存在的文件
rm -f "${lock}"

for file in $pods_dir/*; do
file_name=${file##*/}

if [[ $file_name == *SDK ]];
then
continue
fi

if [[ $file_name == JYMapKit ]];
then
continue
fi

if [[ $file_name == JYResourceStorer ]];
then
continue
fi

if [[ $file_name == JY* ]];
then
rm -rf "${file}"
fi
done

cd ~
source_dir=$(cd "$(dirname "$0")"; pwd)/HelloCode/CachePods/Custom/$cur_dir
cd -

framework_pods_dir=$source_dir/Framework/Pods
source_pods_dir=$source_dir/Source/Pods

for file in $framework_pods_dir/*; do
file_name=${file##*/}

if [[ $file_name == *SDK ]];
then
continue
fi

if [[ $file_name == JYMapKit ]];
then
continue
fi

if [[ $file_name == JYResourceStorer ]];
then
continue
fi

if [[ $file_name == JY* ]];
then

h=$(find $file -name *.h)
# h=$(find $library -name $file_name.h)

if [  -z "$h" ]; then 
    rm -fr $file
fi

fi
done



for file in $source_pods_dir/*; do
file_name=${file##*/}

if [[ $file_name == *SDK ]];
then
continue
fi

if [[ $file_name == JYMapKit ]];
then
continue
fi

if [[ $file_name == JYResourceStorer ]];
then
continue
fi

if [[ $file_name == JY* ]];
then

h=$(find $file -name *.h)
# h=$(find $library -name $file_name.h)

if [  -z "$h" ]; then 
    rm -fr $file
fi

fi
done

