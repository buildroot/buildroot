################################################################################
#
# libbpf
#
################################################################################

LIBBPF_VERSION = 1.1.0
LIBBPF_SITE = $(call github,libbpf,libbpf,v$(LIBBPF_VERSION))
LIBBPF_LICENSE = GPL-2.0, LGPL-2.1, BSD-2-Clause
LIBBPF_LICENSE_FILES = LICENSE LICENSE.BSD-2-Clause LICENSE.LGPL-2.1
LIBBPF_CPE_ID_VALID = YES
LIBBPF_DEPENDENCIES = host-bison host-flex host-pkgconf elfutils zlib
HOST_LIBBPF_DEPENDENCIES = host-bison host-flex host-pkgconf host-elfutils host-zlib
LIBBPF_INSTALL_STAGING = YES

define LIBBPF_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src
endef

# bpf/bpf.h installed by libbpf uses bpf_iter_link_info that was added since
# kernel 5.9, so we need to update some uapi headers in STAGING_DIR if the
# toolchain is build with linux-headers < 5.9.
# Otherwise bpf/bpf.h is broken due to out of date linux/bpf.h installed by the
# toolchain.
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a5cbe05a6673b85bed2a63ffcfea6a96c6410cff
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_5_9),)
LIBBPF_UPDATE_UAPI_HEADERS = install_uapi_headers
endif

define LIBBPF_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src install $(LIBBPF_UPDATE_UAPI_HEADERS) \
		DESTDIR=$(STAGING_DIR)
endef

define LIBBPF_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src install DESTDIR=$(TARGET_DIR)
endef

define HOST_LIBBPF_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/src install install_uapi_headers DESTDIR=$(HOST_DIR)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
