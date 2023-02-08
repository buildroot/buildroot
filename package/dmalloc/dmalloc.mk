################################################################################
#
# dmalloc
#
################################################################################

DMALLOC_VERSION = 5.6.5
DMALLOC_SOURCE = dmalloc-$(DMALLOC_VERSION).tgz
DMALLOC_SITE = http://dmalloc.com/releases

DMALLOC_LICENSE = ISC
DMALLOC_LICENSE_FILES = LICENSE.txt

DMALLOC_INSTALL_STAGING = YES
DMALLOC_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_STATIC_LIBS),y)
DMALLOC_CONF_OPTS += --disable-shlib
else
DMALLOC_CONF_OPTS += --enable-shlib
DMALLOC_CFLAGS += -fPIC
endif

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
DMALLOC_CONF_OPTS += --enable-cxx
else
DMALLOC_CONF_OPTS += --disable-cxx
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
DMALLOC_CONF_OPTS += --enable-threads
else
DMALLOC_CONF_OPTS += --disable-threads
endif

# dmalloc has some assembly function that are not present in thumb1 mode:
# Error: lo register required -- `str lr,[sp,#4]'
# so, we desactivate thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
DMALLOC_CFLAGS += -marm
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_63261),y)
DMALLOC_CFLAGS += -O0
endif

DMALLOC_CONF_ENV = \
	CFLAGS="$(DMALLOC_CFLAGS)" \
	ac_cv_page_size=12 \
	ac_cv_strdup_macro=yes \
	ac_cv_strndup_macro=yes

# both DESTDIR and PREFIX are ignored..
define DMALLOC_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) includedir="$(STAGING_DIR)/usr/include" \
		bindir="$(STAGING_DIR)/usr/bin" \
		libdir="$(STAGING_DIR)/usr/lib" \
		shlibdir="$(STAGING_DIR)/usr/lib" \
		infodir="$(STAGING_DIR)/usr/share/info/" \
		-C $(@D) install
endef

ifeq ($(BR2_STATIC_LIBS),)
define DMALLOC_INSTALL_SHARED_LIB
	cp -dpf $(STAGING_DIR)/usr/lib/libdmalloc*.so $(TARGET_DIR)/usr/lib
endef
endif

define DMALLOC_INSTALL_TARGET_CMDS
	$(DMALLOC_INSTALL_SHARED_LIB)
	cp -dpf $(STAGING_DIR)/usr/bin/dmalloc $(TARGET_DIR)/usr/bin/dmalloc
endef

$(eval $(autotools-package))
