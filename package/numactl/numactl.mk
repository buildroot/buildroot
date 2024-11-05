################################################################################
#
# numactl
#
################################################################################

NUMACTL_VERSION = 2.0.19
NUMACTL_SITE = \
	https://github.com/numactl/numactl/releases/download/v$(NUMACTL_VERSION)
NUMACTL_LICENSE = LGPL-2.1 (libnuma), GPL-2.0 (programs)
NUMACTL_LICENSE_FILES = LICENSE.GPL2 LICENSE.LGPL2.1
NUMACTL_INSTALL_STAGING = YES
NUMACTL_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

$(eval $(autotools-package))
