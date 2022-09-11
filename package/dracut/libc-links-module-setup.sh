#!/bin/bash

# Adds the missing links for uClibc or musl, if needed

check() {
	return 0
}

depends() {
	return 0
}

install() {
	# Despite of the fact that the listed dependency (reported by readelf -d)
	# is purely /lib/libc.so, the musl symlink is needed anyway.
	musl_link="$(find "${dracutsysrootdir?}/lib/" -name "ld-musl-*.so*")"
	if [ -n "${musl_link}" ] ; then
		ln -s libc.so "${initdir?}/lib/${musl_link##*/}"
	fi

	# Same for uClibc, the listed dependency
	# is ld-uClibc.so.1, the loader needs the ld-uClibc.so.0, too
	uclibc_link="$(find "${dracutsysrootdir?}/lib/" -name "ld-uClibc-*.so*")"
	if [ -n "$uclibc_link" ] ; then
		ln -s ld-uClibc.so.1 "${initdir?}/lib/ld-uClibc.so.0"
	fi
}
