FROM eclipse/stack-base:ubuntu
ENV DEBIAN_FRONTEND=noninteractive

# RUN sudo apt-get update && sudo apt-get install -qy --allow-unauthenticated \
#  texlive-full \
RUN sudo apt-get update && sudo apt-get install -qy \
  build-essential \
  exiftool \
  ghostscript \
  git \
  inotify-tools \
  libkrb5-dev \
  nginx \
  nodejs \
  pdftk \
  poppler-utils \
  python \
  python-all-dev \
  python3-all-dev \
  python-pip \
  python-setuptools \
  python-virtualenv \
  qpdf \
  ruby-full \
  rubygems \
  unzip \
  vim-nox \
  && sudo apt-get -y autoremove \
  && sudo apt-get -y clean \
  && sudo rm -rf /var/lib/apt/lists/* 
 
RUN sudo bash -c 'echo "deb http://ftp.uk.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
  && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553'

RUN sudo apt-get update  && sudo apt-get install -qy \
  asciinema \
  ffmpeg \
  graphviz \
  && sudo rm -rf /var/lib/apt/lists/*

COPY nginx_default /etc/nginx/sites-available/default 
EXPOSE 80 22
LABEL che:server:80:ref=nginx che:server:80:protocol=http

ADD http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz /tmp
COPY texlive.profile /tmp
RUN cd /tmp; sudo tar -xzf install-tl-unx.tar.gz; cd /tmp/install-tl-2*; sudo ls -la; sudo ./install-tl -profile ../texlive.profile
#RUN sudo sed -i 's/^PATH="/PATH="\/usr\/local\/texlive\/2018\/bin\/x86_64-linux:/' /etc/environment
ENV PATH /usr/local/texlive/2018/bin/x86_64-linux:$PATH
