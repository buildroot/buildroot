################################################################################
#
# nettest
#
################################################################################

NETTEST_VERSION = 2.1.3
NETTEST_SITE = $(call github,specure,nettest,v$(NETTEST_VERSION))
NETTEST_LICENSE = Apache-2.0
NETTEST_LICENSE_FILES = LICENSE.txt

$(eval $(cargo-package))
