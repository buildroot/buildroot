################################################################################
#
# dovecot-pigeonhole
#
################################################################################

DOVECOT_PIGEONHOLE_VERSION_MAJOR = 2.4
DOVECOT_PIGEONHOLE_VERSION = $(DOVECOT_PIGEONHOLE_VERSION_MAJOR).5
DOVECOT_PIGEONHOLE_SITE = https://pigeonhole.dovecot.org/releases/$(DOVECOT_PIGEONHOLE_VERSION_MAJOR)
DOVECOT_PIGEONHOLE_LICENSE = LGPL-2.1
DOVECOT_PIGEONHOLE_LICENSE_FILES = COPYING
DOVECOT_PIGEONHOLE_CPE_ID_VENDOR = dovecot
DOVECOT_PIGEONHOLE_CPE_ID_PRODUCT = pigeonhole
DOVECOT_PIGEONHOLE_DEPENDENCIES = dovecot

DOVECOT_PIGEONHOLE_CONF_OPTS = --with-dovecot=$(STAGING_DIR)/usr/lib

# fix path to avoid using /usr/lib/dovecot
define DOVECOT_PIGEONHOLE_POST_CONFIGURE
	$(SED) 's%^dovecot_pkglibexecdir =.*%dovecot_pkglibexecdir = $(STAGING_DIR)/usr/libexec%' $(@D)/src/plugins/settings/Makefile
endef
DOVECOT_PIGEONHOLE_POST_CONFIGURE_HOOKS += DOVECOT_PIGEONHOLE_POST_CONFIGURE

$(eval $(autotools-package))
