################################################################################
#
# xz
#
################################################################################

XZ_VERSION = 5.6.4
XZ_SOURCE = xz-$(XZ_VERSION).tar.bz2
XZ_SITE = https://github.com/tukaani-project/xz/releases/download/v$(XZ_VERSION)
XZ_INSTALL_STAGING = YES
XZ_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'
XZ_LICENSE = Public Domain, BSD-0-Clause, GPL-2.0+, GPL-3.0+, LGPL-2.1+
XZ_LICENSE_FILES = COPYING COPYING.0BSD COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1
XZ_CPE_ID_VENDOR = tukaani
# autoreconf needed to fix a musl static build failure
XZ_AUTORECONF = YES

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_XZ_ADD_CCACHE_DEPENDENCY = NO

# 0001-liblzma-mt-dec-Fix-a-comment.patch
# 0002-liblzma-mt-dec-Simplify-by-removing-the-THR_STOP-sta.patch
# 0003-liblzma-mt-dec-Don-t-free-the-input-buffer-too-early.patch
# 0004-liblzma-mt-dec-Don-t-modify-thr-in_size-in-the-worke.patch
XZ_IGNORE_CVES = CVE-2025-31115

XZ_CONF_OPTS = \
	--enable-encoders=lzma1,lzma2,delta,x86,powerpc,ia64,arm,armthumb,arm64,sparc,riscv \
	--enable-decoders=lzma1,lzma2,delta,x86,powerpc,ia64,arm,armthumb,arm64,sparc,riscv \
	--enable-match-finders=hc3,hc4,bt2,bt3,bt4 \
	--enable-checks=crc32,crc64,sha256 \
	--disable-external-sha256 \
	--enable-microlzma \
	--enable-lzip-decoder \
	--enable-assembler \
	--enable-clmul-crc \
	--enable-arm64-crc32 \
	--disable-small \
	--enable-assume-ram=128 \
	--enable-xz \
	--enable-xzdec \
	--enable-lzmadec \
	--enable-lzmainfo \
	--enable-lzma-links \
	--enable-scripts \
	--enable-sandbox=auto \
	--enable-symbol-versions \
	--enable-rpath \
	--enable-largefile \
	--enable-unaligned-access=auto \
	--disable-unsafe-type-punning \
	--disable-werror \
	--enable-year2038

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
XZ_CONF_OPTS += --enable-nls
else
XZ_CONF_OPTS += --disable-nls
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
XZ_CONF_OPTS += --enable-threads
else
XZ_CONF_OPTS += --disable-threads
endif

HOST_XZ_CONF_OPTS = \
	$(XZ_CONF_OPTS) \
	--enable-nls \
	--enable-threads

# we are built before ccache
HOST_XZ_CONF_ENV = \
	CC="$(HOSTCC_NOCCACHE)" \
	CXX="$(HOSTCXX_NOCCACHE)"

# We need to prevent XZ_AUTORECONF for host builds or we end up with a
# circular dependency. Since the autoconf build needs to extract a
# tar.xz archive, autoconf has an implicit dependency on HOST_XZ. By
# enabling XZ_AUTORECONF we also make host-xz depend on autoconf,
# which we can't do. It is also not necessary as we're autoreconfuring
# the target package to fix static build with musl, which is
# irrelevant for the host package.
HOST_XZ_AUTORECONF = NO

$(eval $(autotools-package))
$(eval $(host-autotools-package))
