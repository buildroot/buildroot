################################################################################
#
# jasper
#
################################################################################

JASPER_VERSION = 4.2.8
JASPER_SITE = https://github.com/jasper-software/jasper/releases/download/version-$(JASPER_VERSION)
JASPER_INSTALL_STAGING = YES
JASPER_LICENSE = JasPer-2.0
JASPER_LICENSE_FILES = LICENSE.txt
JASPER_CPE_ID_VALID = YES
JASPER_SUPPORTS_IN_SOURCE_BUILD = NO
JASPER_CONF_OPTS = \
	-DJAS_ENABLE_DOC=OFF \
	-DJAS_ENABLE_PROGRAMS=OFF

# Despite using JASPER_SUPPORTS_IN_SOURCE_BUILD = NO jasper detects an
# in-source-build because a subdirectory inside the source directory
# is used so we need to force the build.
JASPER_CONF_OPTS += \
	-DALLOW_IN_SOURCE_BUILD=ON

# When cross-compiling, we have to feed in the C++ standard to use,
# upstream doesn't want to auto-detect it:
# https://github.com/jasper-software/jasper/issues/358
JASPER_STDC_VERSION="`echo __STDC_VERSION__ | $(TARGET_CROSS)cpp -E -P -`"
JASPER_CONF_OPTS += \
	-DJAS_STDC_VERSION=$(JASPER_STDC_VERSION)

ifeq ($(BR2_STATIC_LIBS),y)
JASPER_CONF_OPTS += -DJAS_ENABLE_SHARED=OFF
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
JASPER_CONF_OPTS += -DJAS_ENABLE_LIBJPEG=ON
JASPER_DEPENDENCIES += jpeg
else
JASPER_CONF_OPTS += -DJAS_ENABLE_LIBJPEG=OFF
endif

JASPER_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
JASPER_CFLAGS += -O0
endif

JASPER_CONF_OPTS += -DCMAKE_C_FLAGS="$(JASPER_CFLAGS)"

$(eval $(cmake-package))
