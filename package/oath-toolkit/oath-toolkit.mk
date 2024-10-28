################################################################################
#
# oath-toolkit
#
################################################################################

OATH_TOOLKIT_VERSION = 2.6.12
OATH_TOOLKIT_SITE = https://download.savannah.nongnu.org/releases/oath-toolkit
OATH_TOOLKIT_LICENSE = GPL-3.0+ (tools), LGPL-2.1+ (libraries)
OATH_TOOLKIT_LICENSE_FILES = \
	COPYING \
	liboath/COPYING \
	oathtool/COPYING \
	pam_oath/COPYING
OATH_TOOLKIT_CPE_ID_VENDOR = nongnu
OATH_TOOLKIT_CPE_ID_PRODUCT = oath_toolkit
OATH_TOOLKIT_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
# Set the pam directory defined in linux-pam (see --enable-securedir
# in LINUX_PAM_CONF_OPTS in package/linux-pam/linux-pam.mk).
OATH_TOOLKIT_CONF_OPTS += \
	--enable-pam \
	--with-pam-dir=/lib/security
OATH_TOOLKIT_DEPENDENCIES += linux-pam
else
OATH_TOOLKIT_CONF_OPTS += --disable-pam
endif

ifeq ($(BR2_PACKAGE_OATH_TOOLKIT_PSKC),y)
OATH_TOOLKIT_CONF_OPTS += --enable-pskc
OATH_TOOLKIT_DEPENDENCIES += host-libxml2 libxml2
else
OATH_TOOLKIT_CONF_OPTS += --disable-pskc
endif

$(eval $(autotools-package))
