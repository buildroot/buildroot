################################################################################
#
# basu
#
################################################################################

BASU_VERSION = 0.2.1
BASU_SITE = https://git.sr.ht/~emersion/basu/refs/download/v$(BASU_VERSION)
BASU_INSTALL_STAGING = YES
BASU_LICENSE = LGPL-2.1+
BASU_LICENSE_FILES = LICENSE.LGPL2.1
BASU_DEPENDENCIES = host-gperf

ifeq ($(BR2_PACKAGE_LIBCAP),y)
BASU_DEPENDENCIES += libcap
BASU_CONF_OPTS += -Dlibcap=enabled
else
BASU_CONF_OPTS += -Dlibcap=disabled
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
BASU_DEPENDENCIES += audit
BASU_CONF_OPTS += -Daudit=enabled
else
BASU_CONF_OPTS += -Daudit=disabled
endif

$(eval $(meson-package))
