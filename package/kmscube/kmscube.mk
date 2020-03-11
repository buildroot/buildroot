################################################################################
#
# kmscube
#
################################################################################

KMSCUBE_VERSION = 76bb57d539cb43d267e561024c34e031bf351e04
KMSCUBE_SITE = https://cgit.freedesktop.org/mesa/kmscube/snapshot
KMSCUBE_LICENSE = MIT
KMSCUBE_DEPENDENCIES = host-pkgconf mesa3d libdrm
KMSCUBE_AUTORECONF = YES

$(eval $(autotools-package))
