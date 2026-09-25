################################################################################
#
# qt6
#
################################################################################

QT6_VERSION_MAJOR = 6.11
QT6_VERSION = $(QT6_VERSION_MAJOR).2
QT6_SOURCE_TARBALL_PREFIX = everywhere-src
QT6_SITE = https://download.qt.io/archive/qt/$(QT6_VERSION_MAJOR)/$(QT6_VERSION)/submodules

QT6_GIT = git://code.qt.io

include $(sort $(wildcard package/qt6/*/*.mk))

# The file "qt.conf" can be used to override the hard-coded paths that are
# compiled into the Qt library. We need it to make "qmake" relocatable and
# tweak the per-package install paths
define QT6_INSTALL_QT_CONF
	rm -f $(HOST_DIR)/bin/qt.conf
	sed -e "s|@@HOST_DIR@@|$(HOST_DIR)|" -e "s|@@STAGING_DIR@@|$(STAGING_DIR)|" \
		$(QT6BASE_PKGDIR)/qt.conf.in > $(HOST_DIR)/bin/qt.conf
endef

ifeq ($(BR2_PER_PACKAGE_DIRECTORIES),y)
define QT6_QT_CONF_FIXUP
	$(QT6_INSTALL_QT_CONF)
endef
endif

# Variable for other Qt applications to use
QT6_QMAKE = $(HOST_DIR)/bin/qmake -spec devices/linux-buildroot-g++
