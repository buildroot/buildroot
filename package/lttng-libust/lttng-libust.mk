################################################################################
#
# lttng-libust
#
################################################################################

LTTNG_LIBUST_SITE = http://lttng.org/files/lttng-ust
LTTNG_LIBUST_VERSION = 2.13.1
LTTNG_LIBUST_SOURCE = lttng-ust-$(LTTNG_LIBUST_VERSION).tar.bz2
LTTNG_LIBUST_LICENSE = LGPL-2.1, MIT (system headers), GPL-2.0 (liblttng-ust-ctl/ustctl.c used by lttng-sessiond), BSD-3-Clause (snprintf)
LTTNG_LIBUST_LICENSE_FILES = LICENSE LICENSES/BSD-3-Clause LICENSES/GPL-2.0 LICENSES/LGPL-2.1 LICENSES/MIT
LTTNG_LIBUST_INSTALL_STAGING = YES
LTTNG_LIBUST_DEPENDENCIES = liburcu util-linux
LTTNG_LIBUST_CONF_OPTS = \
	--disable-man-pages \
	--disable-examples \
	--disable-tests \
	--with-lttng-system-rundir=/run/lttng
LTTNG_LIBUST_AUTORECONF = YES
# https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg12950.html
LTTNG_LIBUST_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -DUATOMIC_NO_LINK_ERROR"

ifeq ($(BR2_PACKAGE_PYTHON3),y)
LTTNG_LIBUST_DEPENDENCIES += python3
LTTNG_LIBUST_CONF_OPTS += --enable-python-agent
else
LTTNG_LIBUST_CONF_ENV += am_cv_pathless_PYTHON="none"
LTTNG_LIBUST_CONF_OPTS += --disable-python-agent
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
LTTNG_LIBUST_DEPENDENCIES += numactl
LTTNG_LIBUST_CONF_OPTS += --enable-numa
else
LTTNG_LIBUST_CONF_OPTS += --disable-numa
endif

$(eval $(autotools-package))
