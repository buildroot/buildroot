#!/bin/bash

check() {
	require_binaries busybox || return 1
	return 0
}

depends() {
	return 0
}

install_busybox_links() {
	dir="${1}"
	linkname="${2}"

	(cd "${dracutsysrootdir?}${dir}" &&
	for x in *; do
		if [ "$(readlink "${x}")" = "${linkname}" ]; then
			ln -sf "${linkname}" "${initdir?}/${dir}/${x}"
		fi
	done
	)
}

install() {
	inst_multiple /bin/busybox

	# wrapper script for early console; will launch /sbin/init
	# after having mounted devtmpfs
	inst_multiple /init

	if [ -e "${dracutsysrootdir?}/lib64" ]; then
		ln -sf lib "${initdir?}/lib64"
		ln -sf lib "${initdir?}/usr/lib64"
	fi

	if [ -e "${dracutsysrootdir?}/lib32" ]; then
		ln -sf lib "${initdir?}/lib32"
		ln -sf lib "${initdir?}/usr/lib32"
	fi

	install_busybox_links "/bin" "busybox"
	install_busybox_links "/sbin" "../bin/busybox"
	if [ ! -L "${dracutsysrootdir?}/bin" ]; then
		install_busybox_links "/usr/bin" "../../bin/busybox"
		install_busybox_links "/usr/sbin" "../../bin/busybox"
	fi

	inst_multiple \
		/etc/inittab	\
		/etc/init.d/rcS \
		/etc/init.d/rcK \
		/etc/issue	\
		/etc/fstab	\
		/etc/group	\
		/etc/passwd	\
		/etc/shadow	\
		/etc/hostname
}
