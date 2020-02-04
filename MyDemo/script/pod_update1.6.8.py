#!/usr/bin/env python
# -*- coding: utf-8 -*-
#0.1.0
import os
import sys
import os.path
import shutil
import xml.dom.minidom

def main():
    # os.getcwd() 方法用于返回当前工作目录
    current_path = os.getcwd()
    print('当前所在路径：' + current_path)
    print('')

    # 把当前分支的代码拉成最新的
    current_repo_current_branchs = os.popen('git symbolic-ref --short -q HEAD').readlines()
    if len(current_repo_current_branchs) > 0:
        current_branch = current_repo_current_branchs[0]
        os.system('git pull origin ' + current_branch)
        print('当前仓库代码已是最新')
        print('')

    hello_code_path = os.environ['HOME']+ '/' + 'HelloCode/'
    
    if os.path.exists(hello_code_path):
        print ('')
    else:
        os.mkdir(hello_code_path)

    podfiles_path = hello_code_path + 'Manifest_iOS/Podfiles/'
    podfile_path = hello_code_path + 'Manifest_iOS/Podfiles/Podfile'
    
    # 检查 podfile_path
    func_check_podfile_path(podfile_path, hello_code_path, current_path)

    # 设置 manifest_branch
    manifest_branch = ''
    is_update = True
    is_source = False
    if len(sys.argv) > 1:
        manifest_branch = sys.argv[1].split('/')[-1]
        if len(sys.argv)>2:
            is_update = False
            if len(sys.argv)>3:
                is_source = True
    else:
        manifest_branch = os.popen('git symbolic-ref --short -q HEAD').readlines()[0]

    # 使 Manifest_iOS 仓库分支最新
    manifest_path = hello_code_path + 'Manifest_iOS'
    os.chdir(manifest_path)
    os.system('git reset --hard')
    os.system('git clean -xdf')
    os.system('git checkout .')
    os.system('git pull origin')

    # 拿 Manifest_iOS 远端所有分支
    manifest_all_branch = []
    remotes_origin_all_branch = os.popen('git branch -a | head -1000')
    for remotes_origin_branch in remotes_origin_all_branch:
        remotes_origin_branch_arr = remotes_origin_branch.split('/')
        if len(remotes_origin_branch_arr) == 3:
            branch = remotes_origin_branch_arr[2].replace('\n', '')
            manifest_all_branch.append(branch.strip())

    os.chdir(current_path)

    print('Manifest_iOS 所有分支：')
    print(manifest_all_branch)
    print('')
    
    if manifest_branch.strip() not in manifest_all_branch:
        manifest_branch = 'master'
    else:
        print('')
        
    os.chdir(manifest_path)
    os.system('git checkout ' + manifest_branch)
    print('git checkout ' + manifest_branch)
    os.system('git pull origin ' + manifest_branch)
    print('Manifest_iOS 仓库，分支已是最新：' + manifest_branch)

    
    if is_source == True:
        is_update = True
        shutil.copyfile(os.path.join(current_path,'changeSource.sh'), podfiles_path+'changeSource.sh')
        os.chdir(podfiles_path)
        os.system('sh changeSource.sh ' + manifest_branch)
        
    os.chdir(current_path)


    print('Manifest_iOS 仓库当前选择的分支是：' + manifest_branch)

    func_clone_hellotrip(hello_code_path, current_path, manifest_branch)

    print('准备使用的 Podfile 的路径为：' + podfile_path)
    print('')

    print('所有的代码仓库和对应的分支：')
    git_sever_address_and_branch_dict = func_read_podfile(podfile_path)
    print(git_sever_address_and_branch_dict)
    print('')

    current_repo_git_sever = os.popen('git remote -v').readlines()[0].split(' ')[0].split('\t')[1]
    print('当前仓库关联的服务器地址：' + current_repo_git_sever)
    print('')

    git_source_name_list = []
#    拉代码
    for git_sever_address in git_sever_address_and_branch_dict.keys():

        git_sever_address_list = git_sever_address.strip().split('/')
        git_sever_address_last_word = git_sever_address_list[len(git_sever_address_list) - 1]

        current_repo_git_sever_list = current_repo_git_sever.strip().split('/')
        current_repo_git_sever_last_word = current_repo_git_sever_list[len(current_repo_git_sever_list) - 1]

        if (git_sever_address_last_word != current_repo_git_sever_last_word):
            path = func_git_clone_code(git_sever_address,git_sever_address_and_branch_dict[git_sever_address])
            git_source_name_list.extend(func_project_name(path))

    private_specs_repo_path = os.environ['HOME'] + '/.cocoapods/repos/hellobike-torrent-iosprivatespecsrepo'
    if os.path.exists(private_specs_repo_path):
        print('')
        os.chdir(private_specs_repo_path)
        os.system('git pull origin master')
        print('iOSPrivateSpecsRepo 已是最新')
        print('')
    
    private_specs_repo_path = os.environ['HOME'] + '/.cocoapods/repos/hellobike-torrent-cocoapods_ios'
    if os.path.exists(private_specs_repo_path):
        print('')
        os.chdir(private_specs_repo_path)
        os.system('git pull origin master')
        print('Cocoapods_iOS 已是最新')
        print('')

    os.chdir(current_path)
    project_podfile_path = func_project_podfile_path(current_path)
    func_rewrite_podfile(git_source_name_list,podfile_path,project_podfile_path)


    ###############设置framework######################
    func_git_clone_code_not_branch('http://gitlab.hellobike.cn/Torrent/CachePods.git')
    os.chdir(current_path)
    if is_update:
        os.system('pod update')



