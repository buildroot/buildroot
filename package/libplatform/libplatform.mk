################################################################################
#
# libplatform
#
################################################################################

LIBPLATFORM_VERSION = a7cd0d5780ed80a4e70480d1650749f29e8a1fb2
LIBPLATFORM_SITE = $(call github,Pulse-Eight,platform,$(LIBPLATFORM_VERSION))
LIBPLATFORM_LICENSE = GPL-2.0+
LIBPLATFORM_LICENSE_FILES = src/os.h
LIBPLATFORM_INSTALL_STAGING = YES

ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_5),)
LIBPLATFORM_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -std=c++11"
endif

$(eval $(cmake-package))
