################################################################################
#
# p11-kit
#
################################################################################

P11_KIT_VERSION = 0.26.5
P11_KIT_SOURCE = p11-kit-$(P11_KIT_VERSION).tar.xz
P11_KIT_SITE = https://github.com/p11-glue/p11-kit/releases/download/$(P11_KIT_VERSION)
P11_KIT_DEPENDENCIES = host-pkgconf
P11_KIT_INSTALL_STAGING = YES
P11_KIT_LICENSE = BSD-3-Clause
P11_KIT_LICENSE_FILES = COPYING
P11_KIT_CPE_ID_VALID = YES

P11_KIT_CONF_OPTS = -Dtest=false

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
P11_KIT_CONF_OPTS += -Dnls=true
P11_KIT_DEPENDENCIES += $(TARGET_NLS_DEPENDENCIES)
else
P11_KIT_CONF_OPTS += -Dnls=false
endif

ifeq ($(BR2_PACKAGE_LIBFFI),y)
P11_KIT_DEPENDENCIES += host-pkgconf libffi
P11_KIT_CONF_OPTS += -Dlibffi=enabled
else
P11_KIT_CONF_OPTS += -Dlibffi=disabled
endif

ifeq ($(BR2_PACKAGE_LIBTASN1),y)
# host-libtasn1 is needed to provide asn1Parser
P11_KIT_DEPENDENCIES += host-pkgconf host-libtasn1 libtasn1
P11_KIT_CONF_OPTS += -Dtrust_module=enabled
ifeq ($(BR2_PACKAGE_CA_CERTIFICATES),y)
P11_KIT_CONF_OPTS += -Dtrust_paths=/etc/ssl/certs/ca-certificates.crt
else
P11_KIT_CONF_OPTS += -Dtrust_paths=
endif
else
P11_KIT_CONF_OPTS += -Dtrust_module=disabled
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
P11_KIT_CONF_OPTS += \
	-Dsystemd=enabled \
	-Dsystemduserunitdir=/usr/lib/systemd/user
else
P11_KIT_CONF_OPTS += -Dsystemd=disabled
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
P11_KIT_DEPENDENCIES += bash-completion
P11_KIT_CONF_OPTS += -Dbash_completion=enabled
else
P11_KIT_CONF_OPTS += -Dbash_completion=disabled
endif

HOST_P11_KIT_DEPENDENCIES = host-pkgconf
HOST_P11_KIT_CONF_OPTS = \
	-Dtest=false \
	-Dnls=false \
	-Dlibffi=disabled \
	-Dtrust_paths= \
	-Dtrust_module=disabled \
	-Dsystemd=disabled \
	-Dbash_completion=disabled

$(eval $(meson-package))
$(eval $(host-meson-package))
