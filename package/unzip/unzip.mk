################################################################################
#
# unzip
#
################################################################################

UNZIP_VERSION = 6.0
UNZIP_SOURCE = unzip_$(UNZIP_VERSION).orig.tar.gz
UNZIP_PATCH = unzip_$(UNZIP_VERSION)-27.debian.tar.xz
UNZIP_SITE = https://snapshot.debian.org/archive/debian/20220916T090657Z/pool/main/u/unzip
UNZIP_LICENSE = Info-ZIP
UNZIP_LICENSE_FILES = LICENSE
UNZIP_CPE_ID_VALID = YES

# unzip_$(UNZIP_VERSION)-27.debian.tar.xz has patches to fix:
UNZIP_IGNORE_CVES = \
	CVE-2014-8139 \
	CVE-2014-8140 \
	CVE-2014-8141 \
	CVE-2014-9636 \
	CVE-2014-9913 \
	CVE-2015-7696 \
	CVE-2015-7697 \
	CVE-2016-9844 \
	CVE-2018-18384 \
	CVE-2018-1000035 \
	CVE-2019-13232 \
	CVE-2022-0529 \
	CVE-2022-0530

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
