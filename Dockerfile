
FROM pataquets/ubuntu:xenial

RUN \
  apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys 135659E928C12247 && \
  echo "deb http://downloads.mariadb.com/MaxScale/latest/ubuntu xenial main" > /etc/apt/sources.list.d/mariadb.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      maxscale \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ \
  && \
  mkdir -v /etc/maxscale.cnf.d/

ENTRYPOINT [ "maxscale", "--nodaemon", "--syslog=no", "--log=stdout" ]
