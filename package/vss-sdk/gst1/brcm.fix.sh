#!/bin/bash

patch_files () {
        pushd $1
        if [ ! -f vss_patch_files.done ]; then
            for f in `find -name Makefile.in -o -name Makefile.am -o -name configure.ac`; do \
                sed -i \
                -e "s;\[gstreamer-;\[wpe-gstreamer-;g" \
                -e "s;plugindir=.*;plugindir=\"\\\\$\(libdir\)/gstreamer\-\$\{GST_MAJORMINOR\}\-wpe\";g" \
                $f; \
            done
            touch vss_patch_files.done
        fi
        popd
}

patch_files $1
