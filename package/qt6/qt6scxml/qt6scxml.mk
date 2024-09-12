################################################################################
#
# qt6scxml
#
################################################################################

QT6SCXML_VERSION = $(QT6_VERSION)
QT6SCXML_SITE = $(QT6_SITE)
QT6SCXML_SOURCE = qtscxml-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6SCXML_VERSION).tar.xz
QT6SCXML_INSTALL_STAGING = YES
QT6SCXML_SUPPORTS_IN_SOURCE_BUILD = NO
QT6SCXML_CMAKE_BACKEND = ninja

QT6SCXML_LICENSE = \
	BSD-3-Clause (buildsystem, examples, snippets) \
	GFDL-1.3-no-invariants (docs), \
	GPL-2.0 or GPL-3.0 or LGPL-3.0, \
	GPL-3.0 with exception (tools), \
	GPL-3.0 (tests)

QT6SCXML_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/Qt-GPL-exception-1.0.txt

QT6SCXML_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6SCXML_DEPENDENCIES = \
	host-qt6scxml \
	qt6base

HOST_QT6SCXML_DEPENDENCIES = \
	host-qt6base

# When we have support for qt6declarative in target qt6scxml, we also
# need it in the host qt6scxml.
ifeq ($(BR2_PACKAGE_QT6DECLARATIVE),y)
QT6SCXML_DEPENDENCIES += qt6declarative
HOST_QT6SCXML_DEPENDENCIES += host-qt6declarative
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
