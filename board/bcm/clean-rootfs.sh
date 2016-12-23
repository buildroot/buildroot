#!/bin/sh

BOARD_DIR="$(dirname $0)"

rm -rf $TARGET_DIR/usr/bin/fc-cache
rm -rf $TARGET_DIR/usr/bin/fc-cat
rm -rf $TARGET_DIR/usr/bin/fc-list
rm -rf $TARGET_DIR/usr/bin/fc-match
rm -rf $TARGET_DIR/usr/bin/fc-pattern
rm -rf $TARGET_DIR/usr/bin/fc-query
rm -rf $TARGET_DIR/usr/bin/fc-scan
rm -rf $TARGET_DIR/usr/bin/fc-validate
rm -rf $TARGET_DIR/usr/bin/vcsmem
rm -rf $TARGET_DIR/usr/bin/vcmailbox
rm -rf $TARGET_DIR/usr/bin/vchiq_test
rm -rf $TARGET_DIR/usr/bin/vcgencmd
rm -rf $TARGET_DIR/usr/bin/tvservice
rm -rf $TARGET_DIR/usr/bin/mmal_vc_diag
rm -rf $TARGET_DIR/usr/bin/containers_*
rm -rf $TARGET_DIR/usr/bin/pcre*
rm -rf $TARGET_DIR/usr/bin/gdbus-codegen
rm -rf $TARGET_DIR/usr/bin/gio-querymodules
rm -rf $TARGET_DIR/usr/bin/gsettings
rm -rf $TARGET_DIR/usr/bin/gdbus
rm -rf $TARGET_DIR/usr/bin/gapplication
rm -rf $TARGET_DIR/usr/bin/gresource
rm -rf $TARGET_DIR/usr/bin/faad
rm -rf $TARGET_DIR/usr/bin/asn1*
rm -rf $TARGET_DIR/usr/bin/sexp-conv
rm -rf $TARGET_DIR/usr/bin/pkcs1-conv
rm -rf $TARGET_DIR/usr/bin/nettle-*
rm -rf $TARGET_DIR/usr/bin/xmllint
rm -rf $TARGET_DIR/usr/bin/xmlcatalog
rm -rf $TARGET_DIR/usr/bin/mpg123
rm -rf $TARGET_DIR/usr/bin/out123
rm -rf $TARGET_DIR/usr/bin/mpg123-*
rm -rf $TARGET_DIR/usr/bin/sqlite3
rm -rf $TARGET_DIR/usr/bin/pkgdata
rm -rf $TARGET_DIR/usr/bin/hb-view
rm -rf $TARGET_DIR/usr/bin/hb-shape
rm -rf $TARGET_DIR/usr/bin/hb-ot-shape-closure
rm -rf $TARGET_DIR/usr/bin/touchpad-edge-detector
rm -rf $TARGET_DIR/usr/bin/mouse-dpi-tool
rm -rf $TARGET_DIR/usr/bin/libevdev-tweak-device
rm -rf $TARGET_DIR/usr/bin/gpg-error
rm -rf $TARGET_DIR/usr/bin/dumpsexp
rm -rf $TARGET_DIR/usr/bin/mpicalc
rm -rf $TARGET_DIR/usr/bin/hmac256
rm -rf $TARGET_DIR/usr/bin/mtdev-test
rm -rf $TARGET_DIR/usr/bin/libinput-list-devices
rm -rf $TARGET_DIR/usr/bin/libinput-debug-events
rm -rf $TARGET_DIR/usr/bin/xsltproc
rm -rf $TARGET_DIR/usr/bin/cwebp
rm -rf $TARGET_DIR/usr/bin/dwebp
rm -rf $TARGET_DIR/usr/sbin/icupkg
rm -rf $TARGET_DIR/usr/sbin/gensprep
rm -rf $TARGET_DIR/usr/sbin/gennorm2
rm -rf $TARGET_DIR/usr/sbin/gencmn
rm -rf $TARGET_DIR/usr/sbin/genccode
rm -rf $TARGET_DIR/usr/sbin/vcfiled
rm -rf $TARGET_DIR/usr/include
rm -rf $TARGET_DIR/usr/lib/*.sh
rm -rf $TARGET_DIR/usr/lib/*.py
rm -rf $TARGET_DIR/usr/lib/libxslt-plugins
rm -rf $TARGET_DIR/usr/lib/plugins
rm -rf $TARGET_DIR/usr/lib/icu
rm -rf $TARGET_DIR/usr/share/common-lisp
rm -rf $TARGET_DIR/usr/share/gettext
rm -rf $TARGET_DIR/usr/share/glib-2.0
rm -rf $TARGET_DIR/usr/share/gst-plugins-base
rm -rf $TARGET_DIR/usr/share/fontconfig
rm -rf $TARGET_DIR/usr/share/locale
rm -rf $TARGET_DIR/usr/share/xml
rm -rf $TARGET_DIR/usr/share/icu
rm -rf $TARGET_DIR/usr/share/man

if [ -f "$BOARD_DIR/index.html" ]; then
	mkdir -p "$TARGET_DIR/www/"
	cp -pf "$BOARD_DIR/index.html" "$TARGET_DIR/www/"
fi
