################################################################################
#
# libest
#
################################################################################

LIBEST_VERSION = f8a6e5b53a5f70e72fe4029981df0693b17cbb32
LIBEST_SITE = $(call github,cisco,libest,$(LIBEST_VERSION))
# We don't build examples, so we're not affected by the OpenSSL
# license
LIBEST_LICENSE = BSD-3-Clause, MIT, W3C
LIBEST_LICENSE_FILES = LICENSE
LIBEST_INSTALL_STAGING = YES
LIBEST_AUTORECONF = YES
LIBEST_DEPENDENCIES = openssl host-pkgconf safeclib
# libcoap support is explicitly disabled because it breaks the build
# libsafec support is explicitly enabled because we want to avoid
# possible hidden use of bundled copy of library.
LIBEST_CONF_OPTS = \
	--with-ssl-dir=$(STAGING_DIR)/usr \
	$(if $(BR2_TOOLCHAIN_HAS_THREADS),--enable-pthreads,--disable-pthreads) \
	$(if $(BR2_PACKAGE_LIBEST_BRSKI),--enable-brski,--disable-brski) \
	--disable-examples \
	--without-libcoap-dir \
	--with-system-libsafec

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
LIBEST_DEPENDENCIES += libexecinfo
LIBEST_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -lexecinfo"
endif

ifeq ($(BR2_PACKAGE_LIBEST_MODE_CLIENT_ONLY),y)
LIBEST_CONF_OPTS += --enable-client-only
else
LIBEST_CONF_OPTS += --disable-client-only
endif

ifeq ($(BR2_PACKAGE_OPENJDK),y)
LIBEST_MAKE_ENV += JAVA_HOME=$(HOST_DIR)/lib/jvm
LIBEST_CONF_ENV += JAVA_HOME=$(HOST_DIR)/lib/jvm
LIBEST_CONF_OPTS += --enable-jni
LIBEST_DEPENDENCIES += openjdk
else
LIBEST_CONF_OPTS += --disable-jni
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
LIBEST_CONF_OPTS += --with-libcurl-dir=$(STAGING_DIR)/usr
LIBEST_DEPENDENCIES += libcurl
else
LIBEST_CONF_OPTS += --without-libcurl-dir
endif

ifeq ($(BR2_PACKAGE_LIBURIPARSER),y)
LIBEST_CONF_OPTS += --with-uriparser-dir=$(STAGING_DIR)/usr
LIBEST_DEPENDENCIES += liburiparser
else
LIBEST_CONF_OPTS += --without-uriparser-dir
endif

define LIBEST_INSTALL_PC
	$(INSTALL) -c -m 0644 $(LIBEST_PKGDIR)/libest.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/libest.pc
endef
LIBEST_POST_INSTALL_STAGING_HOOKS += LIBEST_INSTALL_PC

$(eval $(autotools-package))
