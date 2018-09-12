#!/bin/bash

patch_files () {
        pushd $1
        if [ ! -f disable_opus.done ]; then
        for f in `find ${S} -name *.c -o -name *.h -type f`; do \
            sed -i \
            -e "s;case baudio_format_opus.*;;g" \
            -e "s;\"audio/x-opus\;\ \";;g" \
            $f; \
        done
        touch disable_opus.done
        fi
        popd
}

patch_files $1
