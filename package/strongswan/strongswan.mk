################################################################################
#
# strongswan
#
################################################################################

STRONGSWAN_VERSION = 5.9.8
STRONGSWAN_SOURCE = strongswan-$(STRONGSWAN_VERSION).tar.bz2
STRONGSWAN_SITE = http://download.strongswan.org
STRONGSWAN_LICENSE = GPL-2.0+
STRONGSWAN_LICENSE_FILES = COPYING LICENSE
STRONGSWAN_CPE_ID_VENDOR = strongswan
STRONGSWAN_DEPENDENCIES = host-pkgconf
STRONGSWAN_INSTALL_STAGING = YES
STRONGSWAN_CONF_OPTS += \
	--without-lib-prefix \
	--enable-led \
	--enable-pkcs11=yes \
	--enable-kernel-netlink=yes \
	--enable-socket-default=yes \
	--enable-botan=$(if $(BR2_PACKAGE_STRONGSWAN_BOTAN),yes,no) \
	--enable-openssl=$(if $(BR2_PACKAGE_STRONGSWAN_OPENSSL),yes,no) \
	--enable-gcrypt=$(if $(BR2_PACKAGE_STRONGSWAN_GCRYPT),yes,no) \
	--enable-gmp=$(if $(BR2_PACKAGE_STRONGSWAN_GMP),yes,no) \
	--enable-af-alg=$(if $(BR2_PACKAGE_STRONGSWAN_AF_ALG),yes,no) \
	--enable-curl=$(if $(BR2_PACKAGE_STRONGSWAN_CURL),yes,no) \
	--enable-charon=$(if $(BR2_PACKAGE_STRONGSWAN_CHARON),yes,no) \
	--enable-tnccs-11=$(if $(BR2_PACKAGE_STRONGSWAN_TNCCS_11),yes,no) \
	--enable-tnccs-20=$(if $(BR2_PACKAGE_STRONGSWAN_TNCCS_20),yes,no) \
	--enable-tnccs-dynamic=$(if $(BR2_PACKAGE_STRONGSWAN_TNCCS_DYNAMIC),yes,no) \
	--enable-eap-sim-pcsc=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIM_PCSC),yes,no) \
	--enable-unity=$(if $(BR2_PACKAGE_STRONGSWAN_UNITY),yes,no) \
	--enable-stroke=$(if $(BR2_PACKAGE_STRONGSWAN_STROKE),yes,no) \
	--enable-sql=$(if $(BR2_PACKAGE_STRONGSWAN_SQL),yes,no) \
	--enable-pki=$(if $(BR2_PACKAGE_STRONGSWAN_PKI),yes,no) \
	--enable-scepclient=$(if $(BR2_PACKAGE_STRONGSWAN_SCEP),yes,no) \
	--enable-scripts=$(if $(BR2_PACKAGE_STRONGSWAN_SCRIPTS),yes,no) \
	--enable-vici=$(if $(BR2_PACKAGE_STRONGSWAN_VICI),yes,no) \
	--enable-swanctl=$(if $(BR2_PACKAGE_STRONGSWAN_VICI),yes,no) \
	--enable-wolfssl=$(if $(BR2_PACKAGE_STRONGSWAN_WOLFSSL),yes,no) \
	--enable-md4=$(if $(BR2_PACKAGE_STRONGSWAN_MD4),yes,no) \
	--enable-systime-fix=$(if $(BR2_PACKAGE_STRONGSWAN_SYSTIME_FIX),yes,no) \
	--enable-eap-sim=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIM),yes,no) \
	--enable-eap-sim-file=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIM_FILE),yes,no) \
	--enable-eap-aka=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_AKA),yes,no) \
	--enable-eap-aka-3gpp2=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_AKA_3GPP2),yes,no) \
	--enable-eap-simaka-sql=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIMAKA_SQL),yes,no) \
	--enable-eap-simaka-pseudonym=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIMAKA_PSEUDONYM),yes,no) \
	--enable-eap-simaka-reauth=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIMAKA_REAUTH),yes,no) \
	--enable-eap-identity=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_IDENTITY),yes,no) \
	--enable-eap-md5=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_MD5),yes,no) \
	--enable-eap-gtc=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_GTC),yes,no) \
	--enable-eap-mschapv2=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_MSCHAPV2),yes,no) \
	--enable-eap-tls=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_TLS),yes,no) \
	--enable-eap-ttls=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_TTLS),yes,no) \
	--enable-eap-peap=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_PEAP),yes,no) \
	--enable-eap-tnc=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_TNC),yes,no) \
	--enable-eap-dynamic=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_DYNAMIC),yes,no) \
	--enable-eap-radius=$(if $(BR2_PACKAGE_STRONGSWAN_EAP_RADIUS),yes,no) \
	--enable-bypass-lan=$(if $(BR2_PACKAGE_STRONGSWAN_BYPASS_LAN),yes,no) \
	--with-ipseclibdir=/usr/lib \
	--with-plugindir=/usr/lib/ipsec/plugins \
	--with-imcvdir=/usr/lib/ipsec/imcvs \
	--with-dev-headers=/usr/include

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
STRONGSWAN_CONF_ENV += LIBS='-latomic'
endif

STRONGSWAN_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_STRONGSWAN_BOTAN),botan) \
	$(if $(BR2_PACKAGE_STRONGSWAN_OPENSSL),openssl) \
	$(if $(BR2_PACKAGE_STRONGSWAN_GCRYPT),libgcrypt) \
	$(if $(BR2_PACKAGE_STRONGSWAN_GMP),gmp) \
	$(if $(BR2_PACKAGE_STRONGSWAN_EAP_AKA_3GPP2),gmp) \
	$(if $(BR2_PACKAGE_STRONGSWAN_CURL),libcurl) \
	$(if $(BR2_PACKAGE_STRONGSWAN_TNCCS_11),libxml2) \
	$(if $(BR2_PACKAGE_STRONGSWAN_EAP_SIM_PCSC),pcsc-lite) \
	$(if $(BR2_PACKAGE_STRONGSWAN_WOLFSSL),wolfssl)

ifeq ($(BR2_PACKAGE_STRONGSWAN_SQL),y)
STRONGSWAN_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_SQLITE),sqlite) \
	$(if $(BR2_PACKAGE_MYSQL),mysql)
endif

# disable connmark/forecast until net/if.h vs. linux/if.h conflict resolved
# problem exist since linux 4.5 header changes
STRONGSWAN_CONF_OPTS += \
	--disable-connmark \
	--disable-forecast

$(eval $(autotools-package))
