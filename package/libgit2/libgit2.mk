################################################################################
#
# libgit2
#
################################################################################

LIBGIT2_VERSION = 1.9.0
LIBGIT2_SITE = $(call github,libgit2,libgit2,v$(LIBGIT2_VERSION))
LIBGIT2_LICENSE = \
	GPL-2.0 with linking exception, \
	MIT (sha1), \
	BSD-3-Clause (sha256), \
	wildmatch license (wildmatch), \
	CC0-1.0 (xoroshiro256), \
	BSD-2-Clause (basename_r), \
	LGPL-2.1+ (libxdiff)
LIBGIT2_LICENSE_FILES = COPYING
LIBGIT2_CPE_ID_VALID = YES
LIBGIT2_INSTALL_STAGING = YES

LIBGIT2_CONF_OPTS = \
	-DUSE_GSSAPI=OFF \
	-DUSE_ICONV=ON \
	-DREGEX_BACKEND=regcomp \
	-DUSE_HTTP_PARSER=http-parser \
	-DUSE_NTLMCLIENT=OFF \
	-DUSE_XDIFF=builtin \
	-DUSE_THREADS=$(if $(BR2_TOOLCHAIN_HAS_THREADS),ON,OFF)

LIBGIT2_SUPPORTS_IN_SOURCE_BUILD = NO

LIBGIT2_DEPENDENCIES = zlib libhttpparser

# If libiconv is available (for !locale toolchains), then we can use
# it for iconv support. Note that USE_ICONV=ON is still correct even
# without libiconv because (1) most toolchain have iconv support
# without libiconv and (2) even if USE_ICONV=ON but iconv support is
# not available, libgit2 simply avoids using iconv.
ifeq ($(BR2_PACKAGE_LIBICONV),y)
LIBGIT2_DEPENDENCIES += libiconv
endif

ifeq ($(BR2_PACKAGE_LIBSSH2),y)
LIBGIT2_DEPENDENCIES += libssh2
LIBGIT2_CONF_OPTS += -DUSE_SSH=libssh2
else ifeq ($(BR2_PACKAGE_OPENSSH_CLIENT),y)
LIBGIT2_CONF_OPTS += -DUSE_SSH=exec
else
LIBGIT2_CONF_OPTS += -DUSE_SSH=OFF
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBGIT2_DEPENDENCIES += openssl
LIBGIT2_CONF_OPTS += -DUSE_HTTPS=OpenSSL
else
LIBGIT2_CONF_OPTS += -DUSE_HTTPS=OFF
endif

ifeq ($(BR2_PACKAGE_LIBGIT2_CLI),y)
LIBGIT2_CONF_OPTS += -DBUILD_CLI=ON
else
LIBGIT2_CONF_OPTS += -DBUILD_CLI=OFF
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBGIT2_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
