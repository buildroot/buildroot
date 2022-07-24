################################################################################
#
# bcg729
#
################################################################################

BCG729_VERSION = 1.1.1
BCG729_SITE = $(call github,BelledonneCommunications,bcg729,$(BCG729_VERSION))
BCG729_LICENSE = GPL-3.0+
BCG729_LICENSE_FILES = LICENSE.txt
BCG729_INSTALL_STAGING = YES

ifeq ($(BR2_STATIC_LIBS),y)
BCG729_CONF_OPTS += -DENABLE_SHARED=OFF -DENABLE_STATIC=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
BCG729_CONF_OPTS += -DENABLE_SHARED=ON -DENABLE_STATIC=ON
else ifeq ($(BR2_SHARED_LIBS),y)
BCG729_CONF_OPTS += -DENABLE_SHARED=ON -DENABLE_STATIC=OFF
endif

$(eval $(cmake-package))
