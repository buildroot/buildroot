################################################################################
#
# ntpsec
#
################################################################################

NTPSEC_VERSION = 1.2.2
NTPSEC_SOURCE = ntpsec-NTPsec_$(subst .,_,$(NTPSEC_VERSION)).tar.bz2
NTPSEC_SITE = https://gitlab.com/NTPsec/ntpsec/-/archive/NTPsec_$(subst .,_,$(NTPSEC_VERSION))
NTPSEC_LICENSE = BSD-2-Clause, NTP, BSD-3-Clause, MIT, CC-BY-4.0 (docs)
NTPSEC_LICENSE_FILES = \
	LICENSES/BSD-2 \
	LICENSES/BSD-3 \
	LICENSES/CC-BY-4.0 \
	LICENSES/MIT \
	LICENSES/NTP \
	docs/copyright.adoc

NTPSEC_CPE_ID_VENDOR = ntpsec

NTPSEC_DEPENDENCIES = \
	host-bison \
	host-pkgconf \
	python3 \
	libcap \
	openssl

# CC="$(HOSTCC)" is strange but needed to build some host tools, the
# cross-compiler will properly be used to build target code thanks to
# --cross-compiler
NTPSEC_CONF_OPTS = \
	CC="$(HOSTCC)" \
	PYTHON_CONFIG="$(STAGING_DIR)/usr/bin/python3-config" \
	--libdir=/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/ntp \
	--cross-compiler="$(TARGET_CC)" \
	--cross-cflags="$(TARGET_CFLAGS) -std=gnu99" \
	--cross-ldflags="$(TARGET_LDFLAGS)" \
	--notests \
	--enable-early-droproot \
	--disable-mdns-registration \
	--enable-pylib=ffi \
	--nopyc \
	--nopyo \
	--nopycache \
	--disable-doc \
	--disable-manpage

ifeq ($(BR2_PACKAGE_NTPSEC_CLASSIC_MODE),y)
NTPSEC_CONF_OPTS += --enable-classic-mode
endif

# no '--enable-nts' option available
ifeq ($(BR2_PACKAGE_NTPSEC_NTS),)
NTPSEC_CONF_OPTS += --disable-nts
endif

# refclocks are disabled by default, can only be enabled
ifeq ($(BR2_PACKAGE_NTPSEC_REFCLOCK_ALL),y)
NTPSEC_DEPENDENCIES += pps-tools
NTPSEC_CONF_OPTS += --refclock=all
endif

define NTPSEC_INSTALL_NTPSEC_CONF
	$(INSTALL) -m 644 package/ntpsec/ntpd.etc.conf $(TARGET_DIR)/etc/ntp.conf
endef
NTPSEC_POST_INSTALL_TARGET_HOOKS += NTPSEC_INSTALL_NTPSEC_CONF

define NTPSEC_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/ntpsec/S49ntpd $(TARGET_DIR)/etc/init.d/S49ntpd
endef

define NTPSEC_USERS
	ntp -1 ntp -1 * - - - ntpd user
endef

$(eval $(waf-package))
