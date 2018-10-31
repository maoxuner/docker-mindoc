#!/bin/sh

##
# 设置运行用户
##

user=${RUNNER}
uid=${RUNNER_UID:-}
gid=${RUNNER_GID:-}

if [ "${uid}" != "" ] && [ ${uid} -ne $(id -u ${user}) ]; then
    usermod -o -u ${uid} ${user}
    change=1
fi
if [ "${gid}" != "" ] && [ ${gid} -ne $(id -g ${user}) ]; then
    groupmod -o -g ${gid} ${user}
    change=1
fi

if [ ${change:-0} -eq 1 ]; then
    chown -R ${user}:${user} /data
fi

##
# 初始化
##

runuser -u ${user} -- /data/mindoc_linux_amd64 install

##
# 入口
##
exec runuser -u ${user} -- /data/mindoc_linux_amd64
