################################################################################
#
# bpftool
#
################################################################################

BPFTOOL_VERSION = v6.8.0
BPFTOOL_SITE = https://github.com/libbpf/bpftool
BPFTOOL_SITE_METHOD = git
BPFTOOL_GIT_SUBMODULES = YES
BPFTOOL_LICENSE = GPL-2.0, BSD-2-Clause
BPFTOOL_LICENSE_FILES = LICENSE LICENSE.BSD-2-Clause LICENSE.GPL-2.0
BPFTOOL_DEPENDENCIES = binutils elfutils
HOST_BPFTOOL_DEPENDENCIES = host-elfutils host-pkgconf host-zlib

ifeq ($(BR2_PACKAGE_LIBCAP),y)
BPFTOOL_DEPENDENCIES += libcap
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
BPFTOOL_DEPENDENCIES += zlib
endif

define BPFTOOL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src
endef

define HOST_BPFTOOL_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src
endef

define BPFTOOL_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src install DESTDIR="$(TARGET_DIR)" prefix=/usr
endef

define HOST_BPFTOOL_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src install DESTDIR="$(HOST_DIR)" prefix=/usr
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
