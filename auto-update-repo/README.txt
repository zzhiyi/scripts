用法:$auto-update-repo.sh repo所在文件夹, rpm包放在Packages子文件夹中
Usage:$auto-update-repo.sh (Where repo folder is), please put rpms in Packages subdir.

使用inotifywait监测Packages文件夹中的改动,如果有变化,则自动执行createrepo.
Using inotifywait to monitor activities inside Packages directory.
If there is activity, createrepo is executed.