################################################################################
#
# sigsum-c
#
################################################################################

SIGSUM_C_VERSION = v1.1.0
SIGSUM_C_SITE = https://git.glasklar.is/sigsum/core/sigsum-c
SIGSUM_C_SITE_METHOD = git
SIGSUM_C_LICENSE = BSD-2-Clause
SIGSUM_C_LICENSE_FILES = LICENSE
SIGSUM_C_INSTALL_STAGING = YES
SIGSUM_C_DEPENDENCIES = nettle

SIGSUM_C_AUTORECONF = YES

ifneq ($(BR2_PACKAGE_SIGSUM_C_TOOLS),y)
SIGSUM_C_CONF_OPTS += --disable-tools
endif

$(eval $(autotools-package))
