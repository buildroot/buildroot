################################################################################
#
# tclbonjour
#
################################################################################

TCLBONJOUR_VERSION       = 1.2.1
TCLBONJOUR_SOURCE        = tcl_bonjour-$(TCLBONJOUR_VERSION).tar.gz
TCLBONJOUR_SITE          = $(call github,eviltwinskippy,tcl_bonjour,$(TCLBONJOUR_VERSION))
#TCLBONJOUR_SITE          = https://github.com/eviltwinskippy/tcl_bonjour/archive/1.2.1.tar.gz
#https://github.com/eviltwinskippy/tcl_bonjour/archive/$(TCLBONJOUR_VERSION).tar.gz

TCLBONJOUR_LICENSE       = tcl license
TCLBONJOUR_LICENSE_FILES = license.terms
TCLBONJOUR_DEPENDENCIES  = host-tcl
TCLBONJOUR_DEPENDENCIES  += avahi
TCLBONJOUR_CONF_ENV      = ac_cv_path_tclsh="$(HOST_DIR)/usr/bin/tclsh8.6"
#TCLBONJOUR_CONF_OPT 	 = --oldincludedir="$(HOST_DIR)/usrc

define TCLBONJOUR_FIX_COMPAT
	
endef

TCLBONJOUR_PRE_CONFIGURE_HOOKS += TCLBONJOUR_FIX_COMPAT

$(eval $(autotools-package))
