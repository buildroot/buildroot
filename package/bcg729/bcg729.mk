################################################################################
#
# bcg729
#
################################################################################

BCG729_VERSION = 1.1.1-3-g8bec1e5fc072f3669e435edd137eb3da6da2eef7
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
