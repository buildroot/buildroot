################################################################################
#
# libbpf
#
################################################################################

LIBBPF_VERSION = 1.6.2
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

# bpftrace uses btf_enum64 that was added since kernel 6.0 so we need to
# update some uapi headers in STAGING_DIR if the toolchain is build with
# linux-headers < 6.0.
# Otherwise bpftrace is broken due to out of date linux/bpf.h installed
# by the toolchain.
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=6089fb325cf737eeb2c4d236c94697112ca860da
# https://github.com/bpftrace/bpftrace/commit/d4f58382270c21b2c718aa0a6574c105f29e77a9
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_6_0),)
LIBBPF_UPDATE_UAPI_HEADERS = install_uapi_headers UAPIDIR=/usr/include/bpf

define LIBBPF_FIX_STAGING_PC
	$(SED) 's/-I$${includedir}/-I$${includedir}\/bpf -I$${includedir}/' $(STAGING_DIR)/usr/lib/pkgconfig/libbpf.pc
endef
LIBBPF_POST_INSTALL_STAGING_HOOKS += LIBBPF_FIX_STAGING_PC
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
