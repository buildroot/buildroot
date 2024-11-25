################################################################################
#
# ntpsec
#
################################################################################

NTPSEC_VERSION = 1.2.3
NTPSEC_SOURCE = ntpsec-NTPsec_$(subst .,_,$(NTPSEC_VERSION)).tar.bz2
NTPSEC_SITE = https://gitlab.com/NTPsec/ntpsec/-/archive/NTPsec_$(subst .,_,$(NTPSEC_VERSION))
NTPSEC_LICENSE = Apache-2.0, \
	Beerware, \
	BSD-2-Clause.txt, \
	BSD-3-Clause.txt, \
	BSD-4-Clause.txt, \
	ISC.txt, \
	MIT.txt, \
	NTP.txt, \
	CC-BY-4.0.txt (docs)
NTPSEC_LICENSE_FILES = \
	LICENSES/Apache-2.0.txt \
	LICENSES/Beerware.txt \
	LICENSES/BSD-2-Clause.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/BSD-4-Clause.txt \
	LICENSES/ISC.txt \
	LICENSES/MIT.txt \
	LICENSES/NTP.txt \
	LICENSES/CC-BY-4.0.txt \
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
	CFLAGS="$(HOST_CFLAGS)" \
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
