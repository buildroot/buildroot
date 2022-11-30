################################################################################
#
# softhsm2
#
################################################################################

SOFTHSM2_VERSION = 2.6.1
SOFTHSM2_SOURCE = softhsm-$(SOFTHSM2_VERSION).tar.gz
SOFTHSM2_SITE = https://dist.opendnssec.org/source
SOFTHSM2_LICENSE = BSD-2-Clause
SOFTHSM2_LICENSE_FILES = LICENSE
SOFTHSM2_DEPENDENCIES = openssl
SOFTHSM2_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_P11_KIT),y)
SOFTHSM2_CONF_OPTS += \
	--enable-p11-kit \
	--with-p11-kit=/usr/share/p11-kit/modules
SOFTHSM2_DEPENDENCIES += p11-kit
else
SOFTHSM2_CONF_OPTS += --disable-p11-kit
endif

$(eval $(autotools-package))