def func_read_podfile(podfile_path):

    read_file_Handle = open(podfile_path)
    podfile_contents = read_file_Handle.read()
    read_file_Handle.close()

    podfile_contents_list = podfile_contents.split('\n')

    dict = {}

    for podfile_row in podfile_contents_list:

        if 'pod' in podfile_row and ':git =>' in podfile_row:
            
            git_sever_address = podfile_row.split('=>')[1].split(',')[0].replace(' \'', '').replace('\'', '')
#            print(git_sever_address)
#            print('======================')

#            git_repo_name = podfile_row.split(',')[1].split('=>')[1].split('/')[-1][:-1].split('.')[0]
            git_branch_name = podfile_row.split(',')[2].split('=>')[1]

            dict[git_sever_address] = git_branch_name
    return dict

def func_clone_hellotrip(path_go_back,current_path,manifest_branch):

    print('❤️ ==================================================================❤️')
    print('❤️ ==============================更新主工程===========================❤️')

    hellotrip_path = path_go_back + 'HelloTrip_iOS_New'

    if os.path.exists(hellotrip_path):
        print (hellotrip_path + '  hellotrip已存在')
    else:
        os.chdir(path_go_back)
        os.system('git clone http://gitlab.hellobike.cn/Torrent/HelloTrip_iOS_New.git')

    os.chdir(hellotrip_path)
    os.system('git stash')
    os.system('git fetch')
    os.system('git reset --hard')
    
    results = os.system('git checkout ' + manifest_branch)
    print ('执行结果')
    print (results)
    print('HelloCode HelloTrip_iOS_New 仓库，分支已是最新：' + os.popen('git symbolic-ref --short -q HEAD').readlines()[0])
    
    if results == 0:
        os.system('git pull origin ' + manifest_branch)
        print('HelloCode 0 HelloTrip_iOS_New 仓库，分支已是最新：' + os.popen('git symbolic-ref --short -q HEAD').readlines()[0])
    else:
        os.system('git checkout master')
        os.system('git pull origin master')
        print('HelloCode HelloTrip_iOS_New 仓库，分支已是最新：' + os.popen('git symbolic-ref --short -q HEAD').readlines()[0])

    
    hellotrip_replace_path =  hellotrip_path + '/EasyBike'

    if 'HelloTrip_iOS_New' in current_path or 'EasyBikeiOS' in current_path :
        os.chdir(current_path)
        #os.system('git checkout ' + manifest_branch)
        #os.system('git pull origin ' + manifest_branch)
        # print('HelloTrip_iOS_New 仓库，分支已是最新：' + os.popen('git symbolic-ref --short -q HEAD').readlines()[0])
        return

    func_copy_files(hellotrip_replace_path,current_path)
    os.chdir(current_path)

def func_copy_files(hellotrip_replace_path, current_path):
    os.system('ditto ' + hellotrip_replace_path + ' ' + current_path)

def func_check_podfile_path(podfile_path, manifest_path_go_back, current_path):

    if os.path.exists(podfile_path):
        print (podfile_path + ' 已存在')
    else:
        os.chdir(manifest_path_go_back)
        os.system('git clone http://gitlab.hellobike.cn/Torrent/Manifest_iOS.git')
        os.chdir(current_path)


def func_git_clone_code_not_branch(git_repo_sever):
    current_path = os.getcwd()
    
    os.chdir(os.environ['HOME'])
    hello_code_path = os.getcwd() + '/' + 'HelloCode'
    if os.path.exists(hello_code_path):
        print ('')
    else:
        os.mkdir(hello_code_path)
    
#    os.chdir() 方法用于改变当前工作目录到指定的路径。
    os.chdir(hello_code_path)
    
    project_branch_split = git_repo_sever.split('/')
    project_name = project_branch_split[len(project_branch_split) - 1].replace('.git', '')

