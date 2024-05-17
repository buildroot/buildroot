################################################################################
#
# gr-osmosdr
#
################################################################################

GR_OSMOSDR_VERSION = 0.2.4
GR_OSMOSDR_SITE = $(call github,osmocom,gr-osmosdr,v$(GR_OSMOSDR_VERSION))
GR_OSMOSDR_LICENSE = GPL-3.0+
GR_OSMOSDR_LICENSE_FILES = COPYING

# gr-osmosdr prevents doing an in-source-tree build
GR_OSMOSDR_SUPPORTS_IN_SOURCE_BUILD = NO

GR_OSMOSDR_DEPENDENCIES = gnuradio host-python3

GR_OSMOSDR_CONF_OPTS = \
	-DENABLE_DEFAULT=OFF \
	-DENABLE_DOXYGEN=OFF

# For third-party blocks, the gr-osmosdr libraries are mandatory at
# compile time.
GR_OSMOSDR_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_GNURADIO_PYTHON),y)
GR_OSMOSDR_CONF_OPTS += \
	-DENABLE_PYTHON=ON \
	-DPYTHON_INCLUDE_DIRS=$(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION_MAJOR)
GR_OSMOSDR_DEPENDENCIES += python3 host-python-six
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_PYTHON=OFF
endif

ifeq ($(BR2_PACKAGE_GR_OSMOSDR_IQFILE),y)
GR_OSMOSDR_CONF_OPTS += -DENABLE_FILE=ON
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_FILE=OFF
endif

ifeq ($(BR2_PACKAGE_GR_OSMOSDR_RTLSDR),y)
GR_OSMOSDR_CONF_OPTS += -DENABLE_RTL=ON
GR_OSMOSDR_DEPENDENCIES += librtlsdr
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_RTL=OFF
endif

ifeq ($(BR2_PACKAGE_GR_OSMOSDR_RTLSDR_TCP),y)
GR_OSMOSDR_CONF_OPTS += -DENABLE_RTL_TCP=ON
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_RTL_TCP=OFF
endif

ifeq ($(BR2_PACKAGE_GR_OSMOSDR_RFSPACE),y)
GR_OSMOSDR_CONF_OPTS += -DENABLE_RFSPACE=ON
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_RFSPACE=OFF
endif

ifeq ($(BR2_PACKAGE_GR_OSMOSDR_HACKRF),y)
GR_OSMOSDR_CONF_OPTS += -DENABLE_HACKRF=ON
GR_OSMOSDR_DEPENDENCIES += hackrf
else
GR_OSMOSDR_CONF_OPTS += -DENABLE_HACKRF=OFF
endif

$(eval $(cmake-package))
