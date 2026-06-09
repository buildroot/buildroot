################################################################################
#
# qt6grpc
#
################################################################################

QT6GRPC_VERSION = $(QT6_VERSION)
QT6GRPC_SITE = $(QT6_SITE)
QT6GRPC_SOURCE = qtgrpc-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6GRPC_VERSION).tar.xz
QT6GRPC_INSTALL_STAGING = YES
QT6GRPC_SUPPORTS_IN_SOURCE_BUILD = NO
QT6GRPC_CMAKE_BACKEND = ninja
QT6GRPC_LICENSE = GPL-3.0-only

QT6GRPC_LICENSE_FILES = \
	LICENSE.Apache-2.0.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LicenseRef-protobuf.txt \
	LICENSES/Qt-GPL-exception-1.0.txt

QT6GRPC_CONF_OPTS = \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_HOST_PATH=$(HOST_DIR)

QT6GRPC_DEPENDENCIES = \
	host-pkgconf \
	host-qt6grpc \
	qt6base

ifeq ($(BR2_PACKAGE_QT6DECLARATIVE),y)
QT6GRPC_DEPENDENCIES += qt6declarative
endif

HOST_QT6GRPC_DEPENDENCIES = \
	host-protobuf \
	host-qt6base

$(eval $(cmake-package))
$(eval $(host-cmake-package))
