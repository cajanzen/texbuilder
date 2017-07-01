#!/usr/bin/env bash
[ -z "${1}" ] && { echo "usage: ${0} <pdffile>" ; exit 1 ; }
bn=$(basename "${1}")
dn=$(dirname "${1}")
tmpname="${dn}/tmp.${bn}"
# from: http://stackoverflow.com/questions/10450120/optimize-pdf-files-with-ghostscript-or-other
mv "${1}" "${tmpname}"
echo in: ${1}
echo tmp: ${tmpname}
ls build
cmdline="gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/${1} /data/${tmpname}"
docker run -u `id -u`:`id -g` --rm -v ${PWD}:/data:z cajanzen/texbuilder ${cmdline}
rm -f "${tmpname}"
[ $# -gt 1 ] && { shift ; ${0} $* ; }
(exit 0)
