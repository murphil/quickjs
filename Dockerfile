FROM alpine:3.10

WORKDIR /root
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 TIMEZONE=Asia/Shanghai

RUN set -ex \
  # apk
  ; sed -i 's/dl-cdn.alpinelinux.org/mirror.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
  #; apk update && apk upgrade \
  ; apk add --no-cache --virtual .build-deps \
        coreutils gcc make libc-dev wget \
  ; version=2019-07-28 \
  ; wget -O- https://bellard.org/quickjs/quickjs-${version}.tar.xz \
        | tar Jxf - \
  ; cd quickjs-${version} \
  ; sed -i 's!CONFIG_M32=y!!' Makefile \
  ; make \
  #; make install \
  ; cp qjs /usr/local/bin/ \
  ; cd .. \
  ; rm -rf quickjs-${version} \
  ; apk del .build-deps \
  ; apk add --no-cache tzdata \
  ; ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  ; echo "$TIMEZONE" > /etc/timezone

CMD [ "qjs" ]
