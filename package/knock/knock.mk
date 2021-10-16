################################################################################
#
# knock
#
################################################################################

KNOCK_VERSION = 0.8
KNOCK_SITE = $(call github,jvinet,knock,v$(KNOCK_VERSION))
KNOCK_AUTORECONF = YES
KNOCK_LICENSE = GPL-2.0+
KNOCK_LICENSE_FILES = COPYING
KNOCK_DEPENDENCIES = libpcap

ifeq ($(BR2_STATIC_LIBS),y)
KNOCK_CONF_OPTS = LIBS="`$(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs`"
endif

$(eval $(autotools-package))
