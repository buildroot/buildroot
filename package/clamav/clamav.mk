################################################################################
#
# clamav
#
################################################################################

CLAMAV_VERSION = 1.0.8
CLAMAV_SITE = https://www.clamav.net/downloads/production
CLAMAV_LICENSE = GPL-2.0
CLAMAV_LICENSE_FILES = \
	COPYING.txt \
	COPYING/COPYING.bzip2 \
	COPYING/COPYING.file \
	COPYING/COPYING.getopt \
	COPYING/COPYING.LGPL \
	COPYING/COPYING.llvm \
	COPYING/COPYING.lzma \
	COPYING/COPYING.pcre \
	COPYING/COPYING.regex \
	COPYING/COPYING.unrar \
	COPYING/COPYING.zlib
CLAMAV_CPE_ID_VENDOR = clamav
CLAMAV_SELINUX_MODULES = clamav
# affects only Cisco devices
CLAMAV_IGNORE_CVES += CVE-2016-1405
CLAMAV_DEPENDENCIES = \
	bzip2 \
	host-pkgconf \
	host-rustc \
	json-c \
	libcurl \
	libmspack \
	libxml2 \
	openssl \
	pcre2 \
	zlib \
	$(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
CLAMAV_LIBS += -latomic
endif

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
CLAMAV_DEPENDENCIES += musl-fts
CLAMAV_LIBS += -lfts
endif

CLAMAV_CONF_OPTS = \
	-DCMAKE_EXE_LINKER_FLAGS="$(CLAMAV_LIBS)" \
	-DCMAKE_SKIP_INSTALL_RPATH=ON \
	-DENABLE_JSON_SHARED=ON \
	-DENABLE_MAN_PAGES=OFF \
	-DENABLE_MILTER=OFF \
	-DENABLE_TESTS=OFF \
	-DHAVE_SYSTEM_LFS_FTS=ON \
	-DRUST_COMPILER_TARGET=$(RUSTC_TARGET_NAME) \
	-Dtest_run_result=ON \
	-Dtest_run_result__TRYRUN_OUTPUT=ON

ifeq ($(BR2_PACKAGE_NCURSES),y)
CLAMAV_CONF_OPTS += -DENABLE_APP=ON
CLAMAV_DEPENDENCIES += ncurses
ifeq ($(BR2_INIT_SYSTEMD),y)
CLAMAV_CONF_OPTS += -DENABLE_SYSTEMD=ON
CLAMAV_DEPENDENCIES += systemd
else
CLAMAV_CONF_OPTS += -DENABLE_SYSTEMD=OFF
endif
else
CLAMAV_CONF_OPTS += -DENABLE_APP=OFF -DENABLE_SYSTEMD=OFF
endif

$(eval $(cmake-package))
