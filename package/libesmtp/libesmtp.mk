################################################################################
#
# libesmtp
#
################################################################################

LIBESMTP_VERSION = 1.1.0
LIBESMTP_SITE = $(call github,libesmtp,libESMTP,v$(LIBESMTP_VERSION))
LIBESMTP_INSTALL_STAGING = YES
LIBESMTP_LICENSE = GPL-2.0+ (examples), LGPL-2.1+ (library)
LIBESMTP_LICENSE_FILES = COPYING.GPL LICENSE
LIBESMTP_CPE_ID_VALID = YES

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBESMTP_CONF_OPTS += -Dtls=enabled
LIBESMTP_DEPENDENCIES += openssl
else
LIBESMTP_CONF_OPTS += -Dtls=disabled
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBESMTP_CONF_OPTS += -Dpthreads=enabled
else
LIBESMTP_CONF_OPTS += -Dpthreads=disabled
endif

$(eval $(meson-package))
