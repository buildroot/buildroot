#!/bin/sh

TARGET_TRIPLE=$(basename $(dirname ${STAGING_DIR}))

for script in cmake ccmake ; do
	(
		echo '#!/bin/sh'
		echo
		echo "exec $script"' -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=`dirname $0`/../share/buildroot/toolchainfile.cmake $*'
	) > ${HOST_DIR}/usr/bin/${TARGET_TRIPLE}-${script}

	chmod 0755 ${HOST_DIR}/usr/bin/${TARGET_TRIPLE}-${script}
	ln -sf ${TARGET_TRIPLE}-${script} ${HOST_DIR}/usr/bin/mipsel-linux-${script}
done
