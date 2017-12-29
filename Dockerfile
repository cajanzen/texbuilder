FROM cajanzen/webdev-toolkit:201709
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN echo "deb http://download.tuxfamily.org/arakhne/ubuntu xenial-arakhne universe" >> /etc/apt/sources.list
RUN apt-key adv --recv-keys --keyserver pgp.mit.edu 21A59D90
RUN apt-get update && apt-get install -qy --allow-unauthenticated \
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
