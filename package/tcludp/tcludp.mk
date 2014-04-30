################################################################################
#
# TCLUDP
#
################################################################################

TCLUDP_VERSION       = trunk
TCLUDP_SOURCE        = tcludp-$(TCLVFS_VERSION).tar.gz
TCLUDP_SITE_METHOD   = wget
TCLUDP_SITE          = http://fossil.etoyoc.com/fossil/tcludp/tarball/
TCLUDP_LICENSE       = tcl license
TCLUDP_LICENSE_FILES = license.terms
TCLUDP_DEPENDENCIES  = host-tcl
TCLUDP_CONF_ENV      = ac_cv_path_tclsh="$(HOST_DIR)/usr/bin/tclsh8.6"

$(eval $(autotools-package))
