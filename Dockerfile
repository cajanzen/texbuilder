FROM eclipse/stack-base:ubuntu
ENV DEBIAN_FRONTEND=noninteractive
EXPOSE 8000 22
LABEL che:server:8000:ref=nginx che:server:8000:protocol=http

RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt-get update && sudo apt-get install -qy --allow-unauthenticated \
  build-essential \
  exiftool \
  ghostscript \
  git \
  inotify-tools \
  latexmk \
  libkrb5-dev \
  nginx \
  nodejs \
  pdftk \
  poppler-utils \
  python \
  python-dev \
  python-pip \
  python-setuptools \
  python-virtualenv \
  qpdf \
  rubber \
  ruby-full \
  rubygems \
  texlive-full \
  unzip && \
  sudo apt-get -y autoremove && \
  sudo apt-get -y clean && \
  sudo rm -rf /var/lib/apt/lists/* && \
  sudo rm -rf /usr/share/doc/texlive-doc  # 1.5G of documentation!
 
RUN sudo npm install --unsafe-perm -g \
  bower \
  generator-angular \
  generator-karma \
  generator-webapp \
  grunt \
  gulp \
  slush \
  yeoman-generator 

COPY nginx_default /etc/nginx/sites-available/default 
