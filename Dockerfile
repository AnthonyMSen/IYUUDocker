FROM alpine
LABEL AUTHOR="AnthonyMSen" \
        VERSION="1.0"

RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache git tzdata php7 php7-curl php7-dom php7-json php7-mbstring php7-simplexml php7-zip php7-xml \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

ENV CRONTAB_LIST=crontab_list.sh

# github action 构建
COPY ./entrypoint.sh /usr/local/bin
COPY ./crontab_list.sh /crontab_list.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /IYUU

ENTRYPOINT ["entrypoint.sh"]