#    print(project_name)

    if os.path.exists(os.getcwd() + '/' + project_name):
        os.chdir(os.getcwd() + '/' + project_name)
    else:
        os.system('git clone ' + git_repo_sever)
        os.chdir(os.getcwd() + '/' + project_name)
    

def func_git_clone_code(git_repo_sever, project_branch):
    
    current_path = os.getcwd()
    
    os.chdir(os.environ['HOME'])
    hello_code_path = os.getcwd() + '/' + 'HelloCode'
    if os.path.exists(hello_code_path):
        print ('')
    else:
        os.mkdir(hello_code_path)
    
#    os.chdir() 方法用于改变当前工作目录到指定的路径。
    os.chdir(hello_code_path)
    
    project_branch_split = git_repo_sever.split('/')
    project_name = project_branch_split[len(project_branch_split) - 1].replace('.git', '')

#    print(project_name)

    if os.path.exists(os.getcwd() + '/' + project_name):
        os.chdir(os.getcwd() + '/' + project_name)
    else:
        os.system('git clone ' + git_repo_sever)
        os.chdir(os.getcwd() + '/' + project_name)
    
    print('❤️ ==================================================================❤️')
    os.system('git status')
    os.system('git stash')
    os.system('git reset --hard')
    print('git stash')
    print('')

 
    os.system('git tag -l | xargs git tag -d')
    os.system('git fetch')
    os.system('git checkout master')
    os.system('git pull origin master')
    os.system('git checkout ' + project_branch)
    print('git checkout' + project_branch)
    print('')
    
    
    current_repo_current_branchs = os.popen('git symbolic-ref --short -q HEAD').readlines()
    if len(current_repo_current_branchs) > 0:
        project_branch = current_repo_current_branchs[0]
        
        
        os.system('git fetch --all')
        os.system('git reset --hard origin/'+project_branch)
        os.system('git pull origin ' + project_branch)
        print('git pull origin' + project_branch)
        print('')
    

    os.system('git log --stat -2 | head -30')
    print('git log --stat -2 | head -30')
    print('')

    # project_branch = os.popen('git symbolic-ref --short -q HEAD').readlines()[0]
    # print('当前的仓库是 👉 ' + git_repo_sever + ' 分支是 👉 ' + project_branch)

    path = os.getcwd()
    os.chdir(current_path)
    return path

def func_rewrite_podfile(git_source_name_list, podfile_path,project_podfile_path):
    old_path = os.getcwd()
    branch_name_list = []

    for git_source_name in git_source_name_list:
        list = git_source_name.split('/')
        list.pop()
        path = '/'.join(list)
        os.chdir(path)
        # branch_name = os.popen('git symbolic-ref --short -q HEAD').readlines()[0]
        # branch_name_list.append(branch_name)

    os.chdir(old_path)

    read_file_Handle = open(podfile_path)
    podspec_contents = read_file_Handle.read()
    read_file_Handle.close()

    podspec_contents_list = podspec_contents.split('\n')
    
    new_podspec_contents = ''
    
    for podspec_row in podspec_contents_list:
        
        if ':git' in podspec_row:
            podspec_row = podspec_row.split(':git')[0] + ':path => \'../../\''

        index = 0
        for git_source_name in git_source_name_list:
            list = git_source_name.split('/')
            source_name = '\'' + list[len(list) - 1] + '\''
            source_name = source_name.replace('.podspec', '')
            if source_name in podspec_row:
                if ':git' in podspec_row or ':path' in podspec_row:
                    del list[len(list) - 1]
                    str1 = '/'.join(list) + '/'
                    str1 = str1.replace(os.environ['HOME'],'~')
                    podspec_row = '    pod '+ source_name +', :path => \''+str1+'\'' + '#当前指定的分支：' #+ branch_name_list[index]

            index = index + 1
    
        if new_podspec_contents == '':
            new_podspec_contents = podspec_row
        else:
            new_podspec_contents = new_podspec_contents + '\n' + podspec_row
            
    write_file_Handle = open(project_podfile_path,'w')
    write_file_Handle.write(new_podspec_contents)
    write_file_Handle.close()

def func_project_podfile_path(current_path):
    project_path = current_path + '/Podfile'
    if os.path.exists(project_path):
        return project_path
    else:
        print ('没有找到 Podfile 文件！请放入到开发项目的 Podfile 同级目录')
        return ('')

def func_project_name(file_dir):
    project_name_list = []
    for root, dirs, files in os.walk(file_dir):
        for file in files:
            if '.podspec' in file:
                project_name_list.append(file_dir + '/' + file)
            else:
                continue
        break
    return project_name_list

def func_project_xcodeproj_name(file_dir):
    project_name_list = []
    for root, dirs, files in os.walk(file_dir):
        for folder in dirs:
            if '.xcodeproj' in folder:
                return folder.replace('.xcodeproj','')
            else:
                continue


if __name__ == '__main__':
    main()
