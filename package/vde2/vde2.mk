################################################################################
#
# vde2
#
################################################################################

VDE2_VERSION = 2.3.3
VDE2_SITE = $(call github,virtualsquare,vde-2,v$(VDE2_VERSION))
VDE2_LICENSE = GPL-2.0+, LGPL-2.1+
VDE2_LICENSE_FILES = COPYING COPYING.libvdeplug
VDE2_CPE_ID_VENDOR = vde_project
VDE2_CPE_ID_PRODUCT = vde
VDE2_INSTALL_STAGING = YES

# From git
VDE2_AUTORECONF = YES

# Reasons for enabling/disabling stuff:
# - tuntap is enabled in the hope we're using a recent-enough toolchain
#   that does have if_tun.h (virtually everything these days)
# - cryptcab is disabled to not depend on wolfssl
# - pcap is disabled to not depend on libpcap
# - profiling is disabled because we do not want to debug/profile
#
# Note: disabled features can be added with corresponding dependencies
#       in future commits.
VDE2_CONF_OPTS = \
	--disable-cryptcab \
	--disable-experimental \
	--disable-pcap \
	--disable-profile \
	--enable-tuntap

HOST_VDE2_CONF_OPTS = \
	--disable-cryptcab \
	--disable-experimental \
	--disable-pcap \
	--disable-profile \
	--enable-tuntap

$(eval $(autotools-package))
$(eval $(host-autotools-package))
