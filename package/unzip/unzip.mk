################################################################################
#
# unzip
#
################################################################################

UNZIP_VERSION = 6.0
UNZIP_SOURCE = unzip_$(UNZIP_VERSION).orig.tar.gz
UNZIP_SITE = https://snapshot.debian.org/archive/debian/20250311T215724Z/pool/main/u/unzip
UNZIP_LICENSE = Info-ZIP
UNZIP_LICENSE_FILES = LICENSE
UNZIP_CPE_ID_VALID = YES

# 0009-cve-2014-8139-crc-overflow.patch
UNZIP_IGNORE_CVES += CVE-2014-8139

# 0010-cve-2014-8140-test-compr-eb.patch
UNZIP_IGNORE_CVES += CVE-2014-8140

# 0011-cve-2014-8141-getzip64data.patch
UNZIP_IGNORE_CVES += CVE-2014-8141

# 0012-cve-2014-9636-test-compr-eb.patch
UNZIP_IGNORE_CVES += CVE-2014-9636

# 0018-cve-2014-9913-unzip-buffer-overflow.patch
UNZIP_IGNORE_CVES += CVE-2014-9913

# 0014-cve-2015-7696.patch
UNZIP_IGNORE_CVES += CVE-2015-7696

# 0015-cve-2015-7697.patch
UNZIP_IGNORE_CVES += CVE-2015-7697

# 0019-cve-2016-9844-zipinfo-buffer-overflow.patch
UNZIP_IGNORE_CVES += CVE-2016-9844

# 0007-increase-size-of-cfactorstr.patch
UNZIP_IGNORE_CVES += CVE-2018-18384

# 0020-cve-2018-1000035-unzip-buffer-overflow.patch
UNZIP_IGNORE_CVES += CVE-2018-1000035

# 0022-cve-2019-13232-fix-bug-in-undefer-input.patch
# 0023-cve-2019-13232-zip-bomb-with-overlapped-entries.patch
# 0024-cve-2019-13232-do-not-raise-alert-for-misplaced-central-directory.patch
# 0025-cve-2019-13232-fix-bug-in-uzbunzip2.patch
# 0026-cve-2019-13232-fix-bug-in-uzinflate.patch
UNZIP_IGNORE_CVES += CVE-2019-13232

# 0028-cve-2022-0529-and-cve-2022-0530.patch
UNZIP_IGNORE_CVES += CVE-2022-0529 CVE-2022-0530

# unzip already defines _LARGEFILE_SOURCE and _LARGEFILE64_SOURCE when
# necessary, redefining it on the command line causes some warnings.
UNZIP_TARGET_CFLAGS = \
	$(filter-out -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE,$(TARGET_CFLAGS))

# unzip already defines _LARGEFILE_SOURCE and _LARGEFILE64_SOURCE when
# necessary, redefining it on the command line causes some warnings.
UNZIP_TARGET_CXXFLAGS = \
	$(filter-out -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE,$(TARGET_CXXFLAGS))

UNZIP_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(UNZIP_TARGET_CFLAGS) -DLARGE_FILE_SUPPORT" \
	-DCMAKE_CXX_FLAGS="$(UNZIP_TARGET_CXXFLAGS) -DLARGE_FILE_SUPPORT"

$(eval $(cmake-package))
