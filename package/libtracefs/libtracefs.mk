################################################################################
#
# libtracefs
#
################################################################################

LIBTRACEFS_VERSION = 1.8.2
LIBTRACEFS_SITE = https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/snapshot
LIBTRACEFS_INSTALL_STAGING = YES
LIBTRACEFS_LICENSE = GPL-2.0, LGPL-2.1
LIBTRACEFS_LICENSE_FILES = LICENSES/GPL-2.0 LICENSES/LGPL-2.1

LIBTRACEFS_DEPENDENCIES = host-bison host-flex host-pkgconf libtraceevent

LIBTRACEFS_CONF_OPTS = \
	-Ddoc=false \
	-Dsamples=false

$(eval $(meson-package))
