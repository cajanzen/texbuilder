#!/usr/bin/env bash
# WARNING: since this script uses docker commands, it only works in the current
# directory and its subdirectories. Also note that no attempt has been made to
# prevent such misuse.
# adapted from: https://gist.github.com/hubgit/6078384
set -e
[ -z "${1}" ] && { exit 1; }

pdftk(){
    docker run -u `id -u`:`id -g` --rm -v ${PWD}:/data:z cajanzen/texbuilder pdftk $*
}
exiftool(){
    docker run -u `id -u`:`id -g` --rm -v ${PWD}:/data:z cajanzen/texbuilder exiftool $*
}
pdfinfo(){
    docker run -u `id -u`:`id -g` --rm -v ${PWD}:/data:z cajanzen/texbuilder pdfinfo $*
}
qpdf(){
    docker run -u `id -u`:`id -g` --rm -v ${PWD}:/data:z cajanzen/texbuilder qpdf $*
}

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
    cd -
}

clean_pdf "${1}"

[ $# -gt 1 ] && { shift ; ${0} $* ; }
(exit 0)
