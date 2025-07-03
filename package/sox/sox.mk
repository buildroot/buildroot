################################################################################
#
# sox
#
################################################################################

SOX_VERSION = 7524160b29a476f7e87bc14fddf12d349f9a3c5e
SOX_SITE = https://git.code.sf.net/p/sox/code
SOX_SITE_METHOD = git
SOX_DEPENDENCIES = host-autoconf-archive host-pkgconf
SOX_LICENSE = GPL-2.0+ (sox binary), LGPL-2.1+ (libraries)
SOX_LICENSE_FILES = LICENSE.GPL LICENSE.LGPL
SOX_CPE_ID_VENDOR = sound_exchange_project
SOX_CPE_ID_PRODUCT = sound_exchange
# The Git commit in SOX_VERSION is 14.4.2 + a large number of commits
SOX_CPE_ID_VERSION = 14.4.2
# From git and we're patching configure.ac
SOX_AUTORECONF = YES
SOX_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive
SOX_INSTALL_STAGING = YES

# sox-14.4.2-6-g6e177c45
SOX_IGNORE_CVES += CVE-2017-11332

# sox-14.4.2-7-ge410d00c
SOX_IGNORE_CVES += CVE-2017-11358

# sox-14.4.2-8-g7b3f30e1
SOX_IGNORE_CVES += CVE-2017-11359

# sox-14.4.2-9-ge076a7ad
SOX_IGNORE_CVES += CVE-2017-15370

# sox-14.4.2-10-g968c689a
SOX_IGNORE_CVES += CVE-2017-15371

# sox-14.4.2-11-g515b9861
SOX_IGNORE_CVES += CVE-2017-15372

# sox-14.4.2-12-gf56c0dbc
SOX_IGNORE_CVES += CVE-2017-15642

# sox-14.4.2-13-g09d7388c
# CVE-2019-1010004 is a duplicate of CVE-2017-18189
SOX_IGNORE_CVES += CVE-2017-18189 CVE-2019-1010004

# sox-14.4.2-38-gf7091126
SOX_IGNORE_CVES += CVE-2019-8354

# sox-14.4.2-39-gf8587e2d
SOX_IGNORE_CVES += CVE-2019-8355

# sox-14.4.2-40-gb7883ae1
SOX_IGNORE_CVES += CVE-2019-8356

# sox-14.4.2-41-g2ce02fea
SOX_IGNORE_CVES += CVE-2019-8357

# sox-14.4.2-44-g7b6a8892
SOX_IGNORE_CVES += CVE-2019-13590

# 0006-voc-word-width-should-never-be-0-to-avoid-division-b.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to sox_project:sox in the NVD database
SOX_IGNORE_CVES += CVE-2021-3643 CVE-2021-23210

# 0007-hcom-validate-dictsize.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to sox_project:sox in the NVD database
SOX_IGNORE_CVES += CVE-2021-23159 CVE-2021-23172 CVE-2023-34318 CVE-2023-34432

# 0008-phere-avoid-integer-underflow.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to libsox_project:libsox in the NVD database
SOX_IGNORE_CVES += CVE-2021-40426

# 0009-formats-aiff-reject-implausibly-large-number-of-chan.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to sox_project:sox in the NVD database
SOX_IGNORE_CVES += CVE-2022-31650 CVE-2023-26590

# 0010-formats-reject-implausible-rate.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to sox_project:sox in the NVD database
SOX_IGNORE_CVES += CVE-2022-31651

# 0011-CVE-2023-32627-Filter-null-sampling-rate-in-VOC-code.patch
# This entry is NOT stale, those CVEs are not reported by pkg-stats
# due to the change of CPE ID to sox_project:sox in the NVD database
SOX_IGNORE_CVES += CVE-2023-32627

SOX_CONF_OPTS = \
	--with-distro="Buildroot" \
	--disable-stack-protector

SOX_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
SOX_CFLAGS += -O0
endif

SOX_CONF_ENV += CFLAGS="$(SOX_CFLAGS)"

ifeq ($(BR2_PACKAGE_ALSA_LIB_PCM),y)
SOX_DEPENDENCIES += alsa-lib
SOX_CONF_OPTS += --enable-alsa
else
SOX_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_FILE),y)
SOX_DEPENDENCIES += file
SOX_CONF_OPTS += --enable-magic
else
SOX_CONF_OPTS += --disable-magic
endif

ifeq ($(BR2_PACKAGE_FLAC),y)
SOX_DEPENDENCIES += flac
SOX_CONF_OPTS += --enable-flac
else
SOX_CONF_OPTS += --disable-flac
endif

ifeq ($(BR2_PACKAGE_LAME),y)
SOX_DEPENDENCIES += lame
SOX_CONF_OPTS += --with-lame
else
SOX_CONF_OPTS += --without-lame
endif

ifeq ($(BR2_PACKAGE_LIBAO),y)
SOX_DEPENDENCIES += libao
SOX_CONF_OPTS += --enable-ao
else
SOX_CONF_OPTS += --disable-ao
endif

ifeq ($(BR2_PACKAGE_LIBGSM),y)
SOX_DEPENDENCIES += libgsm
SOX_CONF_OPTS += --enable-gsm
else
SOX_CONF_OPTS += --disable-gsm
endif

ifeq ($(BR2_PACKAGE_LIBID3TAG),y)
SOX_DEPENDENCIES += libid3tag
SOX_CONF_OPTS += --with-id3tag
else
SOX_CONF_OPTS += --without-id3tag
endif

ifeq ($(BR2_PACKAGE_LIBMAD),y)
SOX_DEPENDENCIES += libmad
SOX_CONF_OPTS += --with-mad
else
SOX_CONF_OPTS += --without-mad
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
SOX_DEPENDENCIES += libpng
SOX_CONF_OPTS += --with-png
else
SOX_CONF_OPTS += --without-png
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
SOX_DEPENDENCIES += libsndfile
SOX_CONF_OPTS += --enable-sndfile
else
SOX_CONF_OPTS += --disable-sndfile
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
SOX_DEPENDENCIES += libvorbis
SOX_CONF_OPTS += --enable-oggvorbis
else
SOX_CONF_OPTS += --disable-oggvorbis
endif

ifeq ($(BR2_PACKAGE_OPENCORE_AMR),y)
SOX_DEPENDENCIES += opencore-amr
SOX_CONF_OPTS += --enable-amrwb --enable-amrnb
else
SOX_CONF_OPTS += --disable-amrwb --disable-amrnb
endif

ifeq ($(BR2_PACKAGE_OPUSFILE),y)
SOX_DEPENDENCIES += opusfile
SOX_CONF_OPTS += --enable-opus
else
SOX_CONF_OPTS += --disable-opus
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SOX_DEPENDENCIES += pulseaudio
SOX_CONF_OPTS += --enable-pulseaudio
else
SOX_CONF_OPTS += --disable-pulseaudio
endif

ifeq ($(BR2_PACKAGE_TWOLAME),y)
SOX_DEPENDENCIES += twolame
SOX_CONF_OPTS += --with-twolame
else
SOX_CONF_OPTS += --without-twolame
endif

ifeq ($(BR2_PACKAGE_WAVPACK),y)
SOX_DEPENDENCIES += wavpack
SOX_CONF_OPTS += --enable-wavpack
else
SOX_CONF_OPTS += --disable-wavpack
endif

$(eval $(autotools-package))
