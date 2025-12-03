################################################################################
#
# graphite2
#
################################################################################

GRAPHITE2_VERSION = 1.3.14-121-g142e1bda3439d2bd376bcac9c2b247c9532bacde
GRAPHITE2_SITE = $(call github,silnrsi,graphite,$(GRAPHITE2_VERSION))
GRAPHITE2_INSTALL_STAGING = YES
GRAPHITE2_LICENSE = LGPL-2.1+
GRAPHITE2_LICENSE_FILES = LICENSE
GRAPHITE2_CPE_ID_VENDOR = sil

# Avoid building docs and tests to save time
define GRAPHITE2_DISABLE_TESTS_DOC
	$(SED) '/^add_subdirectory(doc)/d' \
		-e '/^add_subdirectory(tests)/d' \
		-e '/add_subdirectory(gr2fonttest)/d' \
		$(@D)/CMakeLists.txt
endef
GRAPHITE2_POST_PATCH_HOOKS += GRAPHITE2_DISABLE_TESTS_DOC

$(eval $(cmake-package))
