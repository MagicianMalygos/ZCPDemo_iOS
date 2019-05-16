#脚本运行当前目录hello
cur_dir=$(cd "$(dirname "$0")"; pwd)


pods_dir=$cur_dir'/Pods'
pods_podfile_dir=$cur_dir'/Podfile.lock'

is_frameworks=0

for file in $pods_dir/*; do
file_name=${file##*/}

if [[ $file_name == *SDK ]];
then
continue
fi

if [[ $file_name == JY* ]];
then

if [[ $file_name == JYMapKit ]];
then
continue
fi

if [[ $file_name == JYResourceStorer ]];
then
continue
fi


library=$pods_dir'/'$file_name

framework=$file_name.framework
framework_release=/Framework/Release/$framework
framework_path=$(find $library -name $framework)
result=$(echo $framework_path | grep "${framework_release}")

#framework
if [[ "$result" != "" ]]
then

cd ~
home_dir=$(cd "$(dirname "$0")"; pwd)/HelloCode/CachePods/Custom/$cur_dir/Framework
cd $cur_dir
home_pods_dir=$home_dir

#删除已经存在的文件
if [ -d "${home_pods_dir}" ]
then
rm -rf "${home_pods_dir}"
fi
mkdir -p "${home_pods_dir}"
cp -R "${pods_dir}/" "${home_pods_dir}/Pods"


home_podfile_dir=$home_dir/Podfile.lock
if [ -d "${home_podfile_dir}" ]
then
rm -f "${home_podfile_dir}"
fi

cp $pods_podfile_dir $home_podfile_dir

echo '缓存framework pods成功'
is_frameworks=1
break
fi

fi
done

if [ $is_frameworks -eq 0 ]
then
#source
cd ~
source_dir=$(cd "$(dirname "$0")"; pwd)/HelloCode/CachePods/Custom/$cur_dir/Source
cd $cur_dir

source_pods_dir=$source_dir
#删除已经存在的文件
if [ -d "${source_pods_dir}" ]
then
rm -rf "${source_pods_dir}"
fi
mkdir -p "${source_pods_dir}"
cp -R "${pods_dir}/" "${source_pods_dir}/Pods"


source_podfile_dir=$source_dir/Podfile.lock
if [ -d "${source_podfile_dir}" ]
then
rm -rf "${source_podfile_dir}"
fi
cp $pods_podfile_dir $source_podfile_dir

echo '缓存source pods成功'

fi
