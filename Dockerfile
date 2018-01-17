FROM nginx:latest
MAINTAINER Matthew Bucci <mtbucci@gmail.com>

RUN \
  DEBIAN_FRONTEND=noninteractive \
  echo 'deb http://opensource.wandisco.com/debian jessie svn19' >> /etc/apt/sources.list && \
  wget -q http://opensource.wandisco.com/wandisco-debian.gpg -O- | apt-key add - && \
  apt-get -q -y update && \
  apt-get -q -y install fcgiwrap && \
  apt-get -q -y install python-subversion subversion && \

  sed -i 's/^\(user .*\)$/user root;/' /etc/nginx/nginx.conf

CMD spawn-fcgi -s /var/run/fcgiwrap.sock /usr/sbin/fcgiwrap && nginx