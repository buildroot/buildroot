################################################################################
#
# kmod
#
################################################################################

KMOD_VERSION = 34.2
KMOD_SOURCE = kmod-$(KMOD_VERSION).tar.xz
KMOD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kernel/kmod
KMOD_INSTALL_STAGING = YES
KMOD_DEPENDENCIES = host-pkgconf
HOST_KMOD_DEPENDENCIES = host-pkgconf

# license info for libkmod only, conditionally add more below
KMOD_LICENSE = LGPL-2.1+ (library)
KMOD_LICENSE_FILES = libkmod/COPYING

KMOD_CPE_ID_VENDOR = kernel

KMOD_CONF_OPTS = -Dmanpages=false
HOST_KMOD_CONF_OPTS = -Dmanpages=false

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
KMOD_CONF_OPTS += -Dbashcompletiondir=/usr/share/bash-completion/completions
else
KMOD_CONF_OPTS += -Dbashcompletiondir=no
endif

KMOD_CONF_OPTS += -Dfishcompletiondir=no -Dzshcompletiondir=no

# load compression libraries (if any are enabled below) as needed
# using dlopen()
KMOD_CONF_OPTS += -Ddlopen=all

ifeq ($(BR2_PACKAGE_ZLIB),y)
KMOD_DEPENDENCIES += zlib
KMOD_CONF_OPTS += -Dzlib=enabled
else
KMOD_CONF_OPTS += -Dzlib=disabled
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
KMOD_DEPENDENCIES += zstd
KMOD_CONF_OPTS += -Dzstd=enabled
else
KMOD_CONF_OPTS += -Dzstd=disabled
endif

ifeq ($(BR2_PACKAGE_XZ),y)
KMOD_DEPENDENCIES += xz
KMOD_CONF_OPTS += -Dxz=enabled
else
KMOD_CONF_OPTS += -Dxz=disabled
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
KMOD_DEPENDENCIES += openssl
KMOD_CONF_OPTS += -Dopenssl=enabled
else
KMOD_CONF_OPTS += -Dopenssl=disabled
endif

ifeq ($(BR2_PACKAGE_KMOD_TOOLS),y)

# add license info for kmod tools
KMOD_LICENSE += , GPL-2.0+ (tools)
KMOD_LICENSE_FILES += COPYING

ifeq ($(BR2_ROOTFS_MERGED_USR),)
# Busybox would install its modutils symlinks to /sbin, so kmod needs
# to do the same to take priority (Busybox won't overwrite them, see
# its install-noclobber).
KMOD_CONF_OPTS += -Dsbindir=/sbin
endif

else
KMOD_CONF_OPTS += -Dtools=false
endif

ifeq ($(BR2_PACKAGE_HOST_KMOD_GZ),y)
HOST_KMOD_DEPENDENCIES += host-zlib
HOST_KMOD_CONF_OPTS += -Dzlib=enabled
else
HOST_KMOD_CONF_OPTS += -Dzlib=disabled
endif

ifeq ($(BR2_PACKAGE_HOST_KMOD_ZSTD),y)
HOST_KMOD_DEPENDENCIES += host-zstd
HOST_KMOD_CONF_OPTS += -Dzstd=enabled
else
HOST_KMOD_CONF_OPTS += -Dzstd=disabled
endif

ifeq ($(BR2_PACKAGE_HOST_KMOD_XZ),y)
HOST_KMOD_DEPENDENCIES += host-xz
HOST_KMOD_CONF_OPTS += -Dxz=enabled
else
HOST_KMOD_CONF_OPTS += -Dxz=disabled
endif

HOST_KMOD_CONF_OPTS += -Dopenssl=disabled

$(eval $(meson-package))
$(eval $(host-meson-package))
