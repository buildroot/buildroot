################################################################################
#
# openscap
#
################################################################################

OPENSCAP_VERSION = 1.3.12
OPENSCAP_SITE = https://github.com/OpenSCAP/openscap/releases/download/$(OPENSCAP_VERSION)
OPENSCAP_LICENSE = LGPL-2.1+
OPENSCAP_LICENSE_FILES = COPYING
OPENSCAP_SUPPORTS_IN_SOURCE_BUILD = NO
OPENSCAP_INSTALL_STAGING = YES

OPENSCAP_DEPENDENCIES = \
	host-pkgconf \
	libcurl \
	libxml2 \
	libxmlsec1 \
	libxslt \
	pcre

HOST_OPENSCAP_DEPENDENCIES = \
	host-pkgconf \
	host-libcurl \
	host-libgcrypt \
	host-libxml2 \
	host-libxmlsec1 \
	host-libxslt \
	host-pcre

OPENSCAP_CONF_OPTS = \
	-DENABLE_OSCAP_UTIL=ON \
	-DENABLE_OSCAP_UTIL_DOCKER=OFF \
	-DENABLE_OSCAP_UTIL_CHROOT=OFF \
	-DENABLE_OSCAP_UTIL_PODMAN=OFF \
	-DENABLE_OSCAP_UTIL_VM=OFF \
	-DENABLE_PROBES_WINDOWS=OFF \
	-DENABLE_TESTS=OFF \
	-DWITH_CRYPTO=gcrypt \
	-DENABLE_PYTHON3=OFF

HOST_OPENSCAP_CONF_OPTS = \
	-DENABLE_OSCAP_UTIL=ON \
	-DENABLE_OSCAP_UTIL_DOCKER=OFF \
	-DENABLE_OSCAP_UTIL_CHROOT=OFF \
	-DENABLE_OSCAP_UTIL_PODMAN=OFF \
	-DENABLE_OSCAP_UTIL_VM=OFF \
	-DENABLE_PROBES_WINDOWS=OFF \
	-DENABLE_TESTS=OFF \
	-DWITH_CRYPTO=gcrypt \
	-DENABLE_PYTHON3=OFF

ifeq ($(BR2_PACKAGE_ACL),y)
OPENSCAP_DEPENDENCIES += acl
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
OPENSCAP_DEPENDENCIES += libcap
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
OPENSCAP_DEPENDENCIES += libgcrypt
endif

ifeq ($(BR2_PACKAGE_LIBNSS),y)
OPENSCAP_DEPENDENCIES += libnss
endif

ifneq ($(BR2_TOOLCHAIN_USES_GLIBC),y)
OPENSCAP_DEPENDENCIES += musl-fts
OPENSCAP_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-lfts
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
