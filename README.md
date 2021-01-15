# IYUUDocker

使用方式：

如果你使用命令行直接部署，请看参考命令，记得修改实际的目录，如果其中有用不到的参数，请直接删除，但务必保留IYUU的目录，这是主程序的所在位置

```sh
docker run -d \
--name IYUUAutoReseed \
-v <IYUU的保存路径>:/IYUU \
-v <log的保存路径>:/logs \
-v <tr的种子目录>:/torrents \
-v <qb的种子目录>:/BT_backup \
-v <自定义的crontab_list.sh路径>:/crontab_list.sh \
--restart unless-stopped \
anthonymsen/iyuuautoreseed
```

如果你使用的是docker-compose，那么这个过程将会无比顺畅，只运行IYUU的话，请看参考配置：

```yml
version: "2.1"

services:
  iyuu:
    image: anthonymsen/iyuuautoreseed
    container_name: IYUUAutoReseed
    restart: unless-stopped
    volumes:
    - ./logs:/logs
    - ./IYUUAutoReseed:/IYUU
    - <请修改为你的tr种子目录>:/torrents #Transmission种子目录，移动辅种必须配置，不使用可以用#注释
    - <请修改为你的qb种子目录>/qBittorrent/BT_backup:/BT_backup #qBittorrent种子目录，移动辅种必须配置，不使用可以用#注释
    # - ./crontab_list.sh:/crontab_list.sh # 设置自定义的crontab，如果开头有#则使用默认的定时任务
    tty: true

```

如果你tr、qb、iyuu都想用docker-compose部署，那么更加的方便，请看参考配置：

```yml
version: "2.1"

services:
  transmission:
    image: linuxserver/transmission:2.94-r3-ls53
    container_name: transmission
    network_mode: "host"
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - TRANSMISSION_WEB_HOME=/transmission-web-control/ #optional
    volumes:
      - ./trconfig:/config
      - <设置为你的下载路径>:/downloads
    restart: unless-stopped

  qbittorrent:
    image: linuxserver/qbittorrent:14.2.5.99202004250119-7015-2c65b79ubuntu18.04.1-ls93
    container_name: qbittorrent
    # network_mode: "host"
    ports:
      - 51313:51313
      - 51313:51313/udp
      - 8081:8081
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - UMASK_SET=022
      - WEBUI_PORT=8081
    volumes:
      - ./qbconfig:/config
      - <设置为你的下载路径>:/downloads
    restart: unless-stopped
  
  iyuu:
    image: anthonymsen/iyuuautoreseed
    container_name: IYUUAutoReseed
    restart: unless-stopped
    volumes:
    - ./logs:/logs
    - ./IYUUAutoReseed:/IYUU
    - ./trconfig/torrents:/torrents #Transmission种子目录，移动辅种必须配置
    - ./qbconfig/data/qBittorrent/BT_backup:/BT_backup #qBittorrent种子目录，移动辅种必须配置
    # - ./crontab_list.sh:/crontab_list.sh # 设置自定义的crontab，如果开头有#则使用默认的定时任务
    tty: true

```
