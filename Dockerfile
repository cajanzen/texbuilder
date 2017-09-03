FROM cajanzen/webdev-toolkit
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN apt-get install -qy \
  exiftool \
  ghostscript \
  pdftk \
  poppler-utils \
  qpdf \
  rubber \
  texlive-full \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/texlive-doc  # 1.5G of documentation!
