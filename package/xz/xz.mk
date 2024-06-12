################################################################################
#
# xz
#
################################################################################

XZ_VERSION = 5.6.2
XZ_SOURCE = xz-$(XZ_VERSION).tar.bz2
XZ_SITE = https://github.com/tukaani-project/xz/releases/download/v$(XZ_VERSION)
XZ_INSTALL_STAGING = YES
XZ_LICENSE = Public Domain, BSD-0-Clause, GPL-2.0+, GPL-3.0+, LGPL-2.1+
XZ_LICENSE_FILES = COPYING COPYING.0BSD COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1
XZ_CPE_ID_VENDOR = tukaani

XZ_CONF_OPTS = \
	-DENCODERS="lzma1;lzma2;delta;x86;powerpc;ia64;arm;armthumb;arm64;sparc;riscv" \
	-DDECODERS="lzma1;lzma2;delta;x86;powerpc;ia64;arm;armthumb;arm64;sparc;riscv" \
	-DMATCH_FINDERS="hc3;hc4;bt2;bt3;bt4" \
	-DADDITIONAL_CHECK_TYPES="crc64;sha256" \
	-DMICROLZMA_ENCODER=ON \
	-DMICROLZMA_DECODER=ON \
	-DLZIP_DECODER=ON \
	-DALLOW_CLMUL_CRC=ON \
	-DALLOW_ARM64_CRC32=ON \
	-DENABLE_SMALL=OFF \
	-DENABLE_SANDBOX=ON \
	-DCREATE_XZ_SYMLINKS=ON \
	-DCREATE_LZMA_SYMLINKS=ON \
	-DBUILD_SHARED_LIBS=OFF

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
XZ_CONF_OPTS += -DENABLE_NLS=ON
else
XZ_CONF_OPTS += -DENABLE_NLS=OFF
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
XZ_CONF_OPTS += -DENABLE_THREADS=ON
else
XZ_CONF_OPTS += -DENABLE_THREADS=OFF
endif

# we are built before ccache
HOST_XZ_CONF_OPTS = \
	$(XZ_CONF_OPTS) \
	-DENABLE_NLS=ON \
	-DENABLE_THREADS=ON \
	-DCMAKE_C_COMPILER_LAUNCHER="" \
	-DCMAKE_CXX_COMPILER_LAUNCHER==""

$(eval $(cmake-package))
$(eval $(host-cmake-package))
