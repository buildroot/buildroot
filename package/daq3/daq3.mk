################################################################################
#
# daq3
#
################################################################################

DAQ3_VERSION = 3.0.9
DAQ3_SITE = $(call github,snort3,libdaq,v$(DAQ3_VERSION))
DAQ3_LICENSE = GPL-2.0
DAQ3_LICENSE_FILES = COPYING LICENSE
DAQ3_INSTALL_STAGING = YES
DAQ3_DEPENDENCIES = host-pkgconf
# From git
DAQ3_AUTORECONF = YES

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
DAQ3_CONF_OPTS += --enable-gwlb-module
else
DAQ3_CONF_OPTS += --disable-gwlb-module
endif

ifeq ($(BR2_PACKAGE_LIBNETFILTER_QUEUE),y)
DAQ3_DEPENDENCIES += libnetfilter_queue
DAQ3_CONF_OPTS += --enable-nfq-module
else
DAQ3_CONF_OPTS += --disable-nfq-module
endif

ifeq ($(BR2_PACKAGE_LIBPCAP),y)
DAQ3_DEPENDENCIES += libpcap
DAQ3_CONF_OPTS += --enable-pcap-module
else
DAQ3_CONF_OPTS += --disable-pcap-module
endif

$(eval $(autotools-package))
