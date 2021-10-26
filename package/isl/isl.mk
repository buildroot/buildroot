################################################################################
#
# isl
#
################################################################################

ISL_VERSION = 0.23
ISL_SOURCE = isl-$(ISL_VERSION).tar.xz
ISL_SITE = https://libisl.sourceforge.io
ISL_LICENSE = MIT
ISL_LICENSE_FILES = LICENSE
HOST_ISL_DEPENDENCIES = host-gmp

$(eval $(host-autotools-package))
