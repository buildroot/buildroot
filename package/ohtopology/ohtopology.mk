################################################################################
#
# ohtopology
#
################################################################################

OHTOPOLOGY_VERSION = 6c1191df0776a87c9c0c5a5fac71a11131bee0ae
OHTOPOLOGY_SITE = $(call github,openhome,ohTopology,$(OHTOPOLOGY_VERSION))
OHTOPOLOGY_LICENSE = BSD-2c
OHTOPOLOGY_LICENSE_FILES = License.txt BsdLicense.txt
OHTOPOLOGY_DEPENDENCIES = ohnet ohnetgenerated

# static library only
OHTOPOLOGY_INSTALL_STAGING = YES
OHTOPOLOGY_INSTALL_TARGET = NO

OHTOPOLOGY_CONF_OPTS = \
	-DBUILD_STATIC_LIBS=ON \
	-DBUILD_SHARED_LIBS=OFF

$(eval $(cmake-package))
