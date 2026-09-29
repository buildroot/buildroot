################################################################################
#
# tcpreplay
#
################################################################################

TCPREPLAY_VERSION = 4.6.1
TCPREPLAY_SITE = https://github.com/appneta/tcpreplay/releases/download/v$(TCPREPLAY_VERSION)
TCPREPLAY_SOURCE = tcpreplay-$(TCPREPLAY_VERSION).tar.xz
TCPREPLAY_LICENSE = GPL-3.0
TCPREPLAY_LICENSE_FILES = docs/LICENSE
TCPREPLAY_CPE_ID_VENDOR = broadcom
TCPREPLAY_DEPENDENCIES = libpcap
# The option parsers, tcpedit_stub.h and man pages are pre-generated in
# the release tarball, so don't use autogen, python3 or asciidoctor from
# the host.
TCPREPLAY_CONF_OPTS = \
	-DENABLE_PCAPCONFIG=ON \
	-DPCAP_CONFIG_EXECUTABLE=$(STAGING_DIR)/usr/bin/pcap-config \
	-DAUTOGEN_EXECUTABLE=OFF \
	-DPYTHON3_EXECUTABLE=OFF \
	-DASCIIDOCTOR_EXECUTABLE=OFF \
	-DPCAPNAV_CONFIG_EXECUTABLE=OFF

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
TCPREPLAY_DEPENDENCIES += musl-fts
endif

ifeq ($(BR2_STATIC_LIBS),y)
TCPREPLAY_CONF_OPTS += -DENABLE_STATIC_LINK=ON
else
TCPREPLAY_CONF_OPTS += -DENABLE_STATIC_LINK=OFF
endif

ifeq ($(BR2_PACKAGE_LIBDNET),y)
TCPREPLAY_DEPENDENCIES += libdnet
TCPREPLAY_CONF_OPTS += -DWITH_LIBDNET=$(STAGING_DIR)/usr
else
TCPREPLAY_CONF_OPTS += -DWITH_LIBDNET=no
endif

ifeq ($(BR2_PACKAGE_TCPDUMP),y)
TCPREPLAY_CONF_OPTS += -DWITH_TCPDUMP=/usr/sbin/tcpdump
else
TCPREPLAY_CONF_OPTS += -DWITH_TCPDUMP=no
endif

$(eval $(cmake-package))
