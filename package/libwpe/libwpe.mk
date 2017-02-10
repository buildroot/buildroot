################################################################################
#
# libwpe
#
################################################################################

LIBWPE_VERSION = a03e258399e4e31aa4861e9d948d13355f447bc6
LIBWPE_SITE = $(call github,WebKitForWayland,wpe,$(LIBWPE_VERSION))

LIBWPE_INSTALL_STAGING = YES

LIBWPE_DEPENDENCIES += libegl

LIBWPE_C_FLAGS = "-D_GNU_SOURCE"
LIBWPE_CONF_OPTS += -DWPE_BACKEND=libWPE-platform.so -DCMAKE_C_FLAGS=$(LIBWPE_C_FLAGS)

$(eval $(cmake-package))
