#!/usr/bin/env bash
set -e
[ -z "${1}" ] && { exit 1; }

clean_pdf(){
    fn=$(basename "${1}")
    dn=$(dirname "${1}")
    cd "${dn}"
    pdftk "${fn}" dump_data | \
    sed -e 's/\(InfoValue:\)\s.*/\1\ /g' | \
    pdftk "${fn}" update_info - output clean-${fn}

    exiftool -all:all= clean-${fn}
    exiftool -all:all clean-${fn}
    exiftool -extractEmbedded -all:all clean-${fn}
    qpdf --linearize clean-${fn} clean2-${fn}

    pdftk clean2-${fn} dump_data
    exiftool clean2-${fn}
    pdfinfo -meta clean2-${fn}
    rm clean-${fn}
    mv clean2-${fn} ${fn}
    rm clean-${fn}_original
    cd -
}

clean_pdf "${1}"

[ $# -gt 1 ] && { shift ; ${0} $* ; }
(exit 0)
