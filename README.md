# Docker MinDoc

基于`debian:stable-slim`镜像，使用[MinDoc](https://github.com/lifei6671/mindoc)官方预编译的二进制文件`mindoc_linux_amd64`直接打包创建的MinDoc镜像。

优点：

- 需要拉取的总镜像体积较小
- 不需要编译主程序，构建速度快
- 支持原系统的大部分环境变量

# 使用

## 端口

镜像仅暴露`8181`端口，原系统的环境变量`MINDOC_PORT`不能使用。注意绑定宿主机端口到`8181`。

## 目录结构

```
/data
|-- conf/
|-- database/
|-- lib/
|-- mindoc_linux_amd64
|-- runtime/
|-- static/
|-- uploads/
`-- views/
```

## 文件权限

MinDoc主程序以用户`mindoc`来运行，用户UID和GID都是`1000`。可分别使用`RUNNER_UID`和`RUNNER_GID`环境变量来设置用户`mindoc`的UID和GID。

`/data`下所有文件的拥有者和用户组都是`mindoc`。如果要挂载宿主机目录到该路径下，请保证容器内外用户权限一致。

## 永久化存储

1. 数据库
   - 如果使用默认的sqlite，将`/data/database`挂载到宿主机
   - 使用外部的mysql数据库（需要做好mysql数据库的永久化存储）
2. 将文件上传目录`/data/uploads`挂载到宿主机
3. 将运行信息目录`/data/runtime`挂载到宿主机（包含mindoc运行日志等信息，可选）
