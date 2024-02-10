################################################################################
#
# pugixml
#
################################################################################

PUGIXML_VERSION = 1.14
PUGIXML_SITE = https://github.com/zeux/pugixml/releases/download/v$(PUGIXML_VERSION)
PUGIXML_LICENSE = MIT
PUGIXML_LICENSE_FILES = LICENSE.md
PUGIXML_CPE_ID_VALID = YES

PUGIXML_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_PUGIXML_XPATH_SUPPORT),y)
PUGIXML_CONF_OPTS += -DPUGIXML_NO_XPATH=OFF
else
PUGIXML_CONF_OPTS += -DPUGIXML_NO_XPATH=ON
endif

ifeq ($(BR2_PACKAGE_PUGIXML_COMPACT),y)
PUGIXML_CONF_OPTS += -DPUGIXML_COMPACT=ON
else
PUGIXML_CONF_OPTS += -DPUGIXML_COMPACT=OFF
endif

# Pugixml will automatically enable 'long long' support on C++11 compilers,
# which means gcc 4.8+. As gcc always supports the 'long long' type,
# force-enable this option to support older gcc versions. See also:
# https://gcc.gnu.org/onlinedocs/gcc/Long-Long.html
PUGIXML_BUILD_DEFINES += PUGIXML_HAS_LONG_LONG
HOST_PUGIXML_BUILD_DEFINES += PUGIXML_HAS_LONG_LONG

PUGIXML_CONF_OPTS += -DPUGIXML_BUILD_DEFINES="$(subst $(space),;,$(PUGIXML_BUILD_DEFINES))"

HOST_PUGIXML_CONF_OPTS += \
	-DBUILD_PKGCONFIG=ON \
	-DPUGIXML_BUILD_DEFINES="$(subst $(space),;,$(HOST_PUGIXML_BUILD_DEFINES))"

$(eval $(cmake-package))
$(eval $(host-cmake-package))
