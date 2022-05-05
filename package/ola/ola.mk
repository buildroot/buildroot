################################################################################
#
# ola
#
################################################################################

OLA_VERSION = 0.10.8
OLA_SITE = https://github.com/OpenLightingProject/ola/releases/download/$(OLA_VERSION)
OLA_LICENSE = LGPL-2.1+ (libola, libolacommon, Python bindings), GPL-2.0+ (libolaserver, olad, Python examples and tests)
OLA_LICENSE_FILES = COPYING GPL LGPL LICENCE
OLA_INSTALL_STAGING = YES
# Bundled Makefile.in don't link correctly, regenerate with recent automake
OLA_AUTORECONF = YES

# util-linux provides uuid lib
OLA_DEPENDENCIES = protobuf util-linux host-bison host-flex host-ola

OLA_CONF_OPTS = \
	ac_cv_have_pymod_google_protobuf=yes \
	--disable-fatal-warnings \
	--disable-gcov \
	--disable-ja-rule \
	--disable-java-libs \
	--disable-root-check \
	--disable-tcmalloc \
	--disable-unittests \
	--with-ola-protoc-plugin=$(HOST_DIR)/usr/bin/ola_protoc_plugin

HOST_OLA_DEPENDENCIES = host-util-linux host-protobuf host-bison host-flex

# When building the host part, disable as much as possible to speed up
# the configure step and avoid missing host dependencies.
HOST_OLA_CONF_OPTS = \
	--disable-all-plugins \
	--disable-osc \
	--disable-uart \
	--disable-libusb \
	--disable-libftdi \
	--disable-http \
	--disable-examples \
	--disable-unittests \
	--disable-doxygen-html \
	--disable-doxygen-doc \
	--disable-fatal-warnings

# On the host side, we only need ola_protoc_plugin, so build and install this
# only.
HOST_OLA_MAKE_OPTS = protoc/ola_protoc_plugin
define HOST_OLA_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/protoc/ola_protoc_plugin $(HOST_DIR)/usr/bin/ola_protoc_plugin
endef

# sets where to find python libs built for target and required by ola
OLA_CONF_ENV = PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages
OLA_MAKE_ENV = PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
OLA_DEPENDENCIES += libexecinfo
OLA_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -lexecinfo"
endif

## OLA Bindings and Interface selections

ifeq ($(BR2_PACKAGE_OLA_WEB),y)
OLA_CONF_OPTS += --enable-http
OLA_DEPENDENCIES += libmicrohttpd
else
OLA_CONF_OPTS += --disable-http
endif

ifeq ($(BR2_PACKAGE_OLA_PYTHON_BINDINGS),y)
OLA_CONF_OPTS += --enable-python-libs
OLA_DEPENDENCIES += python3 python-protobuf
else
OLA_CONF_OPTS += --disable-python-libs
endif

## OLA Examples and Tests

ifeq ($(BR2_PACKAGE_OLA_EXAMPLES),y)
OLA_CONF_OPTS += --enable-examples
OLA_DEPENDENCIES += ncurses
else
OLA_CONF_OPTS += --disable-examples
endif

ifeq ($(BR2_PACKAGE_OLA_RDM_TESTS),y)
OLA_CONF_OPTS += --enable-rdm-tests
OLA_DEPENDENCIES += python-numpy
# needed as numpy builds some shared libraries and ola checks for
# numpy using a host python test program which fails with 'wrong ELF
# class'.
OLA_CONF_ENV += ac_cv_have_pymod_numpy=yes
else
OLA_CONF_OPTS += --disable-rdm-tests
endif

## OLA Plugin selections

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_ARTNET),y)
OLA_CONF_OPTS += --enable-artnet
else
OLA_CONF_OPTS += --disable-artnet
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_DUMMY),y)
OLA_CONF_OPTS += --enable-dummy
else
OLA_CONF_OPTS += --disable-dummy
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_E131),y)
OLA_CONF_OPTS += --enable-e131
else
OLA_CONF_OPTS += --disable-e131
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_ESPNET),y)
OLA_CONF_OPTS += --enable-espnet
else
OLA_CONF_OPTS += --disable-espnet
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_FTDIDMX),y)
OLA_CONF_OPTS += --enable-ftdidmx
OLA_DEPENDENCIES += libftdi1
else
OLA_CONF_OPTS += --disable-ftdidmx
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_GPIO),y)
OLA_CONF_OPTS += --enable-gpio
else
OLA_CONF_OPTS += --disable-gpio
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_KARATE),y)
OLA_CONF_OPTS += --enable-karate
else
OLA_CONF_OPTS += --disable-karate
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_KINET),y)
OLA_CONF_OPTS += --enable-kinet
else
OLA_CONF_OPTS += --disable-kinet
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_MILINT),y)
OLA_CONF_OPTS += --enable-milinst
else
OLA_CONF_OPTS += --disable-milinst
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_OPENDMX),y)
OLA_CONF_OPTS += --enable-opendmx
else
OLA_CONF_OPTS += --disable-opendmx
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_OPENPIXELCONTROL),y)
OLA_CONF_OPTS += --enable-openpixelcontrol
else
OLA_CONF_OPTS += --disable-openpixelcontrol
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_OSC),y)
OLA_CONF_OPTS += --enable-osc
OLA_DEPENDENCIES += liblo
else
OLA_CONF_OPTS += --disable-osc
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_PATHPORT),y)
OLA_CONF_OPTS += --enable-pathport
else
OLA_CONF_OPTS += --disable-pathport
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_RENARD),y)
OLA_CONF_OPTS += --enable-renard
else
OLA_CONF_OPTS += --disable-renard
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_SANDNET),y)
OLA_CONF_OPTS += --enable-sandnet
else
OLA_CONF_OPTS += --disable-sandnet
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_SHOWNET),y)
OLA_CONF_OPTS += --enable-shownet
else
OLA_CONF_OPTS += --disable-shownet
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_SPI),y)
OLA_CONF_OPTS += --enable-spi
else
OLA_CONF_OPTS += --disable-spi
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_STAGEPROFI),y)
OLA_CONF_OPTS += --enable-stageprofi --enable-libusb
OLA_DEPENDENCIES += libusb
else
OLA_CONF_OPTS += --disable-stageprofi
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_UARTDMX),y)
OLA_CONF_OPTS += --enable-uartdmx
else
OLA_CONF_OPTS += --disable-uartdmx
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_USBDMX),y)
OLA_CONF_OPTS += --enable-usbdmx --enable-libusb
OLA_DEPENDENCIES += libusb
else
OLA_CONF_OPTS += --disable-usbdmx
endif

ifeq ($(BR2_PACKAGE_OLA_PLUGIN_USBPRO),y)
OLA_CONF_OPTS += --enable-usbpro --enable-libusb
OLA_DEPENDENCIES += libusb
else
OLA_CONF_OPTS += --disable-usbpro
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
