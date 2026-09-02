################################################################################
#
# clamav
#
################################################################################

CLAMAV_VERSION = 1.4.3
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

# 0001-fix-possible-panic-when-scanning-some-html-files.patch
CLAMAV_IGNORE_CVES += CVE-2026-20031

# 0002-libclamav-fix-pespin-cleanup-bitmap-tracking-47.patch
CLAMAV_IGNORE_CVES += CVE-2026-20217

# 0003-libclamav-fix-aspack-triggered-rebuild-pe-overflow-49.patch
CLAMAV_IGNORE_CVES += CVE-2026-20213

# 0004-libclamav-enforce-installshield-extraction-limits-55.patch
CLAMAV_IGNORE_CVES += CVE-2026-20216

# 0005-libclamav-fix-fsg-section-loop-underflow-51.patch
CLAMAV_IGNORE_CVES += CVE-2026-20214

# 0006-fix-alz-parser-robustness-and-scan-coverage-63.patch
CLAMAV_IGNORE_CVES += CVE-2026-20243

# 0007-libclamav-fix-7z-substream-count-overflow-53.patch
CLAMAV_IGNORE_CVES += CVE-2026-20215

# 0008-fix-32-bit-dmg-mish-size-checks-65.patch
CLAMAV_IGNORE_CVES += CVE-2026-20244

# 0010-libclamav-fix-gpt-partition-name-conversion-index-103.patch
CLAMAV_IGNORE_CVES += CVE-2026-20345

# 0011-libclamav-fix-pespin-rebuilt-section-size-overflow-101.patch
CLAMAV_IGNORE_CVES += CVE-2026-20339

# 0012-libclamav-guard-pdf-hex-string-newline-skip-98.patch
CLAMAV_IGNORE_CVES += CVE-2026-20346

# 0013-libclamav-harden-mach-o-section-validation-96.patch
CLAMAV_IGNORE_CVES += CVE-2026-20347

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
