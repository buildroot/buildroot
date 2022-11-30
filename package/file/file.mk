################################################################################
#
# file
#
################################################################################

FILE_VERSION = 5.43
FILE_SITE = ftp://ftp.astron.com/pub/file
FILE_LICENSE = BSD-2-Clause, BSD-4-Clause (one file), BSD-3-Clause (one file)
FILE_LICENSE_FILES = COPYING src/mygetopt.h src/vasprintf.c
FILE_CPE_ID_VENDOR = file_project

FILE_AUTORECONF = YES

FILE_DEPENDENCIES = host-file
FILE_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'
FILE_INSTALL_STAGING = YES

HOST_FILE_DEPENDENCIES = host-zlib
HOST_FILE_CONF_OPTS = --disable-libseccomp
HOST_FILE_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'

ifeq ($(BR2_PACKAGE_BZIP2),y)
FILE_CONF_OPTS += --enable-bzlib
FILE_DEPENDENCIES += bzip2
else
FILE_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
FILE_CONF_OPTS += --enable-libseccomp
FILE_DEPENDENCIES += libseccomp
else
FILE_CONF_OPTS += --disable-libseccomp
endif

ifeq ($(BR2_PACKAGE_XZ),y)
FILE_CONF_OPTS += --enable-xzlib
FILE_DEPENDENCIES += xz
else
FILE_CONF_OPTS += --disable-xzlib
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
FILE_CONF_OPTS += --enable-zlib
FILE_DEPENDENCIES += zlib
else
FILE_CONF_OPTS += --disable-zlib
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
