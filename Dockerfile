FROM cajanzen/webdev-toolkit:latest
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN echo "deb http://download.tuxfamily.org/arakhne/ubuntu xenial-arakhne universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -qy \
  autolatex \
  exiftool \
  ghostscript \
  pdftk \
  poppler-utils \
  qpdf \
  rubber \
  texlive-full \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/texlive-doc  # 1.5G of documentation!
