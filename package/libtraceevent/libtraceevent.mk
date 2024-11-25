################################################################################
#
# libtraceevent
#
################################################################################

LIBTRACEEVENT_VERSION = 1.8.4
LIBTRACEEVENT_SITE = https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot
LIBTRACEEVENT_LICENSE = GPL-2.0, LGPL-2.1
LIBTRACEEVENT_LICENSE_FILES = LICENSES/GPL-2.0 LICENSES/LGPL-2.1

LIBTRACEEVENT_INSTALL_STAGING = YES

LIBTRACEEVENT_CONF_OPTS = \
	-Ddoc=false

$(eval $(meson-package))
