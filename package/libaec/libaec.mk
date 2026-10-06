################################################################################
#
# libaec
#
################################################################################

LIBAEC_VERSION = 1.1.7
LIBAEC_SITE = https://github.com/Deutsches-Klimarechenzentrum/libaec/releases/download/v$(LIBAEC_VERSION)
LIBAEC_LICENSE = BSD-2-Clause
LIBAEC_LICENSE_FILES = LICENSE.txt
LIBAEC_INSTALL_STAGING = YES

ifeq ($(BR2_SHARED_LIBS),y)
LIBAEC_CONF_OPTS += -DBUILD_STATIC_LIBS=OFF
else
LIBAEC_CONF_OPTS += -DBUILD_STATIC_LIBS=ON
endif

$(eval $(cmake-package))
