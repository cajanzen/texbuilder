FROM debian:jessie
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN apt-get update -q
RUN apt-get update -q \
  && apt-get install -qy \
    exiftool \
    ghostscript \
    pdftk \
    poppler-utils \
    qpdf \
    rubber \
    texlive-full \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/texlive-doc  # 1.5G of documentation!
COPY ./script/* /usr/local/bin
WORKDIR /data
VOLUME ["/data"]
