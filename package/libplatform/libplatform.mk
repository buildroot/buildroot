################################################################################
#
# libplatform
#
################################################################################

LIBPLATFORM_VERSION = 2748be52ae27e6007ef548b697d4a03ff7de4291
LIBPLATFORM_SITE = $(call github,Pulse-Eight,platform,$(LIBPLATFORM_VERSION))
LIBPLATFORM_LICENSE = GPL-2.0+
LIBPLATFORM_LICENSE_FILES = LICENSE.md
LIBPLATFORM_INSTALL_STAGING = YES

$(eval $(cmake-package))
