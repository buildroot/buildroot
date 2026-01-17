################################################################################
#
# ftxui
#
################################################################################

FTXUI_VERSION = 6.1.9
FTXUI_SITE = $(call github,ArthurSonzogni,FTXUI,v$(FTXUI_VERSION))
FTXUI_LICENSE = MIT
FTXUI_LICENSE_FILES = LICENSE

FTXUI_INSTALL_STAGING = YES

FTXUI_CONF_OPTS = \
	-DFTXUI_BUILD_DOCS=OFF \
	-DFTXUI_BUILD_EXAMPLES=OFF \
	-DFTXUI_BUILD_TESTS=OFF \
	-DFTXUI_BUILD_TESTS_FUZZER=OFF \
	-DFTXUI_CLANG_TIDY=OFF \
	-DFTXUI_DEV_WARNINGS=OFF \
	-DFTXUI_ENABLE_COVERAGE=OFF \
	-DFTXUI_ENABLE_INSTALL=ON \
	-DFTXUI_QUIET=OFF

$(eval $(cmake-package))
