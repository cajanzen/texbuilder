FROM debian:jessie
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN apt-get update -q
RUN apt-get install -qy texlive-full rubber poppler-utils exiftool pdftk
RUN apt-get install -qy qpdf
RUN apt-get install -qy ghostscript
WORKDIR /data
VOLUME ["/data"]
