################################################################################
#
# lttng-tools
#
################################################################################

LTTNG_TOOLS_VERSION = 2.16.0
LTTNG_TOOLS_SITE = https://lttng.org/files/lttng-tools
LTTNG_TOOLS_SOURCE = lttng-tools-$(LTTNG_TOOLS_VERSION).tar.bz2
LTTNG_TOOLS_INSTALL_STAGING = YES
LTTNG_TOOLS_LICENSE = GPL-2.0, LGPL-2.1 (include/lttng/*, src/lib/lttng-ctl/*)
LTTNG_TOOLS_LICENSE_FILES = \
	LICENSE \
	LICENSES/BSD-2-Clause.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/MIT.txt
LTTNG_TOOLS_DEPENDENCIES = liburcu libxml2 popt util-linux
LTTNG_TOOLS_CONF_OPTS = \
	--disable-man-pages \
	--disable-tests \
	--with-lttng-system-rundir=/run/lttng

ifeq ($(BR2_PACKAGE_LTTNG_LIBUST),y)
LTTNG_TOOLS_CONF_OPTS += --with-lttng-ust
LTTNG_TOOLS_DEPENDENCIES += lttng-libust
else
LTTNG_TOOLS_CONF_OPTS += --without-lttng-ust
endif

$(eval $(autotools-package))
