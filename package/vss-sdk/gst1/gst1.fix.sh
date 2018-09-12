#!/bin/bash

patch_files () {
    pushd $1
    if [ ! -f vss_patch_files.done ]; then
        for f in `ls  pkgconfig/gstreamer*.pc.in`; \
        do  \
          file=`echo $f | sed "s/.*\///"` ; \
          pc=`echo $f | sed -r "s/.+\/(.+)\..+/\1/"` ; \
          sed -i \
              -e "s;pluginsdir=.*;pluginsdir=\@PLUGINDIR\@;g" \
              -e "s;girdir=.*;girdir=${datadir}/girwpe-1.0;g" \
              -e "s;typelibdir=.*;typelibdir=${libdir}/giwperepository-1.0;g" \
              -e "s;datarootdir=.*;datarootdir=${prefix}/share/gstreamer-wpe;g" \
              -e "s;helpersdir=.*;;g" \
              -e "s;completionsdir=.*;;g" \
              -e "s;\ gstreamer-;\ wpe-gstreamer-;g" \
              -e "s/lgst/lwpegst/g" \
              $f ; \
          mv ${f}  pkgconfig/wpe-${file} ; \
        done
        sed -i -e "s;pkgconfig/gstreamer;pkgconfig/wpe-gstreamer;g"   configure.ac
        sed -i -e s/gstreamer/wpe-gstreamer/g   pkgconfig/Makefile.in
        sed -i -e s/gstreamer/wpe-gstreamer/g   pkgconfig/Makefile.am
        # correct plugin install location
        sed -i -e "s;/gstreamer-\$GST_API_VERSION;/gstreamer-\$\{GST_API_VERSION\}-wpe;g"  common/m4/gst-plugindir.m4
        #rename libs
        for f in `find  -name Makefile.in -o -name Makefile.am -o -name configure.ac`; do \
          sed -i \
              -e s/libgst/libwpegst/g \
              -e s/lgst/lwpegst/g \
              -e s/girepository/giwperepository/g \
              -e s/gir-1.0/girwpe-1.0/g \
              $f ; \
        done
        sed -i -e "s;gst-plugin-scanner;wpegst-plugin-scanner;g"  configure.ac
        sed -i -e "s;gst-plugin-scanner;wpegst-plugin-scanner;g"  gst/Makefile.am
        sed -i -e "s;gst-ptp-helper;wpegst-ptp-helper;g"  configure.ac
        sed -i -e "s;gst-ptp-helper;wpegst-ptp-helper;g"  libs/gst/net/Makefile.am
        touch vss_patch_files.done
    fi
    popd
}

patch_files $1
