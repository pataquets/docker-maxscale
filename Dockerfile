FROM pataquets/ubuntu:xenial

RUN \
  apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys CE1A3DD5E3C94F49 && \
  echo "deb http://downloads.mariadb.com/MaxScale/latest/ubuntu xenial main" > /etc/apt/sources.list.d/mariadb.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      maxscale \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ \
  && \
  echo "# This configuration file is intentionally empty. See 'maxscale.cnf.d' dir." | \
    tee /etc/maxscale.cnf && \
  mkdir -v /etc/maxscale.cnf.d/

COPY ./maxscale.cnf.d/* /etc/maxscale.cnf.d/

ENTRYPOINT [ "maxscale", "--nodaemon", "--syslog=no", "--log=stdout" ]
