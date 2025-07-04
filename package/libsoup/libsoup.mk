################################################################################
#
# libsoup
#
################################################################################

LIBSOUP_VERSION_MAJOR = 2.74
LIBSOUP_VERSION = $(LIBSOUP_VERSION_MAJOR).3
LIBSOUP_SOURCE = libsoup-$(LIBSOUP_VERSION).tar.xz
LIBSOUP_SITE = https://download.gnome.org/sources/libsoup/$(LIBSOUP_VERSION_MAJOR)
LIBSOUP_LICENSE = LGPL-2.0+
LIBSOUP_LICENSE_FILES = COPYING
LIBSOUP_CPE_ID_VENDOR = gnome
LIBSOUP_INSTALL_STAGING = YES
LIBSOUP_DEPENDENCIES = \
	host-intltool \
	host-libglib2 \
	host-pkgconf \
	libglib2 \
	libpsl \
	libxml2 \
	sqlite \
	$(TARGET_NLS_DEPENDENCIES)

# 0003-sniffer-fix-potential-overflow.patch
LIBSOUP_IGNORE_CVES += CVE-2025-2784
# 0004-headers-Strictly-dont-allow-NUL-bytes.patch
LIBSOUP_IGNORE_CVES += CVE-2024-52530
# 0005-headers-Be-more-robust-against-invalid-input.patch
LIBSOUP_IGNORE_CVES += CVE-2024-52531
# 0006-websocket-process-the-frame-as-soon-as-we-read-data.patch
LIBSOUP_IGNORE_CVES += CVE-2024-52532
# 0007-Fix-using-int-instead-of-size_t.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32050
# 0008-Fix-heap-buffer-overflow.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32052
# 0009-Fix-heap-buffer-overflow.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32053
# 0010-headers-Handle-parsing-only-newlines.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32906
# 0011-auth-digest-Handle-missing-realm-nonce.patch
# 0012-auth-digest-Handle-missing-nonce.patch
# 0013-auth-digest-Fix-leak.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32910
# 0014-CVE-2025-32911.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32911 CVE-2025-32913
# 0015-auth-digest-Handle-missing-nonce.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32912
# 0016-CVE-2025-32914.patch
LIBSOUP_IGNORE_CVES += CVE-2025-32914
# 0017-auth-digest-fix-crash.patch
LIBSOUP_IGNORE_CVES += CVE-2025-4476
# 0018-soup_header_parse_quality_list-Fix-leak.patch
LIBSOUP_IGNORE_CVES += CVE-2025-46420
# 0019-session-Strip-authentication-credentials.patch
LIBSOUP_IGNORE_CVES += CVE-2025-46421
# 0020-soup-multipart-Verify-boundary-limits.patch
LIBSOUP_IGNORE_CVES += CVE-2025-4948
# 0021-soup-multipart-Verify-array-bounds.patch
LIBSOUP_IGNORE_CVES += CVE-2025-4969

LIBSOUP_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

LIBSOUP_CONF_OPTS = \
	-Dgtk_doc=false \
	-Dntlm=disabled \
	-Dsysprof=disabled \
	-Dtests=false \
	-Dtls_check=false \
	-Dvapi=disabled

ifeq ($(BR2_PACKAGE_BROTLI),y)
LIBSOUP_CONF_OPTS += -Dbrotli=enabled
LIBSOUP_DEPENDENCIES += brotli
else
LIBSOUP_CONF_OPTS += -Dbrotli=disabled
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBSOUP_CONF_OPTS += -Dintrospection=enabled
LIBSOUP_DEPENDENCIES += gobject-introspection
else
LIBSOUP_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_LIBKRB5),y)
LIBSOUP_CONF_OPTS += \
	-Dgssapi=enabled \
	-Dkrb5_config=$(STAGING_DIR)/usr/bin/krb5-config
LIBSOUP_DEPENDENCIES += libkrb5
else
LIBSOUP_CONF_OPTS += -Dgssapi=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSOUP_GNOME),y)
LIBSOUP_CONF_OPTS += -Dgnome=true
else
LIBSOUP_CONF_OPTS += -Dgnome=false
endif

$(eval $(meson-package))
