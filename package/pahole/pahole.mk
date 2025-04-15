################################################################################
#
# pahole
#
################################################################################

PAHOLE_VERSION = 1.28
PAHOLE_SITE = https://git.kernel.org/pub/scm/devel/pahole/pahole.git/snapshot
HOST_PAHOLE_DEPENDENCIES = \
	host-elfutils \
	host-libbpf
# Defining __LIB is needed to build pahole.
# Set LIBBPF_EMBEDDED to OFF to use host-libbpf.
HOST_PAHOLE_CONF_OPTS = -D__LIB=lib -DLIBBPF_EMBEDDED=OFF
PAHOLE_LICENSE = GPL-2.0
PAHOLE_LICENSE_FILES = COPYING

$(eval $(host-cmake-package))
