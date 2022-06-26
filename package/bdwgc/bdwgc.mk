################################################################################
#
# bdwgc
#
################################################################################

BDWGC_VERSION = 8.0.6
BDWGC_SOURCE = gc-$(BDWGC_VERSION).tar.gz
BDWGC_SITE = https://github.com/ivmai/bdwgc/releases/download/v$(BDWGC_VERSION)
BDWGC_INSTALL_STAGING = YES
BDWGC_LICENSE = bdwgc license
BDWGC_LICENSE_FILES = README.QUICK
BDWGC_CPE_ID_VENDOR = bdwgc_project
BDWGC_DEPENDENCIES = libatomic_ops host-pkgconf
HOST_BDWGC_DEPENDENCIES = host-libatomic_ops host-pkgconf

BDWGC_CONF_OPTS = CFLAGS_EXTRA="$(BDWGC_CFLAGS_EXTRA)"
ifeq ($(BR2_sparc),y)
BDWGC_CFLAGS_EXTRA += -DAO_NO_SPARC_V9
endif
ifeq ($(BR2_STATIC_LIBS),y)
BDWGC_CFLAGS_EXTRA += -DGC_NO_DLOPEN
endif
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS_NPTL),)
BDWGC_CFLAGS_EXTRA += -DNO_PTHREAD_GETATTR_NP
endif

# Ensure we use the system libatomic_ops, and not the internal one.
BDWGC_CONF_OPTS += --with-libatomic-ops=yes
HOST_BDWGC_CONF_OPTS = --with-libatomic-ops=yes

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
BDWGC_CONF_OPTS += --enable-cplusplus
else
BDWGC_CONF_OPTS += --disable-cplusplus
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
