################################################################################
#
# pamtester
#
################################################################################

PAMTESTER_VERSION = 0.1.2
PAMTESTER_SITE = https://download.sourceforge.net/project/pamtester/pamtester/$(PAMTESTER_VERSION)
PAMTESTER_DEPENDENCIES = linux-pam
PAMTESTER_LICENSE = BSD-3-Clause
PAMTESTER_LICENSE_FILES = LICENSE

# Obsolete constructs in the archaic configure.in generated an outworn
# configure script that incorrectly searches a C++ compiler. Regenerate
# the autoconf machinery to avoid failures without a C++ compiler.
PAMTESTER_AUTORECONF = YES

$(eval $(autotools-package))
