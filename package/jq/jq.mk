################################################################################
#
# jq
#
################################################################################

JQ_VERSION = 1.8.0
JQ_SITE = https://github.com/jqlang/jq/releases/download/jq-$(JQ_VERSION)
JQ_LICENSE = MIT (code), ICU (decNumber), CC-BY-3.0 (documentation)
JQ_LICENSE_FILES = COPYING
JQ_CPE_ID_VALID = YES
JQ_INSTALL_STAGING = YES

# uses c99 specific features
JQ_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=c99"
HOST_JQ_CONF_ENV += CFLAGS="$(HOST_CFLAGS) -std=c99"

HOST_JQ_CONF_OPTS += --without-oniguruma

ifeq ($(BR2_PACKAGE_ONIGURUMA),y)
JQ_DEPENDENCIES += oniguruma
JQ_CONF_OPTS += --with-oniguruma
else
JQ_CONF_OPTS += --without-oniguruma
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
