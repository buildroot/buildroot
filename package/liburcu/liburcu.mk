################################################################################
#
# liburcu
#
################################################################################

LIBURCU_VERSION = 0.15.5
LIBURCU_SITE = http://lttng.org/files/urcu
LIBURCU_SOURCE = userspace-rcu-$(LIBURCU_VERSION).tar.bz2
LIBURCU_LICENSE = LGPL-2.1+ (library), MIT-like (few source files listed in LICENSE), GPL-2.0+ (test), GPL-3.0 (few *.m4 files)
LIBURCU_LICENSE_FILES = \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt \
	LICENSE.md

LIBURCU_INSTALL_STAGING = YES

# ac_cv_prog_cc_c99 is required for BR2_USE_WCHAR=n because the C99 test
# provided by autoconf relies on wchar_t.
LIBURCU_CONF_ENV = ac_cv_prog_cc_c99=-std=gnu99

$(eval $(autotools-package))
