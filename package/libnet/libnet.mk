################################################################################
#
# libnet
#
################################################################################

LIBNET_VERSION = 1.2
LIBNET_SITE = \
	https://github.com/libnet/libnet/releases/download/v$(LIBNET_VERSION)
LIBNET_INSTALL_STAGING = YES
# PF_PACKET is always available on Linux
LIBNET_CONF_OPTS = libnet_cv_have_packet_socket=yes
LIBNET_LICENSE = BSD-2-Clause, BSD-3-Clause
LIBNET_LICENSE_FILES = LICENSE
LIBNET_CPE_ID_VENDOR = libnet_project
LIBNET_CONFIG_SCRIPTS = libnet-config

$(eval $(autotools-package))
