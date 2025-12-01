################################################################################
#
# riemann-c-client
#
################################################################################

RIEMANN_C_CLIENT_VERSION = 2.2.2
RIEMANN_C_CLIENT_SITE = https://git.madhouse-project.org/algernon/riemann-c-client/archive
RIEMANN_C_CLIENT_LICENSE = \
	Apache-2.0 (lib/riemann/proto/), \
	EUPL-1.2
RIEMANN_C_CLIENT_LICENSE_FILES = \
	LICENSES/Apache-2.0.txt \
	LICENSES/EUPL-1.2.txt
RIEMANN_C_CLIENT_INSTALL_STAGING = YES
RIEMANN_C_CLIENT_MAKE = $(MAKE1)
# From git
RIEMANN_C_CLIENT_AUTORECONF = YES
RIEMANN_C_CLIENT_DEPENDENCIES = \
	host-pkgconf protobuf-c \
	$(if $(BR2_PACKAGE_JSON_C),json-c)

ifeq ($(BR2_PACKAGE_GNUTLS),y)
RIEMANN_C_CLIENT_CONF_OPTS += --with-tls=gnutls
RIEMANN_C_CLIENT_DEPENDENCIES += gnutls
else ifeq ($(BR2_PACKAGE_OPENSSL),y)
RIEMANN_C_CLIENT_CONF_OPTS += --with-tls=openssl
RIEMANN_C_CLIENT_DEPENDENCIES += openssl
else ifeq ($(BR2_PACKAGE_WOLFSSL),y)
RIEMANN_C_CLIENT_CONF_OPTS += --with-tls=wolfssl
RIEMANN_C_CLIENT_DEPENDENCIES += wolfssl
else
RIEMANN_C_CLIENT_CONF_OPTS += --without-tls
endif

$(eval $(autotools-package))
