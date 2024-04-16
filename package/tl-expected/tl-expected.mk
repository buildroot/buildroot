################################################################################
#
# tl-expected
#
################################################################################

TL_EXPECTED_VERSION = v1.0.0
TL_EXPECTED_SITE = https://github.com/TartanLlama/expected
TL_EXPECTED_SITE_METHOD = git
TL_EXPECTED_GIT_SUBMODULES = YES
TL_EXPECTED_LICENSE = CC0-1.0
TL_EXPECTED_LICENSE_FILES = COPYING
TL_EXPECTED_INSTALL_STAGING = YES
TL_EXPECTED_INSTALL_TARGET = NO
TL_EXPECTED_CONF_OPTS = \
	-DCMAKE_MODULE_PATH=$(TL_EXPECTED_DIR)/cmake/tl-cmake \
	-DEXPECTED_ENABLE_TESTS=OFF \
	-DFETCHCONTENT_FULLY_DISCONNECTED=ON

$(eval $(cmake-package))
