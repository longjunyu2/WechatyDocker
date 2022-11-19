# WechatyDocker
  使用Dockerfile构建默认使用UOS版协议的WechatyGateway(Wechaty项目中用于提供除ts外的其他编程语言支持的网关服务)
## 用法
使用本项目前请阅读wechaty官方提供的文档，本项目提供的用法仅作为细节补充
在项目根目录下执行以下命令来生成docker镜像，其中<tag>替换成镜像标签，在本文中使用`wechaty:latest`作为镜像标签。
```shell
docker build -t <tag> .
```
镜像构建完成后即可创建容器，以下代码会生成一个容器，请根据自己的实际情况来修改。
```shell
docker run -d --name=wechaty-gateway --net=bridge -p 8080:8080 -v /WechatyData:/wechaty/data --restart=unless-stopped wechaty:latest
```
获取容器的ID
```shell
docker ps
```
容器首次运行后，稍等一段时间，使用以下命令查看容器的运行日志，获取微信二维码链接来扫码登录。其中<CONTAINER_ID>替换为上一步获取的ID
```shell
docker logs -f -t --tail=200 <CONTAINER_ID>
```
## 对python-wechaty使用的补充
在使用python-wechaty中我遇到了一些问题，在此提供一些我所能找到的解决方案，希望那能够有所帮助。  
1. 报错 ``` Wechaty internal error <(sqlite3.OperationalError) unable to open database file> ```
  - 降级wechaty模块到旧版本（推荐 0.8.66）
  - ``` pip3 install wechaty==0.8.66 ```
2. 报错 ``` Wechaty internal error <run_task() got an unexpected keyword argument 'use_reloader'> ```
  - 降级quart模块到旧版本（推荐 0.18.0）
  - ``` pip3 install quart==0.18.0 ```
## 引用
[wechaty/wechaty](https://github.com/wechaty/wechaty)  
[从0到1系列---微信机器人之python_wechaty_uos](https://lovehxy.com/posts/tech/%E4%BB%8E0%E5%88%B01%E7%B3%BB%E5%88%97---%E5%BE%AE%E4%BF%A1%E6%9C%BA%E5%99%A8%E4%BA%BA%E4%B9%8Bpython_wechaty_uos/)
